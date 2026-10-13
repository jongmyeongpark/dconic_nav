#include "ros/ros.h"
#include "ros/console.h"
#include "geometry_msgs/PoseWithCovarianceStamped.h"
#include "geometry_msgs/PoseArray.h"
#include "geometry_msgs/Pose.h"
#include "tf/tf.h"
#include "std_msgs/Empty.h"
#include <math.h>
#include <vector>
#include <algorithm>
#include <sensor_msgs/LaserScan.h>
#include <std_msgs/Float32.h>
#include <iostream>
#include <set>
#include <ostream>
#include <sensor_msgs/Range.h>
#include <limits>
#include "std_msgs/Int32.h"

using namespace std;
std::vector<float> shortset_ranges_container;
sensor_msgs::Range closest_obs_;
float shortest_laser_range1;
float shortest_laser_range2;
float shortest_sonar_range1;
float shortest_sonar_range2;
float shortest_sonar_range3;
float shortest_sonar_range4;
float shortest_sonar_range5;

int isVariableSpeedOnoff;

bool xyRange = false;

ros::Publisher dynamic_max_vel_x_pub_;
ros::Publisher requestLedDisplay_;


void scandataCallBack1(const sensor_msgs::LaserScan& msg)
{   
    int closeObsCount  = 0;
    shortest_laser_range1 = std::numeric_limits<float>::max();
    //std::vector<float> laser_range_vector;
    for(int i=0;i<msg.ranges.size();i++){
        //laser_range_vector.push_back(msg.ranges[i]);
        if (msg.ranges[i] > 0.05 && msg.ranges[i] < shortest_laser_range1)
        {
            shortest_laser_range1 = msg.ranges[i];
        } 

        if (msg.ranges[i] <= 1.0){
            ++closeObsCount;
        }
    }
    if (closeObsCount > 500){
        std_msgs::Int32 msgReqDisp;
        msgReqDisp.data = 5;
        //requestLedDisplay_.publish(msgReqDisp);
    }
    //shortest_laser_range1 = *std::min_element(laser_range_vector.begin(), laser_range_vector.end());
    //laser_range_vector.clear();
}

void scandataCallBack2(const sensor_msgs::LaserScan& msg)
{
    //std::vector<float> laser_range_vector;
    shortest_laser_range2 = std::numeric_limits<float>::max();
    for(int i=0;i<msg.ranges.size();i++){
        //laser_range_vector.push_back(msg.ranges[i]);
        if (msg.ranges[i] > 0.05 && msg.ranges[i] < shortest_laser_range2)
        {
            shortest_laser_range2 = msg.ranges[i];
        } 
    }
    //shortest_laser_range2 = *std::min_element(laser_range_vector.begin(), laser_range_vector.end());
    //laser_range_vector.clear();
}

void fl_sonar_scanCallBack(const sensor_msgs::LaserScan& msg)
{
    //std::vector<float> laser_range_vector;
    shortest_sonar_range1 = std::numeric_limits<float>::max();
    for(int i=0;i<80;i++){
        //laser_range_vector.push_back(msg.ranges[i]);
        if (msg.ranges[i] > 0.07 && msg.ranges[i] < shortest_sonar_range1)
        {
            shortest_sonar_range1 = msg.ranges[i];
        } 
    }
    //shortest_sonar_range1 = *std::min_element(laser_range_vector.begin(), laser_range_vector.end());
    //laser_range_vector.clear();
}

void fr_sonar_scanCallBack(const sensor_msgs::LaserScan& msg)
{
    //std::vector<float> laser_range_vector;
    shortest_sonar_range2 = std::numeric_limits<float>::max();
    for(int i=0;i<80;i++){
        if (msg.ranges[i] > 0.07 && msg.ranges[i] < shortest_sonar_range2)
        {
            shortest_sonar_range2 = msg.ranges[i];
        } 
    }
    //shortest_sonar_range2 = *std::min_element(laser_range_vector.begin(), laser_range_vector.end());
    //laser_range_vector.clear();
}

