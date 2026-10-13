#include <stdio.h>
#include <ros/ros.h>
#include <std_msgs/Int32.h>
#include <std_msgs/Empty.h>
#include <std_msgs/String.h>
#include <ros/console.h>
#include <stdlib.h>
#include <fstream>
#include <string.h>

bool is_device_id = false;

void device_id_CallBack(const std_msgs::Empty::ConstPtr & _device_id_req)
{
  ROS_INFO("device_id_CallBack message ");
  is_device_id = true;
}

int main(int argc, char **argv)
{
  ROS_INFO("device info start");
  ros::init(argc, argv, "devide_info");
  ros::NodeHandle nh;

  ros::Subscriber device_id_sub = nh.subscribe("device_id_request", 10, device_id_CallBack);
  
  ros::Publisher device_id_pub = nh.advertise<std_msgs::String>("device_id", 10);

  ros::Rate r(1.0);

  while (ros::ok())
  {
    if(is_device_id) {
      // load .csv file
      std::string file_name = "/home/nvidia/dconic_nav/src/device_info/device_info.csv";
      std::ifstream fin;
      fin.open(file_name.c_str());
      //ROS_INFO("device info file name = %s\n", file_name.c_str());

      if(!fin.is_open()){
        ROS_INFO("File open fail");
      }

      int str_len = 0;
      std::string line = "";
      std::string str = "";
      std_msgs::String device_info;
      
      // read file and make string
      while(std::getline(fin, line)){
	str_len = strlen(line.c_str());
	//ROS_INFO("line.c_str() = %s\n", line.c_str());
	if(str_len > 0){
	  //ROS_INFO("substr %s\n", line.c_str() );
	  str += line;
	}
	else{
	  break;
	}
      }

      int list_len = strlen(str.c_str());
      //ROS_INFO("str = %s\n", str.c_str());
      device_info.data = str;
      ROS_INFO("device_info.data = %s\n", device_info.data.c_str());

      device_id_pub.publish(device_info);
      fin.close();
      is_device_id = false;
    }

    ros::spinOnce();
    r.sleep();
  }
}
