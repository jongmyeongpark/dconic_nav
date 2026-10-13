#include <ros/ros.h>
#include <serial/serial.h>
#include <std_msgs/String.h>
#include <std_msgs/Char.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Int32.h>
#include <std_msgs/Float32.h>
#include <std_msgs/Empty.h>
#include <std_msgs/Bool.h>
#include <std_srvs/Empty.h>

#include <cstdlib>
#include <ctime>
#include <boost/thread/thread.hpp>
#include <list>
#include <vector>

#include <string>
#include <sstream>
#include <iostream>
#include <fstream>

#include "media_controller/Helper.h"
#include "media_controller/VideoLength.h"
#include "media_controller/VideoPriority.h"
#include "media_controller/CongestionLevel.h"
#include "media_controller/video_info.h"


#define TOTALMEDIA 20
#define TIME_CUT_OFF 2

/**
 * Forward declaration
 */
void mediaManager(char* buffer);
void displaySerialInitialize();
void batterySerialInitialize();
Helper::RequestStatus setRequestingStatus(int recievedNumber);
void setMediaRunningTime(int recievedNumber);
int getPlayingMediaNumber();
void requestVideoInfo();

/**
 * Serial 
 */
serial::Serial displaySerial_;

/**
 * media command
 */
char command_ = 0x00;
int recievedNumber_ = 0;
double mediaRunningTime_ = 0.0;
int timer_ = 0;
int playingMediaNumber_= 0;
int totalMediaNo_ = TOTALMEDIA;
std::vector<int> videoLengthVector_;
std::vector<Helper::RequestStatus> priorityVector_;
bool isPriorityCallbackCalled_ = false;
bool isLengthCallbackCalled_ = false;

/**
 * Debugging
 */
bool isConsoleOut_ = false;

std::fstream recordedFileName_;

Helper::RequestStatus requestedStatus_ = Helper::READY;
Helper::RequestStatus requestingStatus_ = Helper::READY;
Helper::MediaStatus mediaStatus_ = Helper::REQUESTED_MEDIA_PLAYING;

//ros::Publisher requestBatteryPublisher_;
ros::Publisher requestDisplayPublisher_;
//ros::Publisher congestionLevelPublisher_;
ros::ServiceClient videoInfoClient_;

media_controller::CongestionLevelPtr congestionLevelTimePtr_ = boost::make_shared<media_controller::CongestionLevel>();


void displaySerialInitialize()
{
    try
    {
        //displaySerial_.setPort("/dev/dign");
		displaySerial_.setPort("/dev/ttyUSB_Dign");
        displaySerial_.setBaudrate(4800);
        serial::Timeout to = serial::Timeout::simpleTimeout(1000);
        displaySerial_.setTimeout(to);
        displaySerial_.open();
    }
    catch (serial::IOException& e)
    {
        ROS_ERROR_STREAM("Unable to open display serial port ");
    }

    if(displaySerial_.isOpen())
    {
        ROS_INFO_STREAM("Display serial Port initialized");
    }
    else
    {
        ROS_ERROR_STREAM("Can not open display serial port ");
    }
}


void trimToken(std::string &value)
{
	unsigned int head = value.find_first_not_of(" ");
	unsigned int tail = value.find_last_not_of(" ");

	value = value.substr(head, tail - head + 1);
}


int extractInteger(std::string value)
{
	return atoi( value.c_str() );
}


std::vector<int> getVideoInfo(const char* filePath)
{
	std::fstream recordedFileName(filePath);
	std::size_t startPosition = 0;

	std::vector<int> readData;

	if(!recordedFileName)
	{
		ROS_INFO_STREAM(filePath << " is Not exist ");
		for (int i=0; i < TOTALMEDIA; ++i)
		{
			readData.push_back(100);
		}
		return readData;
	}

	while (recordedFileName)
	{
		std::string line;
		std::getline(recordedFileName, line);

		while ( (line.length() > 0) )
		{
			std::size_t delimiterPosition = line.find_first_of(",");

			if (delimiterPosition == std::string::npos)
			{
				std::string value ( line.substr(startPosition, delimiterPosition) );
				trimToken(value);

				readData.push_back( extractInteger(value) );
				
				std::cout << value << std::endl;

				break;
			}

			std::string value ( line.substr(startPosition, delimiterPosition) );
			trimToken(value);

			readData.push_back( extractInteger(value) );

			std::cout << value << ", ";

			line.erase(0, ++delimiterPosition);
		}

		totalMediaNo_ = readData.size();
	}

	recordedFileName.close();

	return readData;
}


