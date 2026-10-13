#include "ros/ros.h"
#include "ros/console.h"
#include <string>
#include <time.h>
#include <iostream>
#include <move_base_msgs/MoveBaseActionResult.h>
#include <move_base_msgs/MoveBaseActionGoal.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <std_msgs/String.h>
#include <std_msgs/Int32.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Bool.h>
#include <sstream>
#include <vector>
#include <tf2/LinearMath/Quaternion.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <geometry_msgs/Twist.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <cmath>
#include <jsoncpp/json/json.h>
#include <fstream>


#define PI 3.141592
#define DEG2RAD (PI / 180.0)
#define RAD2DEG (180.0 / PI)

int moveBaseResultStatus_;
std::string moveBaseResultText_;
int year_;
int month_;
int day_;
int hour_;
int min_;
int sec_;
int currentRouteRepetition_;

int goalRouteRepetition_;

bool isCharging_;

ros::Publisher goToChargePub_;

ros::Publisher moveGoalPublisher_;

ros::Publisher cmdVelPub_;

ros::Publisher moveRequestPublisher_;
ros::Publisher isStopPublisher_; //5.27
ros::Publisher waypointPublisher_;

ros::Publisher speakRequestPublisher_;
ros::Publisher mediaRequestPublisher_;

bool isRequestedScheduleDriving_;

bool isRequestApproved_;

int currentWaypoint_;

bool isWaypointChanged_ ;

bool isScheduleMovementActivating_;

bool isResumingWaypointDriving_;

//std::string currentScheduleMovement_;

std::vector<std::string> taskVector_; // "none", "turn-left", "pause" , "turn-right"
std::vector<int> taskTimesVector_;
std::vector<int> taskNumberVector_;
std::vector<int> scheduleMovementVector_;       //  0: nothing // 1: pause // -10 : turn left // 10 : turn right

// 9.12
std::vector<std::string> topicNames_;
std::vector<std::string> topicTypes_;
std::vector<std::string> topicDataString_;
std::vector<int> topicDataInt_;

geometry_msgs::PoseWithCovarianceStamped currentAmclPose_;

geometry_msgs::PoseStamped lastWaypointPose_;

int waypointChangingEnableCount_;

int currentTaskTimes_;

int turnYawDifferencePeakCount_;
int turnYawDifferenceNegativeCount_;

bool isPathRunning_;

enum TASK_STATE{
    NONE,
    PAUSE,
    TURN_LEFT,
    TURN_RIGHT,
    RESUMING,
    SPEAK,
    MEDIA,
    //9.12
    TOPIC
};

TASK_STATE currentTaskState_;

tf2::Quaternion targetPoseQuaternionInverse_;

int resumeCount_;

const std::string currentDateTime() {
    time_t     now = time(0);
    struct tm  tstruct;
    char       buf[80];
    tstruct = *localtime(&now);
    year_ = tstruct.tm_year;
    month_ = tstruct.tm_mon;
    day_ = tstruct.tm_mday;
    hour_ = tstruct.tm_hour;
    min_ = tstruct.tm_min;
    sec_ = tstruct.tm_sec;

    strftime(buf, sizeof(buf), "%Y-%m-%d %X", &tstruct); // YYYY-MM-DD.HH:mm:ss
    //std::cout << year_ << " " << month_ << " " << day_ << " " << hour_ << " " << min_ << " " << sec_ << std::endl;

    return buf;
}

void moveBaseResultCallback( const move_base_msgs::MoveBaseActionResult & msg ){
    moveBaseResultStatus_ = msg.status.status;
    moveBaseResultText_ = msg.status.text;

}

void currentRouteRepetitionCallback( const std_msgs::Int32 & msg){
    currentRouteRepetition_ = msg.data;
}

void isChargingCallback( const std_msgs::Bool & msg){
    isCharging_ = msg.data;
}