void rl_sonar_scanCallBack(const sensor_msgs::LaserScan& msg)
{
    //std::vector<float> laser_range_vector;
    shortest_sonar_range3 = std::numeric_limits<float>::max();
    for(int i=0;i<80;i++){
        //laser_range_vector.push_back(msg.ranges[i]);
         if (msg.ranges[i] > 0.07 && msg.ranges[i] < shortest_sonar_range3)
        {
            shortest_sonar_range3 = msg.ranges[i];
        } 
    }
    //shortest_sonar_range3 = *std::min_element(laser_range_vector.begin(), laser_range_vector.end());
    //laser_range_vector.clear();
}

void rr_sonar_scanCallBack(const sensor_msgs::LaserScan& msg)
{
    //std::vector<float> laser_range_vector;
    shortest_sonar_range4 = std::numeric_limits<float>::max();
    for(int i=0;i<80;i++){
        //laser_range_vector.push_back(msg.ranges[i]);
         if (msg.ranges[i] > 0.07 && msg.ranges[i] < shortest_sonar_range4)
        {
            shortest_sonar_range4 = msg.ranges[i];
        } 
    }
    //shortest_sonar_range4 = *std::min_element(laser_range_vector.begin(), laser_range_vector.end());
    //laser_range_vector.clear();
}

void ft_sonar_scanCallBack(const sensor_msgs::LaserScan& msg)
{
    //std::vector<float> laser_range_vector;
    shortest_sonar_range5 = std::numeric_limits<float>::max();
    for(int i=0;i<80;i++){
        //laser_range_vector.push_back(msg.ranges[i]);
        if (msg.ranges[i] > 0.07 && msg.ranges[i] < shortest_sonar_range5)
        {
            shortest_sonar_range5 = msg.ranges[i];
        } 
    }
    //shortest_sonar_range5 = *std::min_element(laser_range_vector.begin(), laser_range_vector.end());
    //laser_range_vector.clear();
}

void variableSpeedOnoffCallback(const std_msgs::Int32& msg){

    int data = msg.data;
    if (data == 1){
        isVariableSpeedOnoff = 1;
    }
    else {
        isVariableSpeedOnoff = 0;
        std_msgs::Float32 msg;
        msg.data = 0.3;
        dynamic_max_vel_x_pub_.publish(msg);
    }
}

float minimumFloat(float f1, float f2){
    if (f1 < f2){
        return f1;
    }
    else {
        return f2;
    }
}

void xyRangeCallback(const geometry_msgs::PoseWithCovarianceStamped& msg){
    float amcl_x = msg.pose.pose.position.x;
    float amcl_y = msg.pose.pose.position.y;

    if((112.50 < amcl_x && 125.98 > amcl_x) && (23.75 < amcl_y && 41.20 > amcl_y)){
        xyRange = true;
        // ROS_INFO("xyRange = true");
    }
    else{
        xyRange = false;
        // ROS_INFO("xyRange = false");
    }
    
}

