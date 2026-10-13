#include <ros/ros.h>
#include <std_msgs/String.h>
#include <std_msgs/Int32.h>

#include <string>
#include <vector>
#include <algorithm>

ros::Publisher bleStandByPublisher_;
ros::Publisher stopParkingDockConnectedPublisher_;
ros::Publisher exceptionalTerminationPublisher_;
ros::Publisher isChargingFromBlePublisher_;

void bleMessageParser(const std::string& raw_input) {
    // 문자열을 char 배열로 변환
    std::string raw = raw_input;
    raw.erase(std::remove(raw.begin(), raw.end(), '['), raw.end());
    raw.erase(std::remove(raw.begin(), raw.end(), ']'), raw.end());
    raw.erase(std::remove(raw.begin(), raw.end(), '\n'), raw.end());
    raw.erase(std::remove(raw.begin(), raw.end(), '\r'), raw.end());

    if (raw.length() < 12) return;

    const unsigned char* buffer = reinterpret_cast<const unsigned char*>(raw.c_str());

    if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x01 && buffer[3]==0x01 && buffer[4]==0xAF && buffer[5]==0xB0){
        ROS_INFO("Start Parking.");
        std_msgs::Int32 msg; msg.data = 1;
        bleStandByPublisher_.publish(msg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x02 && buffer[3]==0x03 && buffer[4]==0xAF && buffer[5]==0xB0){
        ROS_INFO("Dock Connected. Stop Parking.");
        std_msgs::Int32 msg; msg.data = 1;
        stopParkingDockConnectedPublisher_.publish(msg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x0C && buffer[3]==0x00 && buffer[4]==0xAF && buffer[5]==0xB0){
        ROS_INFO("Journey Start: Not Charging.");
        std_msgs::Int32 msg; msg.data = 0;
        isChargingFromBlePublisher_.publish(msg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x04 && buffer[3]==0x00 && buffer[4]==0xAF && buffer[5]==0xB0){
        ROS_WARN("Exceptional Termination.");
        std_msgs::Int32 term; term.data = 1;
        exceptionalTerminationPublisher_.publish(term);
        std_msgs::Int32 charging; charging.data = 0;
        isChargingFromBlePublisher_.publish(charging);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x0E && buffer[3]==0x00 && buffer[4]==0xAF && buffer[5]==0xB0){
        ROS_INFO("BLE Connected.");
        std_msgs::Int32 msg; msg.data = 1;
        bleStandByPublisher_.publish(msg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x0E && buffer[3]==0x01 && buffer[4]==0xAF && buffer[5]==0xB0){
        ROS_WARN("BLE Disconnected.");
        std_msgs::Int32 msg; msg.data = 0;
        isChargingFromBlePublisher_.publish(msg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x05 && buffer[3]==0x00 && buffer[4]==0xAF && buffer[5]==0xB0){
        ROS_INFO("Charging Started.");
        std_msgs::Int32 msg; msg.data = 1;
        isChargingFromBlePublisher_.publish(msg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x03 && buffer[3]==0x00 && buffer[4]==0xAF && buffer[5]==0xB0){
        ROS_INFO("Not Charging.");
        std_msgs::Int32 msg; msg.data = 0;
        isChargingFromBlePublisher_.publish(msg);
    }
}

void bleRawCallback(const std_msgs::String::ConstPtr& msg) {
    bleMessageParser(msg->data);
}

int main(int argc, char** argv) {
    ros::init(argc, argv, "ble_receiver_node");
    ros::NodeHandle nh;

    ros::Subscriber bleRawSub = nh.subscribe("/ble_raw_response", 10, bleRawCallback);

    bleStandByPublisher_ = nh.advertise<std_msgs::Int32>("/parking_standby_ack", 10);
    stopParkingDockConnectedPublisher_ = nh.advertise<std_msgs::Int32>("/stop_parking_dock_connected", 10);
    exceptionalTerminationPublisher_ = nh.advertise<std_msgs::Int32>("/exceptional_termination_ble", 10);
    isChargingFromBlePublisher_ = nh.advertise<std_msgs::Int32>("/is_charging_from_ble", 10);

    ROS_INFO("BLE Receiver Node started.");
    ros::spin();
}