void charingMediaCall()
{
	srand((unsigned int)time(NULL));

    int nextMediaNumber = 2;
    setRequestingStatus(nextMediaNumber);

    requestingStatus_ = Helper::READY;
    requestedStatus_ = Helper::READY;

	std_msgs::Int32 nextMediaMsg;
    nextMediaMsg.data = nextMediaNumber;
    
    //requestDisplayPublisher_.publish(nextMediaMsg);
}


void nextMediaCall()
{
	srand((unsigned int)time(NULL));
	
    int nextMediaNumber = 0;

	if (requestedStatus_ == Helper::CHARGING)
	{
		nextMediaNumber = 2;
		ROS_INFO_STREAM("Next AD : " << nextMediaNumber);
	}
	else
	{
        requestedStatus_ = Helper::AD_MEDIA_PLAYING;
        
		do
		{
			nextMediaNumber = rand() % (totalMediaNo_ + 2); // 13 -> 0 ~ 12
			ROS_INFO_STREAM("Next AD : " << nextMediaNumber);

		} while( nextMediaNumber == 0 || nextMediaNumber == 1 || nextMediaNumber == 2 || // To readle, left.
		nextMediaNumber == 3 || nextMediaNumber == 4 || nextMediaNumber == playingMediaNumber_);
	}

	setMediaRunningTime(nextMediaNumber);
	setRequestingStatus(nextMediaNumber);
	
	displaySerial_.write(&command_);

    playingMediaNumber_ = nextMediaNumber;	
}


int getPlayingMediaNumber()
{
    return playingMediaNumber_;
}


Helper::RequestStatus setRequestingStatus(int recievedNumber)
{
    requestingStatus_ = priorityVector_[recievedNumber - 2];
	command_ = recievedNumber;

    return requestingStatus_;
}


void setMediaRunningTime(int recievedNumber)
{
	mediaRunningTime_ = videoLengthVector_[recievedNumber-2];
}


void adTimer(int* publishRate)
{
    ros::Rate loop_rate(*publishRate);

    while (ros::ok())
    {
		if(requestedStatus_ != Helper::READY)
        {
			ROS_INFO_STREAM("Now Playing : " << getPlayingMediaNumber() << " || Time : " << timer_ << " / " << mediaRunningTime_ - TIME_CUT_OFF );

            if( ++timer_ >= (mediaRunningTime_ - TIME_CUT_OFF) )
            {
                timer_ = 0;

                //nextMediaCall();
            }
        }

        loop_rate.sleep();
    }
}


void displayCallback(const std_msgs::Int32::ConstPtr & msg)
{
    //int recievedNumber = msg->data;
    // recievedNumber_ = recievedNumber;

    // Helper::RequestStatus requestingStatus = setRequestingStatus(recievedNumber);
	
    // ROS_INFO_STREAM("Recieved Number & Requested Media : " << requestingStatus << ", " << recievedNumber);

    // if( requestedStatus_ >= requestingStatus || ( recievedNumber > (totalMediaNo_+2) ) )
    // {
    //     ROS_INFO_STREAM("Requested media blocked");
    // }
    // else
    // {
    //     timer_ = 0;
    //     setMediaRunningTime(recievedNumber);
        
    //     displaySerial_.write(&command_);

    //     playingMediaNumber_ = recievedNumber;
    //     requestedStatus_ = requestingStatus;
    // }

	

	int recievedNumber = msg->data;

	std::cout << "Recieved requestDisplay => Number : " << recievedNumber << std::endl;

	command_ = recievedNumber;
	displaySerial_.write(&command_);

}


void charingCallback(const std_msgs::Empty::ConstPtr& msg)
{
	std_msgs::Int32 charingDisplayNumber;
    charingDisplayNumber.data = 2;

	//requestDisplayPublisher_.publish(charingDisplayNumber);
}


void doneCharingCallback(const std_msgs::String::ConstPtr& msg)
{
	std_msgs::Int32 charingDisplayNumber;
    charingDisplayNumber.data = 3;

    requestingStatus_ = Helper::INTEGRIT_AD;
    requestedStatus_ = Helper::READY;

	//requestDisplayPublisher_.publish(charingDisplayNumber);
}


float batteryMessageParser(char* buffer)
{
    int address = (int)buffer[2];
    int length = (int)buffer[3];
    int command = (int)buffer[4];
    int order = (int)buffer[5];

	float batteryRemaining = (buffer[8] << 16) + buffer[9];

    return batteryRemaining;
}


void displayMessageParser(char* buffer)
{
	int first = (int)buffer[0];

	std::cout << "Return from display : " << first << std::endl;
}


