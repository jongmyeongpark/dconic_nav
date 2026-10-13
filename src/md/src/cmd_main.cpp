#include <ros/ros.h>
#include <sstream>
#include <stdio.h>
#include <stdlib.h>
#include <std_msgs/String.h>
#include <geometry_msgs/Twist.h>
#include <math.h>

#include "md/vel_msg.h"
#include "md/monitor_msg.h"
//
#include <tf/transform_broadcaster.h>
#include <nav_msgs/Odometry.h>
#include <sensor_msgs/Imu.h>
#include <std_msgs/Empty.h>
#include <std_srvs/Empty.h>

#include <std_msgs/Int32.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <tf2/LinearMath/Quaternion.h>
#include <std_msgs/Bool.h>

#define DEG2RAD(x) (x * 0.01745329252) // *PI/180
#define RAD2DEG(x) (x * 57.2957795131) // *180/PI

typedef unsigned char  BYTE;

#define LEFT           	  0
#define RIGHT             1

#define BIT0              0x01
#define BIT1              0x02
#define BIT2              0x04
#define BIT3              0x08
#define BIT4              0x10
#define BIT5              0x20
#define BIT6              0x40
#define BIT7              0x80

float odom_pose[3];
float odom_vel[3];
double globalYaw_;
double previousYaw_;
bool is_nomotionupdate;
bool isResponsedServerPing_;
std::string moveBaseAliveState_;
std::string slamGmappingAliveState_;
std::string frontLaserAliveState_;
std::string rearLaserAliveState_;

bool isRangeSensorTfError_;
int rangeSensorTfErrorCount_;

typedef struct {
    long lPosiX;
    long lPosiY, lExPosiY;
    short sTheta;
    float fTheta;
    short sVoltIn;
    short sCurrent[2];
    BYTE byUS1;
    BYTE byUS2;
    BYTE byUS3;
    BYTE byUS4;
    BYTE byPlatStatus;
    BYTE byDocStatus;
    BYTE byMotStatus[2];

    BYTE fgAlarm[2], fgCtrlFail[2], fgOverVolt[2], fgOverTemp[2];
    BYTE fgOverLoad[2], fgHallFail[2], fgInvVel[2], fgStall[2];

    BYTE fgEmerON, fgBatChargeON, fgRccState;

    short sCmdLinearVel, sCmdAngularVel;
    short sRealLinearVel, sRealAngularVel;

    float fRealLinearVel, fRealAngularVel;

    int nAngleResolution;

    BYTE fgIntSpeed[2], fgDirection[2], fgRunBrake[2], fgStartStop[2];
    BYTE fgEncoderA[2], fgEncoderB[2];
    BYTE byIOMonitor[2];

}MotorDriver;
MotorDriver Md;

