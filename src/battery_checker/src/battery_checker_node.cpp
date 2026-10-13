#include <ros/ros.h>
#include <serial/serial.h>
#include <std_msgs/Float32.h>
#include <std_msgs/Bool.h>
#include <std_msgs/Int32.h>
#include <vector>
#include <cstdint>

serial::Serial batterySerial_;
ros::Publisher requestBatteryPublisher_;

// 수신 데이터 파싱용 구조체
struct BatteryState {
    float voltage = 0.0f;
    float current = 0.0f;
    float soc = 0.0f;
    float soh = 0.0f;
    float temperature = 0.0f;
    bool isCharging = false;
    bool isDockConnected = false;
    bool valid = false;
};

void batterySerialInitialize() {
    try {
        batterySerial_.setPort("/dev/ttyBattery");
        batterySerial_.setBaudrate(19200);
        serial::Timeout to = serial::Timeout::simpleTimeout(5000);
        batterySerial_.setTimeout(to);
        batterySerial_.open();
    } catch (serial::IOException& e) {
        ROS_ERROR_STREAM("Unable to open battery serial port.");
    }

    if (batterySerial_.isOpen()) {
        ROS_INFO_STREAM("Battery serial Port initialized.");
    } else {
        ROS_ERROR_STREAM("Can not open battery serial port.");
    }
}

void batteryCallback(const std_msgs::Int32::ConstPtr& msg) {
    // [요청 패킷 구성]
    // Kind 1 (0x4F): 전압(Bit0), 전류(Bit1), SOC(Bit2), 배터리상태(Bit3), 온도(Bit6) 요청
    // Kind 2 (0x01): SOH(Bit0) 요청
    std::vector<uint8_t> txBuffer(11);
    txBuffer[0] = 0xAF; // Start
    txBuffer[1] = 0xFA;
    txBuffer[2] = 0x60; // Address
    txBuffer[3] = 0x05; // Length
    txBuffer[4] = 0x01; // Command (상태 요청)
    txBuffer[5] = 0x60; // Order
    txBuffer[6] = 0x4F; // Kind 1
    txBuffer[7] = 0x01; // Kind 2
    
    // Checksum = Address + Length + Command + Order + Kind1 + Kind2
    txBuffer[8] = static_cast<uint8_t>(txBuffer[2] + txBuffer[3] + txBuffer[4] + 
                                       txBuffer[5] + txBuffer[6] + txBuffer[7]); 
    txBuffer[9] = 0xAF; // End
    txBuffer[10] = 0xA0;

    if(batterySerial_.isOpen()) {
        batterySerial_.write(txBuffer);
    }
}

BatteryState parseBatteryMessage(const std::vector<uint8_t>& buffer) {
    BatteryState state;
    
    // 최소 길이 검증 (요청 데이터 항목 6개 * 2 bytes = 12 bytes + 오버헤드 9 bytes = 총 21 bytes)
    if (buffer.size() < 21) return state;

    // 헤더(0xAF 0xFA) 및 응답 커맨드(0x03) 검증
    if (buffer[0] != 0xAF || buffer[1] != 0xFA || buffer[4] != 0x03) return state;

    // 체크섬(Checksum) 검증 로직
    uint8_t checksum = 0;
    for (size_t i = 2; i <= 17; ++i) {
        checksum += buffer[i];
    }
    if (checksum != buffer[18]) {
        ROS_WARN("Battery Protocol Checksum Error");
        return state;
    }

    // [데이터 파싱] 요청 순서대로 응답 수신
    // 1. 전압 (Scale 0.01)
    state.voltage = ((buffer[6] << 8) | buffer[7]) * 0.01f;
    // 2. 전류 (음수 처리 위해 int16_t 변환, Scale 0.01)
    state.current = static_cast<int16_t>((buffer[8] << 8) | buffer[9]) * 0.01f;
    // 3. SOC (Scale 1)
    state.soc     = ((buffer[10] << 8) | buffer[11]) * 1.0f;
    // 4. 배터리 상태 플래그 (현재 맵핑 제외, 버퍼 12~13 할당)
    // 5. 온도 (음수 처리 위해 int16_t 변환, Scale 0.1)
    state.temperature = static_cast<int16_t>((buffer[14] << 8) | buffer[15]) * 0.1f;
    // 6. SOH (Scale 1)
    state.soh     = ((buffer[16] << 8) | buffer[17]) * 1.0f;

    // 충전 및 도크 인식 판단 (충전 전류 > 0 일 때 True)
    if (state.current > 0.0f) {
        state.isCharging = true;
        state.isDockConnected = true; 
    } else {
        state.isCharging = false;
        state.isDockConnected = false;
    }

    state.valid = true;
    return state;
}