void ackScheduleDrivingCallback( const std_msgs::Bool & msg){
    ROS_INFO("Ack callback");
    if (isRequestedScheduleDriving_){
        if (msg.data){
            isRequestApproved_  = true;
            isRequestedScheduleDriving_ = false;
        }
    }
}

void currentWaypointCallback(const std_msgs::Int32 & _current_waypoint_msg){

    if (currentWaypoint_ != _current_waypoint_msg.data){
        isWaypointChanged_ = true;
        std::cout << "waypoint changed : " << _current_waypoint_msg.data << std::endl;
        //currentScheduleMovement_ = taskVector_[currentWaypoint_];
        //currentGoalTaskTimes_ = taskTimesVector_[currentWaypoint_];
        if (currentTaskState_ != RESUMING && taskVector_.size() >0 && _current_waypoint_msg.data != -1){

            if(taskVector_[_current_waypoint_msg.data] != "none"){
                
                // 5.27
                std_msgs::Int32 msg;
                msg.data = 1;
                moveRequestPublisher_.publish(msg);
                // std_msgs::Bool msg;
                // msg.data = true;       
                // isStopPublisher_.publish(msg);       
                currentTaskTimes_ = 0;
                
                if (taskVector_[_current_waypoint_msg.data] == "pause"){
                    currentTaskState_ = PAUSE;
                    std::cout << "current state = pause " << std::endl;
                }
                else if ( taskVector_[_current_waypoint_msg.data] == "rotate-left" ){
                    tf2::Quaternion currentTargetPoseQuaternion(currentAmclPose_.pose.pose.orientation.x, currentAmclPose_.pose.pose.orientation.y, currentAmclPose_.pose.pose.orientation.z ,currentAmclPose_.pose.pose.orientation.w);
                    targetPoseQuaternionInverse_ = currentTargetPoseQuaternion.inverse();
                    currentTaskState_ = TURN_LEFT;
                    turnYawDifferencePeakCount_ = 0;
                    turnYawDifferenceNegativeCount_ = 0;    
                    std::cout << "current state = turn-left " << std::endl;
                }
                else if (taskVector_[_current_waypoint_msg.data] == "rotate-right"){
                    tf2::Quaternion currentTargetPoseQuaternion(currentAmclPose_.pose.pose.orientation.x, currentAmclPose_.pose.pose.orientation.y, currentAmclPose_.pose.pose.orientation.z ,currentAmclPose_.pose.pose.orientation.w);
                    targetPoseQuaternionInverse_ = currentTargetPoseQuaternion.inverse();
                    currentTaskState_ = TURN_RIGHT;
                    turnYawDifferencePeakCount_ = 0;
                    turnYawDifferenceNegativeCount_ = 0;
                    std::cout << "current state = turn-right " << std::endl;
                }
                else if (taskVector_[_current_waypoint_msg.data] == "speak"){
                    currentTaskState_ = SPEAK;
                    std::cout << "current state = speak " << std::endl;
                }
                else if (taskVector_[_current_waypoint_msg.data] == "media"){
                    currentTaskState_ = MEDIA;
                    std::cout << "current state = media " << std::endl;
                } // 9.12          
                else if (taskVector_[_current_waypoint_msg.data] == "topic"){
                    currentTaskState_ = TOPIC;
                    std::cout << "current state = topic " << std::endl;
                }              
                else {
                    currentTaskState_ = PAUSE;
                }
            }

            
        }
    }
    
    currentWaypoint_ = _current_waypoint_msg.data;    
}

void amclPoseCallback(const geometry_msgs::PoseWithCovarianceStamped& msg){
    currentAmclPose_ = msg;
}