//It is a message callback function.
//It is a function that oprates when a topic message named 'monitor_topic' is received.
//The input message is to receive the 'monitor_msg' message from 'md' package in msg directory
void monitorCallBack(const md::monitor_msg::ConstPtr& monitor)
{
    int nGap;
    static int nExsTheta;

    Md.lPosiX             = monitor->lPosiX;
    Md.lPosiY             = monitor->lPosiY;
//    Md.sTheta             = monitor->sTheta;
    Md.fTheta             = (float)(monitor->sTheta)/10.0;
    Md.sRealLinearVel     = monitor->sRealLinearVel;
    Md.fRealAngularVel    = (float)(monitor->sRealAngularVel)/10.0;
    Md.sVoltIn            = monitor->sVoltIn;
    Md.sCurrent[LEFT]     = monitor->sLeftMotCur;
    Md.sCurrent[RIGHT]    = monitor->sRightMotCur;
    Md.byUS1              = monitor->byUS1;
    Md.byUS2              = monitor->byUS2;
    Md.byUS3              = monitor->byUS3;
    Md.byUS4              = monitor->byUS4;
    Md.byPlatStatus       = monitor->byPlatStatus;
    Md.byDocStatus        = monitor->byDocStatus;
    Md.byMotStatus[LEFT]  = monitor->byLeftMotStatus;
    Md.byMotStatus[RIGHT] = monitor->byRightMotStatus;
    Md.byIOMonitor[LEFT]  = monitor->byLeftIOMonitor;
    Md.byIOMonitor[RIGHT] = monitor->byRightIOMonitor;

    Md.fgEmerON      = Md.byPlatStatus & BIT0;
    Md.fgBatChargeON = Md.byDocStatus & BIT0;
    Md.fgRccState    = (Md.byDocStatus & BIT7) >> 7;

    Md.fgAlarm[LEFT]    = Md.byMotStatus[LEFT] & BIT0;
    Md.fgCtrlFail[LEFT] = Md.byMotStatus[LEFT] & BIT1;
    Md.fgOverVolt[LEFT] = Md.byMotStatus[LEFT] & BIT2;
    Md.fgOverTemp[LEFT] = Md.byMotStatus[LEFT] & BIT3;
    Md.fgOverLoad[LEFT] = Md.byMotStatus[LEFT] & BIT4;
    Md.fgHallFail[LEFT] = Md.byMotStatus[LEFT] & BIT5;
    Md.fgInvVel[LEFT]   = Md.byMotStatus[LEFT] & BIT6;
    Md.fgStall[LEFT]    = Md.byMotStatus[LEFT] & BIT7;

    Md.fgAlarm[RIGHT]    = Md.byMotStatus[RIGHT] & BIT0;
    Md.fgCtrlFail[RIGHT] = Md.byMotStatus[RIGHT] & BIT1;
    Md.fgOverVolt[RIGHT] = Md.byMotStatus[RIGHT] & BIT2;
    Md.fgOverTemp[RIGHT] = Md.byMotStatus[RIGHT] & BIT3;
    Md.fgOverLoad[RIGHT] = Md.byMotStatus[RIGHT] & BIT4;
    Md.fgHallFail[RIGHT] = Md.byMotStatus[RIGHT] & BIT5;
    Md.fgInvVel[RIGHT]   = Md.byMotStatus[RIGHT] & BIT6;
    Md.fgStall[RIGHT]    = Md.byMotStatus[RIGHT] & BIT7;

    Md.fgIntSpeed[LEFT]  = Md.byIOMonitor[LEFT] & BIT0;
    Md.fgDirection[LEFT] = (Md.byIOMonitor[LEFT] & BIT2)>>2;
    Md.fgRunBrake[LEFT]  = (Md.byIOMonitor[LEFT] & BIT3)>>3;
    Md.fgStartStop[LEFT] = (Md.byIOMonitor[LEFT] & BIT4)>>4;
    Md.fgEncoderA[LEFT]  = (Md.byIOMonitor[LEFT] & BIT5)>>5;
    Md.fgEncoderB[LEFT]  = (Md.byIOMonitor[LEFT] & BIT6)>>6;

    Md.fgIntSpeed[RIGHT]  = Md.byIOMonitor[RIGHT] & BIT0;
    Md.fgDirection[RIGHT] = (Md.byIOMonitor[RIGHT] & BIT2)>>2;
    Md.fgRunBrake[RIGHT]  = (Md.byIOMonitor[RIGHT] & BIT3)>>3;
    Md.fgStartStop[RIGHT] = (Md.byIOMonitor[RIGHT] & BIT4)>>4;
    Md.fgEncoderA[RIGHT]  = (Md.byIOMonitor[RIGHT] & BIT5)>>5;
    Md.fgEncoderB[RIGHT]  = (Md.byIOMonitor[RIGHT] & BIT6)>>6;


    //nGap = Md.sTheta - nExsTheta;
    //ROS_INFO("%4d %4d", nGap, Md.sTheta);
    //nExsTheta = Md.sTheta;
    //ROS_INFO("%d, %d, %d, %d", Md.sCmdLinearVel, Md.sRealLinearVel, Md.sCmdAngularVel, Md.sRealAngularVel);
    // printf("sub-> x: %ld  y: %ld  theta: %3.1f  linearVel: %d  angularVel: %4.1f  L_Cur: %d  R_Cur: %d  US1:%d  US2:%d  US3:%d  "
    //        "volt:%d  Emergecy:%d  Charge:%d  DocState:%d  LMotStatu:%d  RMotStatu:%d  LDirPin:%d  LSSPin:%d  "
    //        "RDirPin:%d  RSSPin:%d \n",
    //        Md.lPosiX, Md.lPosiY, Md.fTheta, Md.sRealLinearVel, Md.fRealAngularVel, Md.sCurrent[LEFT], Md.sCurrent[RIGHT], Md.byUS1, Md.byUS2, Md.byUS3, Md.sVoltIn,
    //        Md.fgEmerON, Md.fgBatChargeON, Md.fgRccState, Md.byMotStatus[LEFT], Md.byMotStatus[RIGHT], Md.fgDirection[LEFT], Md.fgStartStop[LEFT]
    //        , Md.fgDirection[RIGHT], Md.fgStartStop[RIGHT]);
}
/////////////////////////////////////for example to get the 'Md.sCmdAngularVel'////////////////
void keyboardCallBack(const geometry_msgs::Twist& keyVel)   //from turtlebot3_teleop_key node
{
	Md.sCmdLinearVel  = keyVel.linear.x * 1000.0;// mm/s
    if(Md.nAngleResolution)
        Md.sCmdAngularVel = RAD2DEG(keyVel.angular.z) * 10.0;// 0.1 deg/s
    else
        Md.sCmdAngularVel = RAD2DEG(keyVel.angular.z);// 1 deg/s
}
///////////////////////////////////////////////////////////////////////////////////////////////