int main(int argc, char **argv)
{
    ROS_INFO("closest_obs_from_robot start\n");
    ros::init(argc, argv, "closest_obs_from_robot");
    ros::NodeHandle nh;
    ros::Rate r(2.0);

    // ros::Subscriber scan_sub1 = nh.subscribe("/scan_1", 2, scandataCallBack1);
    // ros::Subscriber scan_sub2 = nh.subscribe("/scan_2", 2, scandataCallBack2);
    //ros::Subscriber sonar1_sub = nh.subscribe("fl_sonar_scan", 2, fl_sonar_scanCallBack);
    //ros::Subscriber sonar2_sub = nh.subscribe("fr_sonar_scan", 2, fr_sonar_scanCallBack);
    //ros::Subscriber sonar3_sub = nh.subscribe("rl_sonar_scan", 2, rl_sonar_scanCallBack);
    //ros::Subscriber sonar4_sub = nh.subscribe("rr_sonar_scan", 2, rr_sonar_scanCallBack);
    //ros::Subscriber sonar5_sub = nh.subscribe("ft_sonar_scan", 2, ft_sonar_scanCallBack);
    ros::Subscriber variable_speed_onoff_sub = nh.subscribe("variable_speed_onoff_request", 1, variableSpeedOnoffCallback);

    // ros::Subscriber xyRange_sub = nh.subscribe("/amcl_pose", 1, xyRangeCallback);

    // ros::Publisher closest_distance_pub = nh.advertise<sensor_msgs::Range>("closest_obs_dist", 10);

    ros::Publisher variable_speed_state_pub = nh.advertise<std_msgs::Int32>("variable_speed_state", 1);

    requestLedDisplay_ = nh.advertise<std_msgs::Int32>("requestDisplay",1);

    dynamic_max_vel_x_pub_ = nh.advertise<std_msgs::Float32>("/move_base/TebLocalPlannerROS/dynamic_max_vel_x", 1);

    int drive_mode = 1; // 1=slow, 2=fast

    unsigned int count = 0;

    isVariableSpeedOnoff = 1;

    while (ros::ok())
    {  
        //ROS_INFO("==============================================");
        //ROS_INFO("shortest_laser_range1 : %f", shortest_laser_range1);
        //ROS_INFO("shortest_laser_range2 : %f", shortest_laser_range2);
        //ROS_INFO("shortest_sonar_range1 : %f", shortest_sonar_range1);
        //ROS_INFO("shortest_sonar_range2 : %f", shortest_sonar_range2);
        //ROS_INFO("shortest_sonar_range3 : %f", shortest_sonar_range3);
        //ROS_INFO("shortest_sonar_range4 : %f", shortest_sonar_range4);
        //ROS_INFO("shortest_sonar_range5 : %f", shortest_sonar_range5);

        //shortset_ranges_container.push_back(shortest_laser_range1);
        //shortset_ranges_container.push_back(shortest_laser_range2);
        //shortset_ranges_container.push_back(shortest_sonar_range1);
        //shortset_ranges_container.push_back(shortest_sonar_range2);
        //shortset_ranges_container.push_back(shortest_sonar_range3);
        //shortset_ranges_container.push_back(shortest_sonar_range4);
        //shortset_ranges_container.push_back(shortest_sonar_range5);

        
        //closest_obs_.range = minimumFloat(shortest_laser_range1, minimumFloat(shortest_laser_range2, minimumFloat(shortest_sonar_range1, minimumFloat(shortest_sonar_range2, minimumFloat(shortest_sonar_range3, minimumFloat(shortest_sonar_range4, shortest_sonar_range5))))));
        // closest_obs_.range = minimumFloat(shortest_laser_range1, shortest_laser_range2);
        //closest_obs_.range = *std::min_element(shortset_ranges_container.begin(), shortset_ranges_container.end());
        // closest_distance_pub.publish(closest_obs_);
        //shortset_ranges_container.clear();
                
        if (isVariableSpeedOnoff == 1){
            // jmlee changed 0.65 => 2.0
            if(xyRange){
                //ROS_INFO("fast mode");
            
                if (count > 1){
                    if(drive_mode != 2){
                        //system("rosrun dynamic_reconfigure dynparam set /move_base/TebLocalPlannerROS max_vel_x 0.6 &");
                        std_msgs::Float32 msg;
                        msg.data = 0.3;
                        dynamic_max_vel_x_pub_.publish(msg);

                        ROS_INFO("Published dynamic max vel x : 0.3");
                        }

                        drive_mode = 2;            
                    }
                }
            else{
                //ROS_INFO("slow mode");
                if(drive_mode != 1){
                    //system("rosrun dynamic_reconfigure dynparam set /move_base/TebLocalPlannerROS max_vel_x 0.3 &");
                    std_msgs::Float32 msg;
                    msg.data = 0.3;
                    dynamic_max_vel_x_pub_.publish(msg);

                    ROS_INFO("Published dynamic max vel x : 0.2");
                }
                drive_mode = 1;

                count = 0;
            }
            
        }

        std_msgs::Int32 message;
        message.data = isVariableSpeedOnoff;
        variable_speed_state_pub.publish(message);


        ++count;
        ros::spinOnce();
        r.sleep(); 
    }
}
