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
#include <std_msgs/Int32.h>
#include <std_msgs/Float32.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Bool.h>
#include <std_msgs/UInt64.h>
#include <string>

#include <diagnostic_aggregator/analyzer.h>
#include <diagnostic_aggregator/status_item.h>
#include <diagnostic_msgs/DiagnosticStatus.h>
#include <diagnostic_msgs/DiagnosticArray.h>

#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <rosgraph_msgs/Log.h>
#include <nav_msgs/Odometry.h>

std::string frontLaserState_;
std::string rearLaserState_;
std::string imuState_;
std::string mdMotorState_;
std::string usbCamState_;
std::string sonarState_;
std::string moveBaseState_;
std::string slamGmappingState_;

double robotSpeed_;

std::string batteryStatus_;
double batteryPercentage_;
double batteryTemperature_;

int networkStrength_;
int networkUpBps_;
int networkDownBps_;

double timestamp_;
double previousTimestamp_;

double journeyStartingTimestamp_;

std::string driveStatus_;

std::string currentWaypointName_;

std::string mapName_;

double driveTime_;
double driveDistance_;
double trafficStatus_;

geometry_msgs::PoseWithCovarianceStamped currentAmclPose_;

geometry_msgs::PoseWithCovarianceStamped previousOdomCombined_;

double initialStartTime_;

ros::Publisher errorLogPublisher_;

int currentRouteRepetition_;

int currentWaypoint_;

bool isCharging_;

float totalCpu_;
long long totalFreeMem_;
long long totalUsedMem_;

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

                else if ( msg.status[i].values[j].key == std::string("node_alive/serial_sonar") ){
                    sonarState_ = msg.status[i].values[j].value;                    
                }                        

                else if ( msg.status[i].values[j].key == std::string("node_alive/move_base") ){
                    moveBaseState_ = msg.status[i].values[j].value;                    
                }
                
                else if (msg.status[i].values[j].key == std::string("node_alive/slam_gmapping") ){
                    slamGmappingState_ = msg.status[i].values[j].value;
                }                        
            }
        }
    }
}

void odomCombindedCallback(const geometry_msgs::PoseWithCovarianceStamped& msg){
    double differenceX = msg.pose.pose.position.x - previousOdomCombined_.pose.pose.position.x ;
    double differenceY = msg.pose.pose.position.y - previousOdomCombined_.pose.pose.position.y ;
    double distance = sqrt(differenceX * differenceX + differenceY * differenceY);
    driveDistance_ += distance;
    double deltaTime = msg.header.stamp.toSec() - previousOdomCombined_.header.stamp.toSec();
    //robotSpeed_ = distance / deltaTime ;

    previousOdomCombined_ = msg;
}

void amclPoseCallback(const geometry_msgs::PoseWithCovarianceStamped& msg){
    currentAmclPose_ = msg;
}

void drivingStatusCallback(const std_msgs::Int32& msg){
    if (msg.data == 0){
        driveStatus_ = "Stop";
        currentRouteRepetition_ = 0;
    }
    else if (msg.data == 1){
        driveStatus_ = "Pause";        
    }
    else if (msg.data == 2){
        driveStatus_ = "Driving";
    }
    else {
        driveStatus_ = "Idle";
    }
}

void mapRunningNameCallback(const std_msgs::String& msg){
    mapName_ = msg.data;
}

void waypointFileNameCallback(const std_msgs::String& msg){
    currentWaypointName_ = msg.data;
    journeyStartingTimestamp_ = ros::Time::now().toSec();
}

void batteryRemainingCallback(const std_msgs::Float32& msg){
    batteryPercentage_ = msg.data;
}

// 30. current_waypoint_sub
void currentWaypointCallback(const std_msgs::Int32 & _current_waypoint_msg){
    currentWaypoint_ = _current_waypoint_msg.data;
}