void imuCallBack(const sensor_msgs::Imu& imuMsg) {
    double roll=0;
    double pitch=0;
    double yaw=0;

    tf::Quaternion q(imuMsg.orientation.x, imuMsg.orientation.y, imuMsg.orientation.z, imuMsg.orientation.w);
    tf::Matrix3x3 m(q);
    m.getRPY(roll, pitch, yaw);

    globalYaw_ = yaw;
    //printf("sub-> yaw: %3.1f\n", globalYaw_);
}

void nomotionCallBack(const std_msgs::Empty::ConstPtr & _is_nomotionupdate)
{
    is_nomotionupdate = true;
}

void pingCallback(const std_msgs::Bool& msg){
    isResponsedServerPing_ = msg.data;
    if (isResponsedServerPing_){
        //ROS_INFO("ping : true");
    }
    else {
        ROS_INFO("MD ping to 192.168.10.1 : false");
    }    
}

void moveBaseAliveStateCallBack(const std_msgs::String& msg){
    moveBaseAliveState_ = msg.data;
}

void slamGmappingAliveStateCallback(const std_msgs::String& msg){
    slamGmappingAliveState_ = msg.data;
}

void isRangeSensorTfErrorCallback(const std_msgs::Empty & msg){
    isRangeSensorTfError_ = true;
    rangeSensorTfErrorCount_ = 0 ;
}

void frontLaserAliveStateCallback(const std_msgs::String & msg){
    frontLaserAliveState_ = msg.data;
}

void rearLaserAliveStateCallback(const std_msgs::String & msg){
    rearLaserAliveState_ = msg.data;
}