void pubBatteryCheckCallback(const ros::TimerEvent& e) {
    std_msgs::Int32 msg;
    msg.data = 1;
    requestBatteryPublisher_.publish(msg);
}

int main(int argc, char** argv) {
    ros::init(argc, argv, "battery_checker_node");
    ros::NodeHandle nh;
    
    // 시리얼 버퍼 파싱을 위해 loop rate를 10Hz로 상향 조정 권장
    ros::Rate loop_rate(10); 

    ros::Subscriber subRequest = nh.subscribe("/requestBattery", 10, batteryCallback);
    requestBatteryPublisher_   = nh.advertise<std_msgs::Int32>("/requestBattery", 10);

    // Publisher 선언부
    ros::Publisher pubSoc  = nh.advertise<std_msgs::Float32>("/batterySoc", 10);
    ros::Publisher pubCur  = nh.advertise<std_msgs::Float32>("/batteryCur", 10);
    ros::Publisher pubVol  = nh.advertise<std_msgs::Float32>("/batteryVol", 10);
    ros::Publisher pubSoh  = nh.advertise<std_msgs::Float32>("/batterySoh", 10);
    ros::Publisher pubTemp = nh.advertise<std_msgs::Float32>("/batteryTemperature", 10);
    // ros::Publisher pubIsChg = nh.advertise<std_msgs::Bool>("/isCharging", 10);
    // ros::Publisher pubIsDoc = nh.advertise<std_msgs::Bool>("/isDockConnected", 10);

    // 1초 주기로 상태 요청 명령 송신
    ros::Timer timer = nh.createTimer(ros::Duration(1.0), pubBatteryCheckCallback);

    batterySerialInitialize();

    std::vector<uint8_t> rxBuffer;

    while(ros::ok()) {
        ros::spinOnce();

        if (batterySerial_.isOpen() && batterySerial_.available()) {
            std::vector<uint8_t> new_data;
            batterySerial_.read(new_data, batterySerial_.available());
            rxBuffer.insert(rxBuffer.end(), new_data.begin(), new_data.end());
            
            // 수신 버퍼 내 완전한 프레임(21 Bytes 이상) 확인
            while (rxBuffer.size() >= 21) {
                // 패킷의 시작점 탐색
                if (rxBuffer[0] == 0xAF && rxBuffer[1] == 0xFA) {
                    BatteryState state = parseBatteryMessage(rxBuffer);
                    
                    if (state.valid) {
                        std_msgs::Float32 msgF32;
                        std_msgs::Bool msgBool;

                        msgF32.data = state.soc; pubSoc.publish(msgF32);
                        msgF32.data = state.current; pubCur.publish(msgF32);
                        msgF32.data = state.voltage; pubVol.publish(msgF32);
                        msgF32.data = state.soh; pubSoh.publish(msgF32);
                        msgF32.data = state.temperature; pubTemp.publish(msgF32);

                        //msgBool.data = state.isCharging; pubIsChg.publish(msgBool);
                        //msgBool.data = state.isDockConnected; pubIsDoc.publish(msgBool);
                        
                        ROS_INFO("Vol: %.1fV, Cur: %.1fA, SOC: %.1f%%, SOH: %.1f%%, Temp: %.1fC", 
                                  state.voltage, state.current, state.soc, state.soh, state.temperature);
                    }
                    // 성공/실패 여부에 관계없이 처리된 21바이트 패킷 제거
                    rxBuffer.erase(rxBuffer.begin(), rxBuffer.begin() + 21);
                } else {
                    // 헤더가 일치하지 않으면 쓰레기값으로 간주하고 첫 1바이트씩 폐기 후 재탐색
                    rxBuffer.erase(rxBuffer.begin());
                }
            }
        }
        loop_rate.sleep();
    }
    return 0;
}