void updateTaskScheduleCallback(const std_msgs::String& msg){
	std::string text =  msg.data;
	//std::string text = "{\"waypoint_name\" : \"210907_111\" , \"length\" : 4 , \"tasks\" : [{\"task\" : \"none\" , \"times\" : 0},{\"task\" : \"turn-left\",\"times\" : 2},{\"task\" : \"pause\",\"times\" : 10},{\"task\" : \"turn-right\",\"times\" : 3}]}";
    Json::Value root;
    Json::Reader reader;
    bool parsingSuccessful = reader.parse( text, root );
    if ( !parsingSuccessful )
    {
        std::cout << "Error parsing the string" << std::endl;
    }

    std::string waypointName = root["waypoint_name"].asString();

    std::string taskPath = "/home/nvidia/dconic_nav/src/time_scheduler/tasks/" + waypointName + ".json";

    std::ofstream taskWritingFile(taskPath.data());
    if(taskWritingFile.is_open()){
        taskWritingFile << text ;
        taskWritingFile.close();
    }
    
}

// 9.20
void publishAndLog(const std::string& topicName, const std::string& msgType, const std::string& fileName) {
    std::ofstream logFile;
    logFile.open(fileName, std::ios_base::app);
    if (logFile.is_open()) {
        logFile << "Topic: " << topicName << ", Message Type: " << msgType 
                << ", Time: " << hour_ << ":" << min_ << ":" << sec_ << "\n";
        logFile.close();
    } else {
        std::cerr << "Unable to open log file!" << std::endl;
    }
}

void pathFileNameCallback(const std_msgs::String& msg){
    
    currentWaypoint_ = 0;
    taskVector_.clear();
    taskTimesVector_.clear();
    taskNumberVector_.clear();

    isPathRunning_ = true;

    if (msg.data == "0100return.csv"){
        return;
    }

    std::string subPath = msg.data.substr(4,msg.data.size()-8);

    std::cout << subPath << std::endl;

    std::string taskPath = "/home/nvidia/dconic_nav/src/time_scheduler/tasks/" + subPath + ".json";
    std::ifstream taskReadingFile(taskPath.data());
    if (!taskReadingFile.is_open()){
        return;
    }

    std::cout << taskPath << std::endl;

    std::string str;
	for (char p; taskReadingFile >> p;)
		str += p;

    std::cout << str << std::endl;

	Json::Reader reader;
	Json::Value root;
	bool parsingRet = reader.parse(str, root);

    //std::cout << "root: " << root << std::endl;
    

    int length = root["length"].asInt();
	std::cout << length << std::endl;

    const Json::Value tasks = root["tasks"];

    taskVector_.push_back(tasks[length-1]["task"].asString());
    taskTimesVector_.push_back(tasks[length-1]["task_value"].asInt());
    taskNumberVector_.push_back(tasks[length-1]["task_num"].asInt());

    // 9.12
    topicNames_.push_back(tasks[length-1]["topic_name"].asString());
    topicTypes_.push_back(tasks[length-1]["topic_type"].asString());

    if (tasks[length-1]["topic_type"].asString() == "std_msgs/Int32") {
        topicDataInt_.push_back(tasks[length-1]["topic_data"].asInt());
    } else if (tasks[length-1]["topic_type"].asString() == "std_msgs/String") {
        topicDataString_.push_back(tasks[length-1]["topic_data"].asString());
    }


    for ( int index = 0; index < length -1 ; ++index )  
    {
        //std::cout << tasks[index] << std::endl;
		//std::cout << index << "  " << tasks[index]["task"] << std::endl;
        taskVector_.push_back(tasks[index]["task"].asString());
        taskTimesVector_.push_back(tasks[index]["task_value"].asInt());
        taskNumberVector_.push_back(tasks[index]["task_num"].asInt());

        // 9.12
        topicNames_.push_back(tasks[index]["topic_name"].asString());
        topicTypes_.push_back(tasks[index]["topic_type"].asString());

        if (tasks[index]["topic_type"].asString() == "std_msgs/Int32") {
            topicDataInt_.push_back(tasks[index]["topic_data"].asInt());
        } else if (tasks[index]["topic_type"].asString() == "std_msgs/String") {
            topicDataString_.push_back(tasks[index]["topic_data"].asString());
        }

    }   

    for (int i = 0 ; i < taskVector_.size() ; ++i){
        std::cout << taskVector_[i] << " " << taskTimesVector_[i] << " " << taskNumberVector_[i] << std::endl;
    }

    
}