//Node main function
int main(int argc, char** argv)
{
    static int nResolution, nCnt1, nOperMode, nResetOdometry, nResetAngle, nResetAlarm;

    ros::init(argc, argv, "vel_cmd_node");                                                //Node name initialization.
    ros::NodeHandle nh;                                                                   //Node handle declaration for communication with ROS system.
    ros::Publisher cmd_vel_pub = nh.advertise<md::vel_msg>("vel_topic", 10);             //Publisher declaration.
    ros::Subscriber monitor_sub = nh.subscribe("monitor_topic", 10, monitorCallBack);    //Subscriber declaration.
    ros::Subscriber keyboard_sub = nh.subscribe("cmd_vel", 10, keyboardCallBack);
    ros::Subscriber imu_sub = nh.subscribe("imu", 10, imuCallBack);    //mskim add
    
    ros::Subscriber nomotion_sub = nh.subscribe("need_nomotionupdate", 10, nomotionCallBack);
    ros::Subscriber ping_sub = nh.subscribe("ping/response", 1, pingCallback);
    ros::Subscriber move_base_alive_sub = nh.subscribe("move_base_alive_state", 10, moveBaseAliveStateCallBack);
    ros::Subscriber slam_gmapping_alive_sub = nh.subscribe("slam_gmapping_alive_state", 10, slamGmappingAliveStateCallback);
    ros::Subscriber is_range_sensor_tf_error_sub = nh.subscribe("/is_range_sensor_tf_error", 10, isRangeSensorTfErrorCallback);

    ros::Subscriber front_laser_alive_sub = nh.subscribe("/front_laser_alive_state", 1, frontLaserAliveStateCallback);
    ros::Subscriber rear_laser_alive_sub = nh.subscribe("/rear_laser_alive_state", 1, rearLaserAliveStateCallback);

    ros::Publisher is_md_available_pub = nh.advertise<std_msgs::Bool>("/is_md_available", 10);

    //mskim add, for call rosservice
    ros::ServiceClient nomotionUpdateClient = nh.serviceClient<std_srvs::Empty>("/request_nomotion_update");
    std_srvs::Empty srv;
    //mskim, add odometery publisher, tf publisher
    ros::Publisher odom_pub = nh.advertise<nav_msgs::Odometry>("odom", 50);

    ros::Rate r(20);                                                                      //Set the loop period -> 50ms.

    nOperMode = 0;
    md::vel_msg vel;          //vel_msg declares message 'vel' as message file.
    nh.getParam("md_node/angleresolution", Md.nAngleResolution);
    
    ///////////////////////////////////////////////////////////////////
    std_srvs::Empty::Request req;
    std_srvs::Empty::Response resp;
    std_msgs::Int32 move_data;
    // Odometry Initialize
    nav_msgs::Odometry odom;
    odom.pose.pose.position.x = 0.0;
    odom.pose.pose.position.y = 0.0;
    odom.pose.pose.position.z = 0.0;

    odom.pose.pose.orientation.x = 0.0;
    odom.pose.pose.orientation.y = 0.0;
    odom.pose.pose.orientation.z = 0.0;
    odom.pose.pose.orientation.w = 0.0;

    odom.twist.twist.linear.x = 0.0;
    odom.twist.twist.linear.y = 0.0;
    odom.twist.twist.angular.z = 0.0;

    double x = 0.0;
    double y = 0.0;
    double th = 0.0; 
    int is_move_count = 0;
    int nomotionupdate_count = 0;

    ros::Time current_time, last_time;
    current_time = ros::Time::now();
    last_time = ros::Time::now();
    isRangeSensorTfError_ = false;
    rangeSensorTfErrorCount_ = 0;

    while(ros::ok())
    {
        if(nCnt1++ == 10)     //Store the value of the parameter in the variable once per 500mS.
        {
            nCnt1 = 0;
            nh.getParam("vel_cmd_node/reset_odometry", nResetOdometry);
            nh.getParam("vel_cmd_node/reset_angle", nResetAngle);
            nh.getParam("vel_cmd_node/reset_alarm", nResetAlarm);
        }

		if(is_nomotionupdate)
        {
            if(nomotionupdate_count<700){
                nomotionUpdateClient.call(srv);
                nomotionupdate_count++;
        }
            else
            {
                is_nomotionupdate = false;
                nomotionupdate_count = 0;
            }
        }
        
        // if (isResponsedServerPing_ && (moveBaseAliveState_ =="is alive" || slamGmappingAliveState_ == "is alive") && (frontLaserAliveState_ == "is alive") && (rearLaserAliveState_ == "is alive") ){
        //     vel.nLinear         = Md.sCmdLinearVel;
        //     vel.nAngular        = Md.sCmdAngularVel;
        //     std_msgs::Bool boolMsg;
        //     boolMsg.data = true;
        //     is_md_available_pub.publish( boolMsg );
        // }
        // else {
        //     vel.nLinear         = 0;
        //     vel.nAngular        = 0;
        //     std_msgs::Bool boolMsg;
        //     boolMsg.data = false;
        //     is_md_available_pub.publish( boolMsg );
        // }
        
        vel.nLinear         = Md.sCmdLinearVel;
        vel.nAngular        = Md.sCmdAngularVel;
        vel.byResetOdometry = nResetOdometry;
        vel.byResetAngle    = nResetAngle;
        vel.byResetAlarm    = nResetAlarm;
        cmd_vel_pub.publish(vel);                 //Publish the message 'vel'

        ros::spinOnce();
        current_time = ros::Time::now();

        double dt = (current_time - last_time).toSec();
        //double delta_x = (odom_vel[0] * cos(th) - odom_vel[1] * sin(th)) * dt;
        //double delta_y = (odom_vel[0] * sin(th) + odom_vel[1] * cos(th)) * dt;
        double delta_th = odom_pose[2] * dt; //odom_vel[2] * dt;

        //x += (Md.sRealLinearVel)/1000.0 * cos(globalYaw_) * dt;
        //y += (Md.sRealLinearVel)/1000.0 * sin(globalYaw_) * dt;

        x = (Md.lPosiY/1000.0);
        y = (Md.lPosiX/1000.0);

        //th = Md.fTheta-90;
        th = -Md.fTheta;


        geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromYaw(DEG2RAD(th));
        //geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromYaw(globalYaw_);

        tf2::Quaternion q_orig, q_rot, q_new;
        q_orig.setRPY(0,0,DEG2RAD(th));

        q_rot.setRPY(0,0,3.14159);
        q_new = q_rot * q_orig;
        q_new.normalize();


        //next, we'll publish the odometry message over ROS
        odom.header.stamp = current_time;
        odom.header.frame_id = "odom";
   
        //set the position
        odom.pose.pose.position.x = x;
        odom.pose.pose.position.y = y;
        odom.pose.pose.position.z = 0.0;
        odom.pose.pose.orientation = odom_quat;
        //tf2::convert(q_new, odom.pose.pose.orientation);

        //set the velocity
        //odom.child_frame_id = "base_link"
        odom.twist.twist.linear.x = (Md.sRealLinearVel)/1000.0;
        odom.twist.twist.linear.y = 0;

        odom.twist.twist.angular.z = DEG2RAD(Md.fRealAngularVel);
        //odom.twist.twist.angular.z = globalYaw_ - previousYaw_;

		odom.pose.covariance[0] = 0.00001;
		odom.pose.covariance[7] = 0.00001;
		odom.pose.covariance[14] = 10000000000.0;
		odom.pose.covariance[21] = 10000000000.0;
		odom.pose.covariance[28] = 10000000000.0;
		odom.pose.covariance[35] = 0.00001;
		odom.twist.covariance = odom.pose.covariance;
		
		odom_pub.publish(odom);
        last_time = current_time;

        previousYaw_ = globalYaw_;


        if (isRangeSensorTfError_){
            ++ rangeSensorTfErrorCount_;
            if (rangeSensorTfErrorCount_ == 200){
                isRangeSensorTfError_ = false;
                rangeSensorTfErrorCount_ = 0;
            }
        }
        
        r.sleep();                                //Go to sleep according to the loop period defined
    }
}
