#include <ros/ros.h>
#include <serial/serial.h>
#include <std_msgs/Int32.h>
#include <std_msgs/String.h>
#include <sensor_msgs/Range.h>

#include <vector>
#include <iostream>
#include <algorithm>

serial::Serial bleSerial_;
ros::Publisher sonar_pubs[8];
ros::Publisher bleRawResponsePub;

void bleSerialInitialize() {
    try {
        bleSerial_.setPort("/dev/ttyMycomDebugger");
        bleSerial_.setBaudrate(115200);
        serial::Timeout to = serial::Timeout::simpleTimeout(1000);
        bleSerial_.setTimeout(to);
        bleSerial_.open();
    } catch (serial::IOException& e) {
        ROS_ERROR_STREAM("Unable to open BLE serial port");
    }

    if (bleSerial_.isOpen()) {
        ROS_INFO_STREAM("BLE serial port initialized");
    } else {
        ROS_ERROR_STREAM("BLE serial port failed to open");
    }
}

void parkingStartCallback(const std_msgs::Int32 &msg)
{
    //ROS_INFO_STREAM("Recieved number from display request : " << msg->data);

    int recievedNumber = msg.data;
    
    unsigned char* transmissionBuffer = new unsigned char[6];

    transmissionBuffer[0] = 0xAF;
    transmissionBuffer[1] = 0xFA;
    transmissionBuffer[2] = 0x01;
    transmissionBuffer[3] = 0x00;
    transmissionBuffer[4] = 0xAF;
    transmissionBuffer[5] = 0xB0;
    
    bleSerial_.write(transmissionBuffer, 6);

    std::cout << "parking_start" << std::endl;
}


void journeyStartCallback(const std_msgs::Int32 &msg){
    int recievedNumber = msg.data;
    
    unsigned char* transmissionBuffer = new unsigned char[6];

    transmissionBuffer[0] = 0xAF;
    transmissionBuffer[1] = 0xFA;
    transmissionBuffer[2] = 0x04;
    transmissionBuffer[3] = 0x00;
    transmissionBuffer[4] = 0xAF;
    transmissionBuffer[5] = 0xB0;
    
    bleSerial_.write(transmissionBuffer, 6);

    std::cout << "journey_start_to_ble" << std::endl;
}

void publishSonar(int idx, float distance) {
    if (idx >= 8) return;

    sensor_msgs::Range msg;
    msg.header.stamp = ros::Time::now();
    msg.header.frame_id = "sonar" + std::to_string(idx + 1) + "_frame";
    msg.radiation_type = sensor_msgs::Range::ULTRASOUND;
    msg.field_of_view = 0.87;
    msg.min_range = 0.2;
    msg.max_range = 4.5;
    msg.range = distance;
    sonar_pubs[idx].publish(msg);
}

void parseAndPublishSonarData(const std::string& raw) {
    if (raw.substr(0, 8) == "{0090024" && raw.length() == 35) {
        for (int i = 0; i < 8; ++i) {
            std::string val_str = raw.substr(8 + i * 3, 3);
            int val = std::stoi(val_str);
            float distance = val / 100.0f;
            publishSonar(i, distance);
        }
    }
}

int main(int argc, char** argv) {
    ros::init(argc, argv, "ble_sender_node");
    ros::NodeHandle nh;
    ros::Rate loop_rate(10);

    ros::Subscriber parkingStartSub = nh.subscribe("/parking_start", 10, parkingStartCallback);
    ros::Subscriber journeyStartSub = nh.subscribe("/journey_start_to_ble", 10, journeyStartCallback);

    for (int i = 0; i < 8; ++i) {
        sonar_pubs[i] = nh.advertise<sensor_msgs::Range>("/sonardata" + std::to_string(i + 1) + "_topic", 10);
    }

    bleRawResponsePub = nh.advertise<std_msgs::String>("/ble_raw_response", 10);

    bleSerialInitialize();

    while (ros::ok()) {
        if (!bleSerial_.isOpen()) {
            bleSerialInitialize();
        }

        if (bleSerial_.available()) {
            std_msgs::String msg;
            msg.data = bleSerial_.read(bleSerial_.available());

            // 중간 토픽으로 publish (receiver_node가 구독함)
            bleRawResponsePub.publish(msg);

            // 초음파 데이터 파싱 시도
            std::string raw = msg.data;
            raw.erase(std::remove(raw.begin(), raw.end(), '\n'), raw.end());
            raw.erase(std::remove(raw.begin(), raw.end(), '\r'), raw.end());
            parseAndPublishSonarData(raw);
        }

        ros::spinOnce();
        loop_rate.sleep();
    }
}
