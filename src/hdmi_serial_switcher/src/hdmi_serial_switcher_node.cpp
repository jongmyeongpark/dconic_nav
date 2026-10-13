/***
 * This example expects the serial port has a loopback on it.
 *
 * Alternatively, you could use an Arduino:
 *
 * <pre>
 *  void setup() {
 *    Serial.begin(<insert your baudrate here>);
 *  }
 *
 *  void loop() {
 *    if (Serial.available()) {
 *      Serial.write(Serial.read());
 *    }
 *  }
 * </pre>
 */

// #include <ros/ros.h>
// #include <serial/serial.h>
// #include <std_msgs/String.h>
// #include <std_msgs/Empty.h>
// #include <string>
// #include <std_msgs/Int32.h>
// #include <sstream>
// #include <thread>

// serial::Serial ser;

// void write_callback(const std_msgs::String::ConstPtr& msg){
//     ROS_INFO_STREAM("Writing to serial port" << msg->data);
//     ser.write(msg->data);
// }

// void hdmiSwitchCallback(const std_msgs::Int32 & msg ){
//     std::stringstream ssSw;
//     ssSw << "sw i0" << msg.data << "\n"; // dcornic1
//     int port = msg.data -1;
//     // ssSw << "port" << port << "R"; // dcornic2
//     ser.write(ssSw.str());
//     std::cout << "hdmi switch to " << msg.data << std::endl;
//     std::cout << ssSw.str() << std::endl;

    
//     if (msg.data == 2 || msg.data == 4 || msg.data == 1) {
//         std::this_thread::sleep_for(std::chrono::seconds(1));
//         std::string cmd = "xrandr --output DP-1 --mode 1024x768";
//         int ret = system(cmd.c_str());
//         if (WIFEXITED(ret)) {
//             std::cout << "Resolution changed successfully to 1024x768" << std::endl;
//         } else {
//             std::cerr << "Failed to change resolution" << std::endl;
//         }
//     }
// }


// int main (int argc, char** argv){
//     ros::init(argc, argv, "hdmi_serial_switcher_node");
//     ros::NodeHandle nh;

//     ros::Subscriber write_sub = nh.subscribe("hdmi_write", 10, write_callback);
//     ros::Subscriber hdmi_switch_subscriber = nh.subscribe("hdmi_switch", 10, hdmiSwitchCallback);
   
//     try
//     {
//         ser.setPort("/dev/ttyHdmiSwitch");
//         //ser.setPort("/dev/ttyUSB1");
//         ser.setBaudrate(19200); // dcornic1
//         // ser.setBaudrate(9600); // dcornic2
//         serial::Timeout to = serial::Timeout::simpleTimeout(1000);
//         ser.setTimeout(to);
//         ser.open();
//     }
//     catch (serial::IOException& e)
//     {
//         ROS_ERROR_STREAM("Unable to open port ");
//         return -1;
//     }

//     ros::Rate loop_rate(10);
    
//     int count = 0;

//     while(ros::ok()){

//         ros::spinOnce();

//         if(ser.available()){
//             ROS_INFO_STREAM("Reading from serial port");
//             std_msgs::String result;
//             result.data = ser.read(ser.available());
//             ROS_INFO_STREAM("Read: " << result.data);
//             // read_pub.publish(result);
//         }
        
//         loop_rate.sleep();

//     }
// }

#include <ros/ros.h>
#include <serial/serial.h>
#include <std_msgs/String.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Int32.h>

#include <string>
#include <sstream>
#include <thread>
#include <chrono>
#include <iostream>
#include <sys/wait.h>   // WIFEXITED
#include <cstdlib>      // setenv

serial::Serial ser;

void write_callback(const std_msgs::String::ConstPtr& msg){
    ROS_INFO_STREAM("Writing to serial port" << msg->data);
    ser.write(msg->data);
}