void moveRequestCallback(const std_msgs::Int32& msg){
    // if pause button pressed
    // if (msg.data == 1){
    //     currentTaskState_ = NONE;
    //     geometry_msgs::Twist movingTwistMsg;
    //     movingTwistMsg.linear.x = 0.0; 
    //     movingTwistMsg.angular.z = 0.0;
    //     cmdVelPub_.publish(movingTwistMsg);
    // }
    // else if (msg.data == 2){
    //     currentTaskState_ = RESUMING;
    //     resumeCount_ = 0;
    // }
} 

void pathRunCancelRequestCallback(const std_msgs::Empty& msg){
    currentTaskState_ = NONE;
    geometry_msgs::Twist movingTwistMsg;
    movingTwistMsg.linear.x = 0.0; 
    movingTwistMsg.angular.z = 0.0;
    cmdVelPub_.publish(movingTwistMsg);
    taskVector_.clear();
    taskTimesVector_.clear();
    taskNumberVector_.clear();
    //9.12
    topicNames_.clear();
    topicTypes_.clear();
    topicDataInt_.clear();
    topicDataString_.clear();
}

void parkingStartCallback(const std_msgs::Int32& msg){
    isPathRunning_ = false;
}

int main(int argc, char **argv)
{
    ROS_INFO("time_scheduler\n");
    ros::init(argc, argv, "time_scheduler");
    ros::NodeHandle nh;
    ros::Rate r(1.0);    

    year_ = 0;
    month_ = -1;
    day_ = 0;
    hour_ = 0;
    min_ = 0;
    sec_ = 0;

    goalRouteRepetition_ = 4;
    currentRouteRepetition_ = 0;

    isCharging_ = false;
    isRequestedScheduleDriving_  = false;
    isRequestApproved_ = false;

    ros::Subscriber move_base_result_subscriber = nh.subscribe("/move_base/result", 1, moveBaseResultCallback);
    ros::Subscriber current_route_repetition_subscriber = nh.subscribe("/current_route_repetition_from_fw", 1, currentRouteRepetitionCallback);
    ros::Subscriber is_charging_subscriber = nh.subscribe("/is_charging", 1, isChargingCallback);
    ros::Subscriber ack_schedule_driving_subcriber = nh.subscribe("/ack_schedule_driving", 1, ackScheduleDrivingCallback);
    ros::Subscriber current_waypoint_sub = nh.subscribe("current_waypoint_from_fw", 10, currentWaypointCallback);
    ros::Subscriber amclPoseSubscriber = nh.subscribe("/amcl_pose", 10, amclPoseCallback);
	ros::Subscriber taskScheduleSubscriber = nh.subscribe("/update_task_schedule", 10, updateTaskScheduleCallback);
    ros::Subscriber pathFileNameFromMapInfoSubscriber = nh.subscribe("/path_run_request", 10, pathFileNameCallback);
    ros::Subscriber moveRequestSubscriber = nh.subscribe("/move_reqeust", 10, moveRequestCallback);
    ros::Subscriber pathRunCancelRequestSubscriber = nh.subscribe("/path_run_cancel_request", 10, pathRunCancelRequestCallback);
    ros::Subscriber parkingStartSubscriber = nh.subscribe("parking_start", 1, parkingStartCallback);
        
    ros::Publisher dateTimePublisher = nh.advertise<std_msgs::String>("date_time", 10);
    goToChargePub_ = nh.advertise<std_msgs::Empty>("go_to_charge", 10);

    moveGoalPublisher_= nh.advertise<move_base_msgs::MoveBaseActionGoal>("move_base/goal", 1);

    ros::Publisher requestScheduleDrivingPUblisher = nh.advertise<std_msgs::String>("/request_schedule_driving", 10);
    moveRequestPublisher_ = nh.advertise<std_msgs::Int32>("/move_request", 1);
    waypointPublisher_ = nh.advertise<std_msgs::String>("/waypoint_speech", 1);
    cmdVelPub_ = nh.advertise<geometry_msgs::Twist>("cmd_vel", 1);
    //speakRequestPublisher_ = nh.advertise<std_msgs::String>("/location_guide", 1);
    ros::Publisher runStartCountPublisher = nh.advertise<std_msgs::Int32>("/run_start_count", 1); 

    speakRequestPublisher_ = nh.advertise<std_msgs::String>("/event_speech", 1);
    mediaRequestPublisher_ = nh.advertise<std_msgs::Int32>("/request_display", 1);

    ros::Publisher startAutoParkingPublisher = nh.advertise<std_msgs::Empty>("/start_auto_parking", 1);
    ros::Publisher pathRunRequestPublisher = nh.advertise<std_msgs::String>("/path_run_request", 1);
    ros::Publisher requestRunStartPublisher = nh.advertise<std_msgs::Empty>("/request_run_start", 1); 

    ros::Publisher hdmiSwitchPublisher = nh.advertise<std_msgs::Int32>("/hdmi_switch", 1); 

    std::string pathNameForRun = "0400park_map_12_3_211104_all.csv";

    lastWaypointPose_.header.frame_id = "map";
    lastWaypointPose_.pose.position.x = 68.7000;
    lastWaypointPose_.pose.position.y = -2.0500;
    lastWaypointPose_.pose.position.z = 0.0;   

    isWaypointChanged_ = false;

    isScheduleMovementActivating_ = false;
    
    scheduleMovementVector_.push_back(0);
    scheduleMovementVector_.push_back(0);
    scheduleMovementVector_.push_back(-10);
    scheduleMovementVector_.push_back(0);

    int scheduleMovingCount = 0;
       
    waypointChangingEnableCount_ = 0;
    //currentScheduleMovement_ = "none";
    //currentGoalTaskTimes_ = 0;

    currentTaskTimes_ = 0;

    double previousYaw;
    bool isDecreasingYawVariance = false;

    currentTaskState_ = NONE;

    isResumingWaypointDriving_ = false;
    resumeCount_ = 0;

    turnYawDifferencePeakCount_ = 0;
    turnYawDifferenceNegativeCount_ = 0;

    bool isOver180;

    isPathRunning_  = false;

    // std::vector<std::string> commands = {"say_hello", "say_safety", "say_gpt"};
    std::vector<std::string> commands = {"flyinglet", "stelladeck", "airpath"};

    int countForNews = 0;

    while (ros::ok())
    {  
        //std::cout << currentDateTime() << std::endl;
        std::string dateTime = currentDateTime();

        std_msgs::String datetimeStringMsg;
        datetimeStringMsg.data = dateTime;
        dateTimePublisher.publish(datetimeStringMsg);        

        // <parc1 250224>
        //Time Driving schduling
        if (min_ == 0 && sec_ == 0){

            if (isPathRunning_){
                if(hour_ == 10 || hour_ == 13 || hour_ == 16 || hour_ == 19){
                    std_msgs::Empty emptyMsg;
                    startAutoParkingPublisher.publish(emptyMsg);
                }
            }
            else {
                if(hour_ == 11 || hour_ ==14 || hour_ == 17){
                    // std_msgs::String pathFileNameMsg;

                    // pathFileNameMsg.data = "4000parc1_240325_wp2_9p.csv";
                    
                    // pathRunRequestPublisher.publish(pathFileNameMsg);
                    //std_msgs::Empty emptyMsg;
                    //requestRunStartPublisher.publish(emptyMsg);

                    std_msgs::Int32 runStartCountMsg;
                    runStartCountMsg.data = 4;
                    runStartCountPublisher.publish(runStartCountMsg);

                    std_msgs::Int32 mediaRequestMsg;
                    mediaRequestMsg.data = 2;
                    mediaRequestPublisher_.publish(mediaRequestMsg);

                }
            }
        }

        // </parc1 250224>


        // <office debugging 250224>
        // if (sec_ == 0){

        //     if (isPathRunning_){
        //         if(min_ == 10 || min_ == 30 || min_ == 50){
        //             std_msgs::Empty emptyMsg;
        //             startAutoParkingPublisher.publish(emptyMsg);
        //         }
        //     }
        //     else {
        //         if(min_ == 0 || min_ == 20 || min_ == 40 ){
        //             // std_msgs::String pathFileNameMsg;

        //             // pathFileNameMsg.data = "4000parc1_240325_wp2_9p.csv";
                    
        //             // pathRunRequestPublisher.publish(pathFileNameMsg);
        //             //std_msgs::Empty emptyMsg;
        //             //requestRunStartPublisher.publish(emptyMsg);

        //             std_msgs::Int32 runStartCountMsg;
        //             runStartCountMsg.data = 4;
        //             runStartCountPublisher.publish(runStartCountMsg);

        //         }
        //     }
        // }
        // </office debugging 250224>
        
        /////// TASK scheduling
        switch(currentTaskState_){
            case PAUSE :
            {                
                if (currentTaskTimes_ < taskTimesVector_[currentWaypoint_]){
                    ++currentTaskTimes_;

                    geometry_msgs::Twist movingTwistMsg;
                    movingTwistMsg.linear.x = 0.0; 
                    movingTwistMsg.angular.z = 0.0;
                    cmdVelPub_.publish(movingTwistMsg);

                    std::cout << "PAUSE taskTimesVector_[currentWaypoint_] : " << taskTimesVector_[currentWaypoint_] << "  currentTaskTimes_ : " << currentTaskTimes_ << std::endl;

                }
                else{
                    // 5.27
                    resumeCount_ = 0;
                    std_msgs::Int32 msg;
                    msg.data =2;
                    moveRequestPublisher_.publish(msg);
                    // std_msgs::Bool msg;
                    // msg.data = false;       
                    // isStopPublisher_.publish(msg);   
                    isResumingWaypointDriving_ = true;
                    currentTaskState_ = RESUMING;
                }

                break;
            }

            case TURN_LEFT:
            {
                if (currentTaskTimes_ < taskTimesVector_[currentWaypoint_]){
                    tf2::Quaternion currentPoseQuaternion(currentAmclPose_.pose.pose.orientation.x, currentAmclPose_.pose.pose.orientation.y, currentAmclPose_.pose.pose.orientation.z ,currentAmclPose_.pose.pose.orientation.w);                    
                    tf2::Quaternion relationQuaternion = currentPoseQuaternion * targetPoseQuaternionInverse_;
                    geometry_msgs::Pose relationPose;
                    tf2::convert(relationQuaternion, relationPose.orientation);                    
                    double siny_cosp = 2 * (relationPose.orientation.w * relationPose.orientation.z);
                    double cosy_cosp = 1 - 2 * (relationPose.orientation.z * relationPose.orientation.z);
                    double relativeYaw = std::atan2(siny_cosp, cosy_cosp) * RAD2DEG;

                    if (  isOver180 && relativeYaw * previousYaw < 0  ){
                        isOver180 = false;
                        std::cout << "++currentTaskTimes" << std::endl;
                        ++currentTaskTimes_;
                    }
                    
                    if ( relativeYaw - previousYaw < -300 ){
                        isOver180 = true;
                    }

                    std::cout << "yaw : " << relativeYaw  << std::endl;
                    
                    previousYaw = relativeYaw;

                    geometry_msgs::Twist movingTwistMsg;
                    movingTwistMsg.linear.x = 0.0; 
                    movingTwistMsg.angular.z = 0.2;
                    cmdVelPub_.publish(movingTwistMsg);

                    std::cout << "TURN-LEFT taskTimesVector_[currentWaypoint_] : " << taskTimesVector_[currentWaypoint_] << "  currentTaskTimes_ : " << currentTaskTimes_ << std::endl;
                }
                else{
                    geometry_msgs::Twist movingTwistMsg;
                    movingTwistMsg.linear.x = 0.0; 
                    movingTwistMsg.angular.z = 0.0;
                    cmdVelPub_.publish(movingTwistMsg);    

                    // 5.27
                    resumeCount_ = 0;
                    std_msgs::Int32 msg;
                    msg.data =2;
                    moveRequestPublisher_.publish(msg);
                    // std_msgs::Bool msg;
                    // msg.data = false;       
                    // isStopPublisher_.publish(msg);   
                    isResumingWaypointDriving_ = true;
                    currentTaskState_ = RESUMING;
                }
                break;
            }

            case TURN_RIGHT:
            {   
                if (currentTaskTimes_ < taskTimesVector_[currentWaypoint_]){
                    tf2::Quaternion currentPoseQuaternion(currentAmclPose_.pose.pose.orientation.x, currentAmclPose_.pose.pose.orientation.y, currentAmclPose_.pose.pose.orientation.z ,currentAmclPose_.pose.pose.orientation.w);                    
                    tf2::Quaternion relationQuaternion = currentPoseQuaternion * targetPoseQuaternionInverse_;
                    geometry_msgs::Pose relationPose;
                    tf2::convert(relationQuaternion, relationPose.orientation);                    
                    double siny_cosp = 2 * (relationPose.orientation.w * relationPose.orientation.z);
                    double cosy_cosp = 1 - 2 * (relationPose.orientation.z * relationPose.orientation.z);
                    double relativeYaw = std::atan2(siny_cosp, cosy_cosp) * RAD2DEG;

                     if (  isOver180 && relativeYaw * previousYaw < 0  ){
                        isOver180 = false;
                        std::cout << "++currentTaskTimes" << std::endl;
                        ++currentTaskTimes_;
                    }
                    
                    if ( relativeYaw - previousYaw > 300 ){
                        isOver180 = true;
                    }
                    std::cout << "yaw : " << relativeYaw << "  PeakCount : " << turnYawDifferencePeakCount_ << "  negativeCount : " << turnYawDifferenceNegativeCount_ << std::endl;
                   
                    previousYaw = relativeYaw;

                    geometry_msgs::Twist movingTwistMsg;
                    movingTwistMsg.linear.x = 0.0; 
                    movingTwistMsg.angular.z = -0.2;
                    cmdVelPub_.publish(movingTwistMsg);
                    std::cout << "TURN-RIGHT taskTimesVector_[currentWaypoint_] : " << taskTimesVector_[currentWaypoint_] << "  currentTaskTimes_ : " << currentTaskTimes_ << std::endl;
                }

                else{
                    resumeCount_ = 0;

                    geometry_msgs::Twist movingTwistMsg;
                    movingTwistMsg.linear.x = 0.0; 
                    movingTwistMsg.angular.z = 0.0;
                    cmdVelPub_.publish(movingTwistMsg);    

                    // 5.27
                    std_msgs::Int32 msg;
                    msg.data =2;
                    moveRequestPublisher_.publish(msg);
                    // std_msgs::Bool msg;
                    // msg.data = false;       
                    // isStopPublisher_.publish(msg);
                    isResumingWaypointDriving_ = true;
                    currentTaskState_ = RESUMING;
                }
                break;  
            }

            case RESUMING:
            {
                std::cout << "RESUMING " << std::endl;
                if (resumeCount_ >= 2){
                    resumeCount_ = 0;
                    currentTaskState_ = NONE;
                }
                else {
                    ++resumeCount_;
                }
                break;
            }

            case SPEAK:
            {   
                if (currentTaskTimes_ < taskTimesVector_[currentWaypoint_]){
                    if (currentTaskTimes_ == 0){
                        std::cout << "SPEAK GUIDE " << std::endl;
                        std_msgs::String msg;
                        msg.data = commands[taskNumberVector_[currentWaypoint_]];
                        speakRequestPublisher_.publish(msg);
                    }
                    ++currentTaskTimes_;

                    std::cout << "PAUSE" << taskTimesVector_[currentWaypoint_] << "  currentTaskTimes_ : " << currentTaskTimes_ << std::endl;
                }
                else{
                    // 5.27
                    std_msgs::Int32 msg;
                    msg.data =2;
                    moveRequestPublisher_.publish(msg);
                    // std_msgs::Bool msg;
                    // msg.data = false;       
                    // isStopPublisher_.publish(msg);
                    isResumingWaypointDriving_ = true;
                    currentTaskState_ = RESUMING;
                }             

                break;
            }
            case MEDIA:
            {                
                if (currentTaskTimes_ < taskTimesVector_[currentWaypoint_]){
                    if (currentTaskTimes_ == 0){
                        std::cout << "MEDIA GUIDE " << std::endl;
                        std_msgs::Int32 msg;
                        msg.data = taskNumberVector_[currentWaypoint_];
                        mediaRequestPublisher_.publish(msg);
                    }
                    ++currentTaskTimes_;

                    std::cout << "PAUSE" << taskTimesVector_[currentWaypoint_] << "  currentTaskTimes_ : " << currentTaskTimes_ << std::endl;
                }
                else{
                    // 5.27
                    // std_msgs::Int32 msg;
                    // msg.data =2;
                    // moveRequestPublisher_.publish(msg);
                    std_msgs::Bool msg;
                    msg.data = false;       
                    isStopPublisher_.publish(msg);
                    isResumingWaypointDriving_ = true;
                    currentTaskState_ = RESUMING;
                }             

                break;

            }
            case TOPIC: // 9.12
            {                
                if (currentTaskTimes_ < taskTimesVector_[currentWaypoint_]){
                    if (currentTaskTimes_ == 0){
                        std::cout << "TOPIC GUIDE " << std::endl;
                        std_msgs::String msg;
                        msg.data = topicDataString_[currentWaypoint_];
                        waypointPublisher_.publish(msg);
                        std::cout << "Publish: " << topicNames_[currentWaypoint_] << "msg: " << msg.data << std::endl;
                    }



                    //     if (topicTypes_[currentWaypoint_] == "std_msgs/Int32") {
                    //         std_msgs::Int32 msg;
                    //         msg.data = topicDataInt_[currentWaypoint_];
                    //         ros::Publisher publisher = nh.advertise<std_msgs::Int32>(topicNames_[currentWaypoint_], 10);
                    //         publisher.publish(msg);
                    //     } else if (topicTypes_[currentWaypoint_] == "std_msgs/String") {
                    //         std_msgs::String msg;
                    //         msg.data = topicDataString_[currentWaypoint_];
                    //         ros::Publisher publisher = nh.advertise<std_msgs::String>(topicNames_[currentWaypoint_], 10);
                    //         publisher.publish(msg);
                    //         std::cout << "Publish" << topicNames_[currentWaypoint_] << "msg:" << msg.data << std::endl;
                    //     }
                    

                    ++currentTaskTimes_;

                    std::cout << "PAUSE" << taskTimesVector_[currentWaypoint_] << "  currentTaskTimes_ : " << currentTaskTimes_ << std::endl;
                }
                else{
                    std_msgs::Int32 msg;
                    msg.data =2;
                    moveRequestPublisher_.publish(msg);
                    isResumingWaypointDriving_ = true;
                    currentTaskState_ = RESUMING;
                }             

                break;

            }
            default:
            {

                break;
            }
        }
                
        ros::spinOnce();
        r.sleep();
    }
}

