#include <ros/ros.h>
#include <serial/serial.h>
#include <iostream>
#include <iomanip>
#include <vector>

// 시리얼 객체
serial::Serial bleSerial_;

void bleSerialInitialize()
{
    try
    {
        bleSerial_.setPort("/dev/ttyACM0");  // 필요한 포트명으로 수정
        bleSerial_.setBaudrate(115200);
        serial::Timeout to = serial::Timeout::simpleTimeout(1000);
        bleSerial_.setTimeout(to);
        bleSerial_.open();
    }
    catch (serial::IOException& e)
    {
        ROS_ERROR_STREAM("Unable to open BLE serial port.");
    }

    if (bleSerial_.isOpen())
    {
        ROS_INFO_STREAM("BLE serial port initialized.");
    }
    else
    {
        ROS_ERROR_STREAM("BLE serial port failed to open.");
    }
}

void printBufferHex(const char* buffer, size_t size)
{
    std::cout << "Received [" << size << " bytes]: ";
    for (size_t i = 0; i < size; ++i)
    {
        std::cout << std::hex << std::setw(2) << std::setfill('0') << (int)(unsigned char)buffer[i] << " ";
    }
    std::cout << std::dec << std::endl;
}

int main(int argc, char** argv)
{
    ros::init(argc, argv, "serial_check_node");
    ros::NodeHandle nh;
    ros::Rate loop_rate(10);  // 10Hz

    bleSerialInitialize();

    while (ros::ok())
    {
        if (!bleSerial_.isOpen())
        {
            bleSerialInitialize();
        }

        if (bleSerial_.available() && bleSerial_.isOpen())
        {
            std::string rawData = bleSerial_.read(bleSerial_.available());
            std::vector<char> temp(rawData.begin(), rawData.end());
            temp.push_back('\0');  // 안전장치

            char* buffer = &temp[0];
            printBufferHex(buffer, rawData.size());
            std::cout << "error" << '\n';
        }
        std::cout << "bleSerial_.available() : " << bleSerial_.available() << std::endl;

        ros::spinOnce();
        loop_rate.sleep();
    }

    return 0;
}