void rosoutAggCallback(const rosgraph_msgs::Log& msg){
    if (msg.level == 8 || msg.level == 16){
    std::stringstream rosoutAggSS;
    rosoutAggSS << std::fixed ;
    rosoutAggSS << "{" << std::endl << "\"level\" : " << msg.level << ","  << std::endl
                << "\"name\" : \"" << msg.name << "\"," << std::endl
                << "\"msg\" : \"" << msg.msg << "\"" << std::endl
                << "}" ;

    std_msgs::String strErrorLogMsg;
    strErrorLogMsg.data = rosoutAggSS.str().c_str();     
    errorLogPublisher_.publish(strErrorLogMsg);
    }
}

void currentRouteRepetitionCallback(const std_msgs::Int32& msg){
    currentRouteRepetition_ = msg.data;
}

void startJourneyCallback(const std_msgs::Empty& msg){
    if (currentRouteRepetition_ == 0){
        
    }
}

void odomCallback(const nav_msgs::Odometry& msg){
    robotSpeed_ = msg.twist.twist.linear.x;
}

void isChargingCallback(const std_msgs::Bool & msg){
    isCharging_ = msg.data;
}

void totalCpuCallback(const std_msgs::Float32 & msg){
	totalCpu_ = msg.data;
}

void totalFreeMemCallback(const std_msgs::UInt64 & msg){
	totalFreeMem_ = msg.data;
}

void totalUsedMemCallback(const std_msgs::UInt64 & msg){
	totalUsedMem_ = msg.data;
}