void hdmiSwitchCallback(const std_msgs::Int32 & msg ){
    static int current_port = 1;  // 직전 스위치 상태 기억

    const int target = msg.data;

    auto run_cmd = [](const std::string& cmd){
        int ret = system(cmd.c_str());
        return WIFEXITED(ret) ? WEXITSTATUS(ret) : -1;
    };

    // 현재 2번에 물려있고, 목표가 1 또는 3일 때: 1/3으로 가기 전에 1024x768로 선행 변경
    if (current_port == 2 && (target == 1 || target == 3)) {
        std::string pre_cmd = "xrandr --output DP-1 --mode 1024x768";
        int rc = run_cmd(pre_cmd);
        std::cout << "[pre] set 1024x768 before switching, rc=" << rc << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(200)); // 살짝 유예
    }

    // 스위치 명령 전송
    std::stringstream ssSw;

    int port = msg.data - 1; // dcornic2
    ssSw << "port" << port << "R"; // dcornic2

    ser.write(ssSw.str());
    std::cout << "hdmi switch to " << target << std::endl;
    std::cout << ssSw.str() << std::endl;

    // (추가) 2번으로 전환했을 때: 잠깐 기다렸다가 1920x1080으로 다시 갱신
    // - 2 -> (1/3) 에서 미리 1024로 바꿔두었으니,
    //   (1/3) -> 2 로 돌아오면 1920 갱신이 "실제 변경"으로 먹히게 됨
    if (target == 2) {
        std::this_thread::sleep_for(std::chrono::milliseconds(2000));
        std::string cmd = "xrandr --output DP-1 --mode 1920x1080";
        int rc = run_cmd(cmd);
        if (rc == 0) {
            std::cout << "Resolution changed successfully to 1920x1080" << std::endl;
        } else {
            std::cerr << "Failed to change resolution to 1920x1080, rc=" << rc << std::endl;
        }
    }

    // 현재 포트 상태 갱신
    current_port = target;
}

// void hdmiSwitchCallback(const std_msgs::Int32 & msg ){
//     std::stringstream ssSw;

//     //ssSw << "sw i0" << msg.data << "\n"; // dcornic1

//     int port = msg.data -1; // dcornic2
//     ssSw << "port" << port << "R"; // dcornic2

//     ser.write(ssSw.str());
//     std::cout << "hdmi switch to " << msg.data << std::endl;
//     std::cout << ssSw.str() << std::endl;

//     if (msg.data == 2) {
//         std::this_thread::sleep_for(std::chrono::seconds(1));
//         std::string cmd = "xrandr --output DP-1 --mode 1920x1080";
//         int ret = system(cmd.c_str());
//         if (WIFEXITED(ret)) {
//             std::cout << "Resolution changed successfully to 1920x1080" << std::endl;
//         } else {
//             std::cerr << "Failed to change resolution" << std::endl;
//         }
//     }
// }

int main (int argc, char** argv){
    ros::init(argc, argv, "hdmi_serial_switcher_node");

    // === 노드 시작 시 1회: DISPLAY=:0.0 무조건 설정 ===
    setenv("DISPLAY", ":0.0", 1);
    ROS_INFO("DISPLAY set to :0.0");

    // // === 노드 시작 시 1회: xrandr 1024x768 한 번 적용 ===
    // {
    //     const char* init_cmd = "xrandr --output DP-1 --mode 1024x768";
    //     int ret = system(init_cmd);
    //     if (WIFEXITED(ret)) {
    //         ROS_INFO("Initial xrandr applied: DP-1 -> 1024x768");
    //     } else {
    //         ROS_WARN("Initial xrandr failed");
    //     }
    // }

    ros::NodeHandle nh;

    ros::Subscriber write_sub = nh.subscribe("hdmi_write", 10, write_callback);
    ros::Subscriber hdmi_switch_subscriber = nh.subscribe("hdmi_switch", 10, hdmiSwitchCallback);

    try
    {
        ser.setPort("/dev/ttyHdmiSwitch");
        //ser.setPort("/dev/ttyUSB1");
        // ser.setBaudrate(19200); // dcornic1
        ser.setBaudrate(9600); // dcornic2
        serial::Timeout to = serial::Timeout::simpleTimeout(1000);
        ser.setTimeout(to);
        ser.open();
    }
    catch (serial::IOException& e)
    {
        ROS_ERROR_STREAM("Unable to open port ");
        return -1;
    }

    ros::Rate loop_rate(10);

    while(ros::ok()){
        ros::spinOnce();

        if(ser.available()){
            ROS_INFO_STREAM("Reading from serial port");
            std_msgs::String result;
            result.data = ser.read(ser.available());
            ROS_INFO_STREAM("Read: " << result.data);
            // read_pub.publish(result);
        }

        loop_rate.sleep();
    }
}
