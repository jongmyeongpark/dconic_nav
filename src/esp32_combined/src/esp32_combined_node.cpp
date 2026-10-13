#include <ros/ros.h>
#include <serial/serial.h>
#include <std_msgs/String.h>
#include <std_msgs/Char.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Int32.h>
#include <std_msgs/Float32.h>
#include <sensor_msgs/Range.h>

#include <cstdlib>
#include <ctime>
#include <boost/thread/thread.hpp>
#include <vector>
#include <iostream>

/**
 * Serial 
 */
serial::Serial bleSerial_;

ros::Publisher bleStandByPublisher_;

ros::Publisher stopParkingDockConnectedPublisher_;

ros::Publisher exceptionalTerminationPublisher_;

ros::Publisher isChargingFromBlePublisher_;

std::vector<ros::Publisher> sonar_pubs(8);

void bleSerialInitialize()
{
    try
    {
        bleSerial_.setPort("/dev/ttyMycomDebugger");
        bleSerial_.setBaudrate(115200);
        serial::Timeout to = serial::Timeout::simpleTimeout(1000);
        bleSerial_.setTimeout(to);
        bleSerial_.open();
    }
    catch (serial::IOException& e)
    {
        ROS_ERROR_STREAM("Unable to open ble serial port ");
    }

    if(bleSerial_.isOpen())
    {
        ROS_INFO_STREAM("BLE serial Port initialized");
    }
    else
    {
        //return -1;
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
}

void publishSonar(int idx, float range)
{
    // ROS_INFO_STREAM("Publishing sonar[" << idx << "] = " << range);
    if (idx >= 8) return;
    sensor_msgs::Range msg;
    msg.header.stamp = ros::Time::now();
    msg.header.frame_id = "sonar" + std::to_string(idx + 1) + "_frame";
    msg.radiation_type = sensor_msgs::Range::ULTRASOUND;
    msg.field_of_view = 0.87;
    msg.min_range = 0.2;
    msg.max_range = 4.5;
    msg.range = range;
    sonar_pubs[idx].publish(msg);
}

int bleMessageParser(char* buffer)
{
    std::string raw(buffer);
    raw.erase(std::remove(raw.begin(), raw.end(), '['), raw.end());
    raw.erase(std::remove(raw.begin(), raw.end(), ']'), raw.end());
    raw.erase(std::remove(raw.begin(), raw.end(), '\n'), raw.end());
    raw.erase(std::remove(raw.begin(), raw.end(), '\r'), raw.end());

    // ROS_INFO_STREAM("Cleaned raw string: [" << raw << "] len: " << raw.length());

    if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x01 && buffer[3]==0x01 && buffer[4]==0xAF && buffer[5]==0xB0){
        // start parking
        ROS_INFO_STREAM("Start Parking.");
        std_msgs::Int32 msg;
        msg.data = 1;
        bleStandByPublisher_.publish(msg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x02 && buffer[3]==0x03 && buffer[4]==0xAF && buffer[5]==0xB0){
        // dock connected. stop forwarding
        ROS_INFO_STREAM("Stop Parking. Dock Connected.");
        std_msgs::Int32 msg;
        msg.data = 1;
        stopParkingDockConnectedPublisher_.publish(msg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x0C && buffer[3]==0x00 && buffer[4]==0xAF && buffer[5]==0xB0){
        // Ready to get out docker
        ROS_INFO_STREAM("Start Journey.");
        std_msgs::Int32 isChargingMsg;
        isChargingMsg.data = 0;
        isChargingFromBlePublisher_.publish(isChargingMsg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x04 && buffer[3]==0x00 && buffer[4]==0xAF && buffer[5]==0xB0){
        // Exceptional Termination
        ROS_INFO_STREAM("Exceptional Termination.");
        std_msgs::Int32 msg;
        msg.data = 1;
        exceptionalTerminationPublisher_.publish(msg);
        std_msgs::Int32 isChargingMsg;
        isChargingMsg.data = 0;
        isChargingFromBlePublisher_.publish(isChargingMsg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x0E && buffer[3]==0x00 && buffer[4]==0xAF && buffer[5]==0xB0){
        // BLE connect State
        ROS_INFO_STREAM("BLE is Connected.");
        std_msgs::Int32 msg;
        msg.data = 1;
        bleStandByPublisher_.publish(msg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x0E && buffer[3]==0x01 && buffer[4]==0xAF && buffer[5]==0xB0){
        // BLE disconnect State
        ROS_INFO_STREAM("BLE is Disconnected.");
        std_msgs::Int32 isChargingMsg;
        isChargingMsg.data = 0;
        isChargingFromBlePublisher_.publish(isChargingMsg);
    }
    else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x05 && buffer[3]==0x00 && buffer[4]==0xAF && buffer[5]==0xB0){
        ROS_INFO_STREAM("Is Charging Now.");
        std_msgs::Int32 msg;
        msg.data = 1;
        isChargingFromBlePublisher_.publish(msg);
    }
        else if (buffer[0]==0xAF && buffer[1]==0xFA && buffer[2]==0x03 && buffer[3]==0x00 && buffer[4]==0xAF && buffer[5]==0xB0){
        std_msgs::Int32 msg;
        msg.data = 0;
        isChargingFromBlePublisher_.publish(msg);
    }    
    if (raw.substr(0, 8) == "{0090024" && raw.length() == 35) {
        for (int i = 0; i < 8; ++i) {
            std::string range_str = raw.substr(8 + i * 3, 3);
            int raw_val = std::stoi(range_str);
            float distance = raw_val / 100.0f;
            // ROS_INFO_STREAM("Parsed sonar raw[" << i << "] = " << range_str << " -> " << distance);
            publishSonar(i, distance);
        }
        return 1;
    }
    return 0;
}

int main (int argc, char** argv)
{
    ros::init(argc, argv, "ble_serial_manager_node");
    ros::NodeHandle nh;
    ros::Rate loop_rate(10);
    
    ros::Subscriber parkingStartSubscriber = nh.subscribe("/parking_start", 10, parkingStartCallback);

    ros::Subscriber journeyStartSubscriber = nh.subscribe("/journey_start_to_ble", 10, journeyStartCallback);

    ros::Publisher parkingSequenceMsgPublisher = nh.advertise<std_msgs::Int32>("/parking_sequence", 1);

    for (int i = 0; i < 8; ++i)
    {
        sonar_pubs[i] = nh.advertise<sensor_msgs::Range>("sonardata" + std::to_string(i + 1) + "_topic", 10);
    }

    bleStandByPublisher_ = nh.advertise<std_msgs::Int32>("/parking_standby_ack", 1);

    exceptionalTerminationPublisher_ = nh.advertise<std_msgs::Int32>("/exceptional_termination_ble", 1);

    stopParkingDockConnectedPublisher_ = nh.advertise<std_msgs::Int32>("/stop_parking_dock_connected", 1);

    isChargingFromBlePublisher_ = nh.advertise<std_msgs::Int32>("is_charging_from_ble", 1);


    if (!bleSerial_.isOpen())
    {
        bleSerialInitialize();
    }

    while(ros::ok())
    {
        if (!bleSerial_.isOpen()){
            bleSerialInitialize();
        }
        
       // display 
        if( bleSerial_.available() && bleSerial_.isOpen() )
        {
            ROS_INFO_STREAM("Recieving from ble serial port");
            std_msgs::String recievedData;
            recievedData.data = bleSerial_.read(bleSerial_.available());

            std::vector<char> temp(recievedData.data.begin(), recievedData.data.end());
            temp.push_back('\0');
            char* buffer = &temp[0];

            // std::string raw(buffer);
            // ROS_INFO_STREAM("Raw received string: [" << raw << "] len: " << raw.length());


            std::cout << std::hex << (int)buffer[0] << " " << (int)buffer[1] << " " << (int)buffer[2] << " " << (int)buffer[3] << " " << (int)buffer[4] << " " << (int)buffer[5] << std::endl;            
            bleMessageParser(buffer);
        }
       
        ros::spinOnce();
        loop_rate.sleep();
    }
}