void pubBatteryCheckCallback(const ros::TimerEvent& e)
{
    std_msgs::Int32 temp;
    temp.data = 1;

    //requestBatteryPublisher_.publish(temp);
}


void consoleCallback(const std_msgs::Bool::ConstPtr& msg)
{
	isConsoleOut_ = msg->data;
	printf("\033[2K");
}


void videoPriorityCallback(const media_controller::VideoPriority::ConstPtr& msg)
{
	if( !isPriorityCallbackCalled_ )
	{
		std::ofstream outputFileForVideoPriority;
		outputFileForVideoPriority.open("priorityInfo.csv");
		int totalMediaNo = msg->videoPriority.size(); 

		priorityVector_.clear();

		ROS_INFO_STREAM("Video priority updated! -> " << totalMediaNo);

		for (int i = 0; i < totalMediaNo; ++i)
		{
			priorityVector_.push_back( static_cast<Helper::RequestStatus>(msg->videoPriority[i]) );
			
			outputFileForVideoPriority << msg->videoPriority[i];
			if(i + 1 == totalMediaNo)
			{
				std::cout << std::endl;
				outputFileForVideoPriority.close();
				break;
			}
			outputFileForVideoPriority << ", ";
		}

		outputFileForVideoPriority.close();
		isPriorityCallbackCalled_ = true;
	}
}


std::vector<Helper::RequestStatus> converterToRequestStatus(std::vector<int> intVector)
{
	int size = intVector.size(); 
	std::vector<Helper::RequestStatus> priorityVector;

	for (int i = 0; i < size; ++i)
	{
		priorityVector.push_back( static_cast<Helper::RequestStatus>(intVector[i]) );
	}
	
	return priorityVector;
}


void videoLengthCallback(const media_controller::VideoLength::ConstPtr& msg)
{
	if (!isLengthCallbackCalled_)
	{
		std::ofstream outputFileForVideoLength;
		outputFileForVideoLength.open("lengthInfo.csv");
	
		std::vector<int> videoLengthVector;
		totalMediaNo_ = msg->videoLength.size(); 

		std::vector<int> videoPriority;

		ROS_INFO_STREAM("Video length updated! -> " << totalMediaNo_);

		for (int i = 0; i < totalMediaNo_; ++i)
		{
			videoLengthVector.push_back( msg->videoLength[i] );
			
			outputFileForVideoLength << msg->videoLength[i];
			if(i+1 == totalMediaNo_)
			{
				std::cout << std::endl;
				outputFileForVideoLength.close();
				break;
			}
			outputFileForVideoLength << ", ";
		}

		videoLengthVector_ = videoLengthVector;

		outputFileForVideoLength.close();
		isLengthCallbackCalled_ = true;
	}
}


void congestionLevelCallback(const media_controller::CongestionLevel::ConstPtr& msg)
{
		congestionLevelTimePtr_->time = ros::Time::now().toSec();
		congestionLevelTimePtr_->duration = msg->duration;
		congestionLevelTimePtr_->congestionLevel = msg->congestionLevel;
		//congestionLevelPublisher_.publish(congestionLevelTimePtr_);	
}


void consoleOut(const ros::TimerEvent& e)
{
	if(isConsoleOut_)
	{
		printf("\033[J");
		printf("\033[1;1H");

		std::cout << " [Video Info] " << std::endl;
		
		std::cout << "Length   : ";
		std::cout << "[";

		for (int i = 0; i < videoLengthVector_.size(); ++i)
		{
			std::cout << videoLengthVector_[i];

			if(i+1 == videoLengthVector_.size())
			{
				std::cout << "]" << std::endl;
				
				break;
			}

			std::cout << ", ";
		}

		std::cout << "Priority : ";
		std::cout << "[";

		for (int i = 0; i < videoLengthVector_.size(); ++i)
		{
			std::cout << priorityVector_[i];

			if(i+1 == videoLengthVector_.size())
			{
				std::cout << "]" << std::endl;

				break;
			}
			std::cout << ", ";
		}

		std::cout << "Current Priority : " << requestedStatus_ << " || Input Priority : " << requestingStatus_ << std::endl;


	}
}


void videoInfoChangedCallback(const std_msgs::Empty::ConstPtr& msg)
{
	//requestVideoInfo();
}


