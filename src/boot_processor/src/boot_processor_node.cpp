#include "ros/ros.h"
#include "ros/console.h"
#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <list>
#include <math.h>
#include <sensor_msgs/LaserScan.h>
#include <sensor_msgs/Imu.h>
#include <std_msgs/String.h>
#include <string>

#include <diagnostic_aggregator/analyzer.h>
#include <diagnostic_aggregator/status_item.h>
#include <diagnostic_msgs/DiagnosticStatus.h>
#include <diagnostic_msgs/DiagnosticArray.h>

std::string frontLaserState_;
std::string rearLaserState_;
std::string imuState_;
std::string mdMotorState_;
std::string usbCamState_;
std::string sonarState_;


void frontLaserCallback(const sensor_msgs::LaserScan& laserMsg){
    double time = laserMsg.header.stamp.toSec();
    //rateFrontLaser_ = 1.0 / (time-previousTimeFrontLaser_);    
    //previousTimeFrontLaser_ = time;
}

void diagnosticsAggCallback(const diagnostic_msgs::DiagnosticArray& msg){
    for (int i =0 ; i < msg.status.size() ; ++i ){
        if ( msg.status[i].name == std::string("/Other") ) {
            for (int j = 0 ; j < msg.status[i].values.size() ; ++j ) {
                if ( msg.status[i].values[j].key == std::string("node_alive/front_laser/gl_ros_driver_node") ){
                    frontLaserState_ = msg.status[i].values[j].value;                        
                }

                else if( msg.status[i].values[j].key == std::string("node_alive/rear_laser/gl_ros_driver_node") ){
                    rearLaserState_ = msg.status[i].values[j].value;                    
                }

                else if ( msg.status[i].values[j].key == std::string("node_alive/imu_node") ){
                    imuState_ = msg.status[i].values[j].value;
                }

                else if ( msg.status[i].values[j].key == std::string("node_alive/md_node" ) ){
                    mdMotorState_ = msg.status[i].values[j].value;
                }

                else if ( msg.status[i].values[j].key == std::string("node_alive/usb_cam") ){
                    usbCamState_ = msg.status[i].values[j].value;                    
                }

                else if ( msg.status[i].values[j].key == std::string("node_alive/serial_node") ){
                    sonarState_ = msg.status[i].values[j].value;                    
                }                        
            }
        }
    }
}


int main(int argc, char **argv)
{
    ROS_INFO("boot_processor start\n");
    ros::init(argc, argv, "boot_processor");

    ros::NodeHandle nh;
    ros::Rate r(1.0);

    ros::Subscriber frontLaserSubscriber = nh.subscribe("/front_laser/scan1", 10, frontLaserCallback);

    ros::Subscriber diagAggSubscriber = nh.subscribe("diagnostics_agg", 10, diagnosticsAggCallback);
        
    ros::Publisher sensorRatePublisher = nh.advertise<std_msgs::String>("/sensor_rate", 10);

    frontLaserState_ = "dead";
    rearLaserState_ = "dead";
    imuState_ = "dead";
    mdMotorState_ = "dead";
    usbCamState_ = "dead";
    sonarState_ = "dead";

    while (ros::ok())
    {   
        // std::stringstream ssTemp;

        // ssTemp << "{" << std::endl << "   \"frontLaserRate\": " << rateFrontLaser_ << ","  << std::endl
        //        << "   \"rearRaserRate\": " << rateRearLaser_ << "," << std::endl
        //        << "   \"imuRate\": " << rateImu_ << "," << std::endl
        //        << "   \"sonar1\": " << rateSonar1_ << "," << std::endl
        //        << "   \"sonar2\": " << rateSonar2_ << "," << std::endl
        //        << "   \"sonar3\": " << rateSonar3_ << "," << std::endl
        //        << "   \"sonar4\": " << rateSonar4_ << std::endl
        //        << "}" ;

        // std_msgs::String strMsg;
        // strMsg.data = ssTemp.str().c_str();
        
        // sensorRatePublisher.publish(strMsg);

        std::cout << "frontLaser : " << frontLaserState_ << std::endl <<
                     "rearLaser  : " << rearLaserState_ << std::endl <<
                     "imu        : " << imuState_ << std::endl << 
                     "mdMotor    : " << mdMotorState_ << std::endl <<
                     "usbCam     : " << usbCamState_ << std::endl <<
                     "sonar      : " << sonarState_ << std::endl;

        ros::spinOnce();
        r.sleep(); 
    }
}
