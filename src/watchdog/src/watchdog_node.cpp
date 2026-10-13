#include "ros/ros.h"
#include "ros/console.h"
#include "geometry_msgs/PoseWithCovarianceStamped.h"
#include "geometry_msgs/PoseArray.h"
#include "geometry_msgs/Pose.h"
#include "tf/tf.h"
#include "std_msgs/Empty.h"
#include <algorithm>
#include <std_msgs/Float32.h>
#include <std_msgs/Int32.h>
#include <iostream>
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <list>
#include <math.h>
#include <sensor_msgs/Image.h>
#include <sensor_msgs/LaserScan.h>
#include <sensor_msgs/Imu.h>
#include <sensor_msgs/Range.h>
#include <std_msgs/String.h>

double previousTimeFrontLaser_;
double previousTimeRearLaser_;
double previousTimeImu_;
double previousTimeSonar1_;
double previousTimeSonar2_;
double previousTimeSonar3_;
double previousTimeSonar4_;

double rateFrontLaser_;
double rateRearLaser_;
double rateImu_;
double rateSonar1_;
double rateSonar2_;
double rateSonar3_;
double rateSonar4_;

void frontLaserCallback(const sensor_msgs::LaserScan& laserMsg){
    double time = laserMsg.header.stamp.toSec();
    rateFrontLaser_ = 1.0 / (time-previousTimeFrontLaser_);    
    previousTimeFrontLaser_ = time;
}

void rearLaserCallback(const sensor_msgs::LaserScan& laserMsg){
    double time = laserMsg.header.stamp.toSec();
    rateRearLaser_ = 1.0 / (time-previousTimeRearLaser_);
    previousTimeRearLaser_ = time;
}

void imuCallback(const sensor_msgs::Imu& imuMsg){
    double time = imuMsg.header.stamp.toSec();
    rateImu_ = 1.0 / (time-previousTimeImu_);
    previousTimeImu_ = time;
}

void sonar1Callback(const sensor_msgs::Range& sonarMsg){
    double time = sonarMsg.header.stamp.toSec();
    rateSonar1_ = 1.0 / (time-previousTimeSonar1_);
    previousTimeSonar1_ = time;
}

void sonar2Callback(const sensor_msgs::Range& sonarMsg){
    double time = sonarMsg.header.stamp.toSec();
    rateSonar2_ = 1.0 / (time-previousTimeSonar2_);
    previousTimeSonar2_ = time;
}

void sonar3Callback(const sensor_msgs::Range& sonarMsg){
    double time = sonarMsg.header.stamp.toSec();
    rateSonar3_ = 1.0 / (time-previousTimeSonar3_);
    previousTimeSonar3_ = time;
}

void sonar4Callback(const sensor_msgs::Range& sonarMsg){
    double time = sonarMsg.header.stamp.toSec();
    rateSonar4_ = 1.0 / (time-previousTimeSonar4_);
    previousTimeSonar4_ = time;
}


int main(int argc, char **argv)
{
    ROS_INFO("watchdog start\n");
    ros::init(argc, argv, "watchdog");

    ros::NodeHandle nh;
    ros::Rate r(1.0);

    previousTimeFrontLaser_ = 0.0;
    previousTimeRearLaser_ = 0.0;
    previousTimeImu_ = 0.0;
    previousTimeSonar1_ = 0.0;
    previousTimeSonar2_ = 0.0;
    previousTimeSonar3_ = 0.0;
    previousTimeSonar4_ = 0.0;

    rateFrontLaser_ = 0.0;
    rateRearLaser_ = 0.0;
    rateImu_ = 0.0;
    rateSonar1_ = 0.0;
    rateSonar2_ = 0.0;
    rateSonar3_ = 0.0;
    rateSonar4_ = 0.0;

    ros::Subscriber frontLaserSubscriber = nh.subscribe("/front_laser/scan1", 10, frontLaserCallback);
    
    ros::Subscriber rearLaserSubscriber = nh.subscribe("/rear_laser/scan2", 10, rearLaserCallback);

    ros::Subscriber imuSubscriber = nh.subscribe("/imu", 10, imuCallback);

    ros::Subscriber sonar1Subscriber = nh.subscribe("/sonar1", 10, sonar1Callback);
    ros::Subscriber sonar2Subscriber = nh.subscribe("/sonar2", 10, sonar2Callback);
    ros::Subscriber sonar3Subscriber = nh.subscribe("/sonar3", 10, sonar3Callback);
    ros::Subscriber sonar4Subscriber = nh.subscribe("/sonar4", 10, sonar4Callback);


    ros::Publisher sensorRatePublisher = nh.advertise<std_msgs::String>("/sensor_rate", 10);


    while (ros::ok())
    {  
        // std::cout << "sumOfodomCombined : " << sumOfodomCombined_ << "  sumOfAmcl : " << sumOfAmcl_ << std::endl;
        // if (sumOfAmcl_ > (sumOfodomCombined_ * 1.2) ){
        //     count_ = 0;
        //     isPublishAbnormalPoseAlarm_ = true;
        // } 

        // if (isPublishAbnormalPoseAlarm_){            
        //     std_msgs::Int32 msgInt;
        //     msgInt.data = 1;       
        //     pubAbnormalPoseAlarm_.publish(msgInt);
        //     ++count_;
        //     if (count_ == 1){
        //         isPublishAbnormalPoseAlarm_ = false;
        //     }            
        // }

        std::stringstream ssTemp;

        ssTemp << "{" << std::endl << "   \"frontLaserRate\": " << rateFrontLaser_ << ","  << std::endl
               << "   \"rearRaserRate\": " << rateRearLaser_ << "," << std::endl
               << "   \"imuRate\": " << rateImu_ << "," << std::endl
               << "   \"sonar1\": " << rateSonar1_ << "," << std::endl
               << "   \"sonar2\": " << rateSonar2_ << "," << std::endl
               << "   \"sonar3\": " << rateSonar3_ << "," << std::endl
               << "   \"sonar4\": " << rateSonar4_ << std::endl
               << "}" ;

        std_msgs::String strMsg;
        strMsg.data = ssTemp.str().c_str();
        
        sensorRatePublisher.publish(strMsg);


        ros::spinOnce();
        r.sleep(); 
    }
}
