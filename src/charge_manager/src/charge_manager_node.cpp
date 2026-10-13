#include <ros/ros.h>
#include <std_msgs/String.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Float32.h>
#include <nlohmann/json.hpp>
#include <fstream>
#include <ctime>

using json = nlohmann::json;

// 전역 변수
std::string json_file_path = "/home/nvidia/charge_setting/charge_setting.json";
int target_battery = -1;
std::vector<std::string> target_times;

ros::Publisher charge_pub;
ros::Publisher current_setting_pub;

// 중복 실행 방지용 플래그
std::string last_triggered_time = "";
bool battery_triggered = false;

// JSON 파일 읽어서 메모리 변수 업데이트
void loadSettings() {
    std::ifstream file_in(json_file_path);
    if (file_in.is_open()) {
        try {
            json j;
            file_in >> j;
            target_battery = j["battery"];
            target_times = j["times"].get<std::vector<std::string>>();
            ROS_INFO("Settings loaded from JSON.");
        } catch (...) {
            ROS_ERROR("JSON parsing error in file.");
        }
        file_in.close();
    }
}

// 1. 앱에서 새로운 설정을 보냈을 때 (저장 및 적용)
void chargeSettingCallback(const std_msgs::String::ConstPtr& msg) {
    try {
        json j = json::parse(msg->data);
        std::ofstream file_out(json_file_path);
        if (file_out.is_open()) {
            file_out << std::setw(4) << j << std::endl;
            file_out.close();
            ROS_INFO("New charge settings saved.");
            
            loadSettings(); // 새 설정 즉시 적용
            battery_triggered = false; // 배터리 트리거 초기화
            last_triggered_time = "";  // 시간 트리거 초기화
        }
    } catch (std::exception& e) {
        ROS_ERROR("Exception: %s", e.what());
    }
}

// 2. 앱에서 다이얼로그를 열 때 현재 설정을 요청함
void requestSettingCallback(const std_msgs::Empty::ConstPtr& msg) {
    std::ifstream file_in(json_file_path);
    std_msgs::String res_msg;
    
    if (file_in.is_open()) {
        std::cout << "opened." << std::endl;
        json j;
        file_in >> j;
        res_msg.data = j.dump();
        file_in.close();
    } else {
        // 파일이 없으면 기본값 전송
        std::cout << "file not found." << std::endl;
        json default_j;
        default_j["battery"] = -1;
        default_j["times"] = json::array();
        res_msg.data = default_j.dump();
    }
    current_setting_pub.publish(res_msg);
}

// 3. 배터리 모니터링 콜백 (1초에 1번씩 들어옴)
void batteryCallback(const std_msgs::Float32::ConstPtr& msg) {
    if (target_battery != -1) {
        if (msg->data <= target_battery && !battery_triggered) {
            ROS_INFO("Battery low (%.1f%%). Triggering /go_to_charge", msg->data);
            std_msgs::Empty empty_msg;
            charge_pub.publish(empty_msg);
            battery_triggered = true; // 도킹 중 지속 발행 방지
        } 
        // 충전이 어느정도 되면 다시 트리거 가능하게 리셋 (이력 현상 방지)
        else if (msg->data > target_battery + 5.0) {
            battery_triggered = false;
        }
    }
}

// 4. 시간 모니터링 (1초마다 반복 확인)
void timerCallback(const ros::TimerEvent&) {
    if (target_times.empty()) return;

    std::time_t t = std::time(nullptr);
    std::tm* now = std::localtime(&t);
    char buf[6];
    strftime(buf, sizeof(buf), "%H:%M", now);
    std::string current_time(buf);

    for (const auto& time_str : target_times) {
        if (time_str == current_time && last_triggered_time != current_time) {
            ROS_INFO("Scheduled time reached (%s). Triggering /go_to_charge", current_time.c_str());
            std_msgs::Empty empty_msg;
            charge_pub.publish(empty_msg);
            last_triggered_time = current_time; // 1분 내에 중복 발행 방지
            break;
        }
    }
}

int main(int argc, char** argv) {
    ros::init(argc, argv, "charge_manager_node");
    ros::NodeHandle nh;

    // 프로그램 시작 시 기존 설정 로드
    loadSettings();

    // 구독(Subscriber)
    ros::Subscriber set_sub = nh.subscribe("/charge_setting", 10, chargeSettingCallback);
    ros::Subscriber req_sub = nh.subscribe("/request_charge_setting", 10, requestSettingCallback);
    ros::Subscriber bat_sub = nh.subscribe("/batteryRemaing", 10, batteryCallback);

    // 발행(Publisher)
    charge_pub = nh.advertise<std_msgs::Empty>("/go_to_charge", 10);
    current_setting_pub = nh.advertise<std_msgs::String>("current_charge_setting", 10);

    // 1초 주기로 시간 검사 타이머 실행
    ros::Timer timer = nh.createTimer(ros::Duration(1.0), timerCallback);

    ROS_INFO("Charge Manager Node Started.");
    ros::spin();

    return 0;
}