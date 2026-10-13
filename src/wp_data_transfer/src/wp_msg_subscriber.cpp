#include "ros/ros.h" 
#include "wp_data_transfer/wpdata.h" 
#include "std_msgs/String.h"
#include <sstream>
#include <string>
void msgCallback(const wp_data_transfer::wpdata::ConstPtr& msg) 
{ 
	ROS_INFO("send msg.filename = %s", msg->filename.c_str());
	ROS_INFO("send msg.wp_quan = %d", msg->wp_quan);
	for(int i=0; i<msg->wp_quan ;i++){
		ROS_INFO("send msg.x[%d]=%.2f | send msg.y[%d]=%.2f | send msg.z[%d]=%.2f | send msg.qx[%d]=%.2f | send msg.qy[%d]=%.2f | send msg.qz[%d]=%.2f | send msg.qw[%d]=%.2f",i ,i ,i ,i ,i ,i ,i ,msg->x[i] ,msg->y[i] ,msg->z[i] ,msg->qx[i] ,msg->qy[i] ,msg->qz[i] ,msg->qw[i]);   
	}
        
        // 21.01.27 sykim change - release version
	std::string file_path_name = "/home/nvidia/dconic_nav/src/follow_waypoints/saved_path/" + msg->filename + ".csv";
	//std::string file_path_name = "/home/nvidia/dconic_nav/src/share/follow_waypoints/saved_path/" + msg->filename + ".csv";

	FILE *fp = fopen(file_path_name.c_str(), "w+");
	for(int i=0; i<msg->wp_quan ;i++){
		fprintf(fp,"%.4f,%.4f,%.4f,%.4f,%.4f,%.4f,%.4f\n",msg->x[i],msg->y[i],msg->z[i],msg->qx[i],msg->qy[i],msg->qz[i],msg->qw[i]);
	}
	fclose(fp);
}
int main(int argc, char **argv) 
{
	ros::init(argc, argv, "wp_msg_subscriber"); 
	ros::NodeHandle nh; 

	ros::Subscriber wp_data_sub = nh.subscribe("wp_msg", 10, msgCallback); 
	ros::Rate loop_rate(0.5);
	while (ros::ok())	
	{
		loop_rate.sleep();
		ros::spinOnce();
	}
	return 0; 
} 