int main(int argc, char **argv)
{
    ROS_INFO("msg_json_wrapper start\n");
    ros::init(argc, argv, "msg_json_wrapper");

    ros::NodeHandle nh;
    ros::Rate r(1.0);

    ros::Subscriber diagAggSubscriber = nh.subscribe("/diagnostics_agg", 10, diagnosticsAggCallback);

    ros::Subscriber odomCombinedSubscriber = nh.subscribe("/robot_pose_ekf/odom_combined", 10, odomCombindedCallback);

    ros::Subscriber amclPoseSubscriber = nh.subscribe("/amcl_pose", 10, amclPoseCallback);

    ros::Subscriber drivingStatusSubscriber = nh.subscribe("/driving_state", 10, drivingStatusCallback);

    ros::Subscriber mapRunningSubscriber = nh.subscribe("/map_running" , 1, mapRunningNameCallback);

    ros::Subscriber waypointFileNameSubscriber = nh.subscribe("/path_run_request", 10, waypointFileNameCallback);

    ros::Subscriber batteryRemainingSubscriber = nh.subscribe("/batteryRemaining", 10, batteryRemainingCallback);
    
    ros::Subscriber rosoutLogSubscriber = nh.subscribe("/rosout_agg", 10, rosoutAggCallback);

    ros::Subscriber currentRouteRepetitionSubscriber = nh.subscribe("/current_route_repetition_from_fw", 10, currentRouteRepetitionCallback);
    
    // subscribe current waypoint
    ros::Subscriber current_waypoint_sub = nh.subscribe("current_waypoint_from_fw", 10, currentWaypointCallback);

    ros::Subscriber start_journey_sub = nh.subscribe("/start_journey", 1, startJourneyCallback);

    ros::Subscriber odom_sub = nh.subscribe("/odom", 10, odomCallback);

    ros::Subscriber is_charging_sub = nh.subscribe("/is_charging", 10, isChargingCallback);

	ros::Subscriber total_cpu_sub = nh.subscribe("/cpu_monitor/total_cpu", 10, totalCpuCallback);

	ros::Subscriber total_free_mem_sub = nh.subscribe("/cpu_monitor/total_free_mem", 10, totalFreeMemCallback);

	ros::Subscriber total_used_mem_sub = nh.subscribe("cpu_monitor/total_used_mem", 10, totalUsedMemCallback);


    ros::Publisher robotStatePublisher = nh.advertise<std_msgs::String>("robot_state_json" , 10);
    ros::Publisher robotPositionPublisher = nh.advertise<std_msgs::String>("robot_position_json", 10);

    ros::Publisher robotStateDebuggingPublisher = nh.advertise<std_msgs::String>("robot_state_debugging", 10);

    ros::Publisher moveBaseAliveStatePublisher = nh.advertise<std_msgs::String>("move_base_alive_state", 10);

    ros::Publisher slamGmappingStatePublisher = nh.advertise<std_msgs::String>("slam_gmapping_alive_state", 10);

    errorLogPublisher_ = nh.advertise<std_msgs::String>("robot_error_log", 10);

    currentRouteRepetition_ = 0;

    
    frontLaserState_ = "dead";
    rearLaserState_ = "dead";
    imuState_ = "dead";
    mdMotorState_ = "dead";
    usbCamState_ = "dead";
    sonarState_ = "dead";
    moveBaseState_ = "dead";
    
    robotSpeed_ = 0.0;

    batteryStatus_ = "idle";
    batteryPercentage_ = 67.0;
    batteryTemperature_ = 36.5;

    networkStrength_ = 100;
    networkUpBps_ = 10000;
    networkDownBps_ = 10000;
    
    timestamp_ = ros::Time::now().toSec();
    previousTimestamp_ = ros::Time::now().toSec();
    journeyStartingTimestamp_ = 0.0;

    driveStatus_ = "idle";

    currentWaypointName_ = "";

    mapName_ = "";

    driveTime_ = 0.0 ;
    driveDistance_ = 0.0 ;
    trafficStatus_ = 0.0 ;

    currentWaypoint_ = 0;

    isCharging_ = false;

    initialStartTime_ = ros::Time::now().toSec();

    while (ros::ok())
    {   
        timestamp_ = ros::Time::now().toSec();

        if (timestamp_ > 1600000000.0){

            if (initialStartTime_ < 1600000000.0){
                initialStartTime_ = timestamp_;
                previousTimestamp_ = timestamp_;
            }

            
            driveTime_ += timestamp_ - previousTimestamp_;
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

            std::stringstream robotStateSS;
            robotStateSS << std::fixed ;

            robotStateSS << "{" << std::endl << "\"speed\" : " << robotSpeed_ << ","  << std::endl
                << "\"battery\" : {"  << std::endl 
                << "\"status\" : \"" << batteryStatus_ << "\"," << std::endl
                << "\"percentage\" : " << batteryPercentage_ << "," << std::endl
                << "\"temp\" : " << batteryTemperature_ << std::endl << "}," << std::endl
                << "\"network\" : { " << std::endl << "\"strength\" : " << networkStrength_ << "," << std::endl
                << "\"up_bps\" : " << networkUpBps_ << "," << std::endl
                << "\"down_bps\" : " << networkDownBps_ << std::endl << "}," << std::endl
                << "\"initial_start_time\" : " << initialStartTime_ << "," <<std::endl
                << "\"timestamp\" : " << timestamp_ << "," <<std::endl
                << "\"drive_status\" : \"" << driveStatus_ << "\"," << std::endl
                << "\"current_waypoint_name\" : \"" << currentWaypointName_ << "\"," << std::endl
                << "\"map_name\" : \"" << mapName_ << "\"," << std::endl
                << "\"sensor_status\" : {" << std::endl << "\"frontLaser\" : \"" << frontLaserState_ << "\"," << std::endl
                << "\"rearLaser\" : \"" << rearLaserState_ << "\"," << std::endl
                << "\"imu\" : \"" << imuState_ << "\"," << std::endl
                << "\"mdMotor\" : \"" << mdMotorState_ << "\"," << std::endl
                << "\"usbCam\" : \"" << usbCamState_ << "\"," << std::endl
                << "\"sonar\" : \"" << sonarState_ << "\"" << std::endl << "}," << std::endl
                << "\"drive_time\" : " << driveTime_ << "," << std::endl
                << "\"drive_distance\" : " << driveDistance_ << "," << std::endl
                << "\"traffic\" : " << trafficStatus_ << "," << std::endl
                << "\"current_waypoint_index\" : " << currentWaypoint_ << "," << std::endl
                << "\"route_repetition\" : " << currentRouteRepetition_ << "," << std::endl
                << "\"journey_starting_time\" : " << journeyStartingTimestamp_ << "," << std::endl
                << "\"is_charging\" : " << isCharging_ << "," << std::endl
				<< "\"cpu_usage\" : " << totalCpu_ << "," << std::endl
				<< "\"free_mem\" : " << totalFreeMem_ << "," << std::endl
				<< "\"used_mem\" : " << totalUsedMem_ << std::endl
                << "}" ;

            std_msgs::String strMsg;
            strMsg.data = robotStateSS.str().c_str();     
            robotStatePublisher.publish(strMsg);

            std::stringstream robotPositionSS;
            robotPositionSS << std::fixed ;
            robotPositionSS << "{" << std::endl << "\"x\" : " << currentAmclPose_.pose.pose.position.x << ","  << std::endl
                << "\"y\" : " << currentAmclPose_.pose.pose.position.y << "," << std::endl
                << "\"z\" : " << currentAmclPose_.pose.pose.position.z << "," << std::endl
                << "\"qx\" : " << currentAmclPose_.pose.pose.orientation.x << "," << std::endl
                << "\"qy\" : " << currentAmclPose_.pose.pose.orientation.y << "," << std::endl
                << "\"qz\" : " << currentAmclPose_.pose.pose.orientation.z << "," << std::endl
                << "\"qw\" : " << currentAmclPose_.pose.pose.orientation.w << "," << std::endl
                << "\"velocity\" : " << robotSpeed_ << "," << std::endl
                << "\"timestamp\" : " << timestamp_  << "," << std::endl
                << "\"store_id\" : " << 3 << std::endl << "}" ;
            std_msgs::String strRobotPositionMsg;
            strRobotPositionMsg.data = robotPositionSS.str().c_str();        
            robotPositionPublisher.publish(strRobotPositionMsg);

            // std::cout << "frontLaser : " << frontLaserState_ << std::endl <<
            //              "rearLaser  : " << rearLaserState_ << std::endl <<
            //              "imu        : " << imuState_ << std::endl << 
            //              "mdMotor    : " << mdMotorState_ << std::endl <<
            //              "usbCam     : " << usbCamState_ << std::endl <<
            //              "sonar      : " << sonarState_ << std::endl;

            
            std::stringstream ssRobotStateDebugging;

            ssRobotStateDebugging << "battery    : " << batteryPercentage_ << std::endl <<
                                    "frontLaser : " << frontLaserState_ << std::endl <<
                                    "rearLaser  : " << rearLaserState_ << std::endl <<
                                    "imu        : " << imuState_ << std::endl << 
                                    "mdMotor    : " << mdMotorState_ << std::endl <<
                                    "usbCam     : " << usbCamState_ << std::endl <<
                                    "sonar      : " << sonarState_ << std::endl <<
                                    "driveTime  : " << driveTime_ << std::endl <<
                                    "distance   : " << driveDistance_ ;
    

            ssRobotStateDebugging.precision(5);

            std_msgs::String strMsgRobotStateDebugging;
            strMsgRobotStateDebugging.data = ssRobotStateDebugging.str().c_str();

            robotStateDebuggingPublisher.publish(strMsgRobotStateDebugging);

            std_msgs::String moveBaseAliveStateMsg;
            moveBaseAliveStateMsg.data = moveBaseState_;
            moveBaseAliveStatePublisher.publish(moveBaseAliveStateMsg);

            std_msgs::String slamGmappingAliveStateMsg;
            slamGmappingAliveStateMsg.data = slamGmappingState_ ;
            slamGmappingStatePublisher.publish(slamGmappingAliveStateMsg);

            previousTimestamp_ = timestamp_;

        }

        ros::spinOnce();
        r.sleep(); 
    }
}