void requestVideoInfo()
{
	// media_controller::video_info srv;
	// srv.request.rq = true;

	// ros::service::waitForService("/video_info_service", ros::Duration(5));

	// if( videoInfoClient_.call(srv) )
	// {
	// 	std::ofstream outputFileForVideoPriority;
	// 	std::ofstream outputFileForVideoLength;
	// 	outputFileForVideoPriority.open("priorityInfo.csv");
	// 	outputFileForVideoLength.open("lengthInfo.csv");

	// 	int sizeOfPriority = srv.response.videoPriority.size();
	// 	int sizeOfLength = srv.response.videoLength.size();

	// 	if(sizeOfPriority != sizeOfLength)
	// 	{
	// 		ROS_ERROR("Two array sizes are different!!");
	// 	}

	// 	priorityVector_.clear();
	// 	videoLengthVector_.clear();

	// 	totalMediaNo_ = sizeOfLength;

	// 	for (int i = 0; i < sizeOfLength; ++i)
	// 	{
	// 		priorityVector_.push_back( static_cast<Helper::RequestStatus>(srv.response.videoPriority[i]) );
	// 		videoLengthVector_.push_back( srv.response.videoLength[i] );

	// 		outputFileForVideoPriority << srv.response.videoPriority[i];
	// 		outputFileForVideoLength << srv.response.videoLength[i];
	// 		if(i + 1 == sizeOfLength)
	// 		{
	// 			outputFileForVideoPriority.close();
	// 			break;
	// 		}
	// 		outputFileForVideoPriority << ", ";
	// 		outputFileForVideoLength << ", ";
	// 	}

	// 	outputFileForVideoPriority.close();
	// 	outputFileForVideoLength.close();

	// 	ROS_INFO_STREAM("Video info have updated! -> " << sizeOfLength);
	// }
	// else
	// {
	// 	priorityVector_ = converterToRequestStatus( getVideoInfo("/home/nvidia/.ros/priorityInfo.csv") );
	// 	videoLengthVector_ = ( getVideoInfo("/home/nvidia/.ros/lengthInfo.csv") );

	// 	ROS_INFO("Fail to call service request_video_length");
	// 	ROS_INFO("Read video info from local data");
	// }
}


int main (int argc, char** argv)
{
    ros::init(argc, argv, "media_controller_node");
    ros::NodeHandle nh;
    ros::Rate loop_rate(10);

    //int threadLoopRate = 1;
    //boost::thread timer(adTimer, &threadLoopRate);

	//ros::Subscriber videoLengthSubscriber = nh.subscribe("/videoLength", 1, videoLengthCallback);
	//ros::Subscriber videoPrioritySubscriber = nh.subscribe("/videoPriority", 1, videoPriorityCallback);
    ros::Subscriber displayRequestSubscriber = nh.subscribe("/request_display", 1, displayCallback);
    ros::Subscriber chargingSubscriber = nh.subscribe("/start_auto_parking", 1, charingCallback);
	ros::Subscriber doneChargingSubscriber = nh.subscribe("/path_run_request", 1, doneCharingCallback);
	ros::Subscriber consoleSubscriber = nh.subscribe("/console", 1, consoleCallback);
	ros::Subscriber congestionLevelSubscriber = nh.subscribe("/object_detector/nop", 1, congestionLevelCallback);
	ros::Subscriber changeVideoInfoSubscriber = nh.subscribe("/change_video_info", 1, videoInfoChangedCallback);

    //ros::Publisher recievedDataPublisher = nh.advertise<std_msgs::Float32>("/batteryRemaining", 1000);
    //requestBatteryPublisher_ = nh.advertise<std_msgs::Int32>("/requestBattery", 1000);
    requestDisplayPublisher_ = nh.advertise<std_msgs::Int32>("/request_display", 1000);
	//congestionLevelPublisher_ = nh.advertise<media_controller::CongestionLevel>("/object_detector/congestionLevel", 1);
	
    //ros::Timer batteryTimer = nh.createTimer( ros::Duration(5.0), pubBatteryCheckCallback );
	//ros::Timer consoleOutTimer = nh.createTimer( ros::Duration(1.0), consoleOut);

	videoInfoClient_ = nh.serviceClient<media_controller::video_info>("/request_video_info");

    displaySerialInitialize();
    	
	//requestVideoInfo();

	system("rostopic pub -1 /request_display std_msgs/Int32 4");

    while(ros::ok())
    {
        ros::spinOnce();
        
        if( displaySerial_.available() )
        {
            std_msgs::String recievedData;
            recievedData.data = displaySerial_.read(displaySerial_.available());

			std::vector<char> temp(recievedData.data.begin(), recievedData.data.end());
            temp.push_back('\0');
            char* buffer = &temp[0];
            displayMessageParser(buffer);
        }
        
        loop_rate.sleep();
    }
}