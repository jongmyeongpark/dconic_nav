#include <ros/ros.h>
#include <sensor_msgs/Range.h>
#include <sensor_msgs/PointCloud2.h>
#include <pcl/point_types.h>
#include <pcl/point_cloud.h>
#include <pcl_conversions/pcl_conversions.h>
#include <unordered_map>
#include <cmath>

int cnt;

class RangeToPointCloudConverter {
public:
    RangeToPointCloudConverter() {
        // Initialize subscribers
        subscribeToTopics();

        // Initialize publishers
        initializePublishers();

        set_counters();
    }

    void rangeCallback(const sensor_msgs::Range::ConstPtr& range_msg) {
        ROS_INFO("Received message from frame_id: %s", range_msg->header.frame_id.c_str());
        // Create a new point cloudcloud
        pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>);

        // cnt check
        if (cntrs.find(range_msg->header.frame_id) != cntrs.end()) {
            cntrs[range_msg->header.frame_id] += 1;
            cnt = cntrs[range_msg->header.frame_id];
            // ROS_WARN("cnt for frame_id %s: %d", range_msg->header.frame_id.c_str(), cnt);
        } else {
            ROS_WARN("No cnt found for frame_id: %s", range_msg->header.frame_id.c_str());
        }

        // Check if the range is within valid limits
        if (range_msg->range >= range_msg->min_range && range_msg->range < range_msg->max_range) {
            if (cnt > 3) {
                // Calculate angle increment based on field of view (assuming single point for simplicity)
                float angle_increment = range_msg->field_of_view;
                float angle = 0.0; // Assuming direct forward measurement

                // Convert range to Cartesian coordinates
                pcl::PointXYZ point;
                point.x = range_msg->range;
                point.y = 0.0;
                point.z = 0.0; // Assuming flat surface

                cloud->points.push_back(point);
            } 
        }
        else {
            //reset cnt if avoidance not detected
            cntrs[range_msg->header.frame_id] = 0;
        }
        

        cloud->width = cloud->points.size();
        cloud->height = 1;
        cloud->is_dense = true;

        // Convert to ROS PointCloud2 message
        sensor_msgs::PointCloud2 output;
        pcl::toROSMsg(*cloud, output);
        output.header.frame_id = range_msg->header.frame_id;
        output.header.stamp = ros::Time::now();

        // Publish the point cloud using the appropriate publisher
        if (publishers_.find(range_msg->header.frame_id) != publishers_.end()) {
            publishers_[range_msg->header.frame_id].publish(output);
        } else {
            ROS_WARN("No publisher found for frame_id: %s", range_msg->header.frame_id.c_str());
        }
    }

private:
    ros::NodeHandle nh_;
    std::vector<ros::Subscriber> subscribers_;
    std::unordered_map<std::string, ros::Publisher> publishers_;
    std::unordered_map<std::string, int> cntrs;

    void subscribeToTopics() {
        subscribers_.push_back(nh_.subscribe<sensor_msgs::Range>("/sonar_bottom_fl", 10, &RangeToPointCloudConverter::rangeCallback, this));
        subscribers_.push_back(nh_.subscribe<sensor_msgs::Range>("/sonar_bottom_fr", 10, &RangeToPointCloudConverter::rangeCallback, this));
        subscribers_.push_back(nh_.subscribe<sensor_msgs::Range>("/sonar_bottom_left", 10, &RangeToPointCloudConverter::rangeCallback, this));
        subscribers_.push_back(nh_.subscribe<sensor_msgs::Range>("/sonar_bottom_right", 10, &RangeToPointCloudConverter::rangeCallback, this));
        subscribers_.push_back(nh_.subscribe<sensor_msgs::Range>("/sonar_bottom_rl", 10, &RangeToPointCloudConverter::rangeCallback, this));
        subscribers_.push_back(nh_.subscribe<sensor_msgs::Range>("/sonar_bottom_rr", 10, &RangeToPointCloudConverter::rangeCallback, this));
    }

    void initializePublishers() {
        publishers_["sonar_bottom_fl"] = nh_.advertise<sensor_msgs::PointCloud2>("/ultrasonic1", 10);
        publishers_["sonar_bottom_fr"] = nh_.advertise<sensor_msgs::PointCloud2>("/ultrasonic2", 10);
        publishers_["sonar_bottom_left"] = nh_.advertise<sensor_msgs::PointCloud2>("/ultrasonic3", 10);
        publishers_["sonar_bottom_right"] = nh_.advertise<sensor_msgs::PointCloud2>("/ultrasonic4", 10);
        publishers_["sonar_bottom_rl"] = nh_.advertise<sensor_msgs::PointCloud2>("/ultrasonic5", 10);
        publishers_["sonar_bottom_rr"] = nh_.advertise<sensor_msgs::PointCloud2>("/ultrasonic6", 10);
    }

    void set_counters(){
        cntrs["sonar_bottom_fl"] = 0;
        cntrs["sonar_bottom_fr"] = 0;
        cntrs["sonar_bottom_left"] = 0;
        cntrs["sonar_bottom_right"] = 0;
        cntrs["sonar_bottom_rl"] = 0;
        cntrs["sonar_bottom_rr"] = 0;
    }
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "range_to_pointcloud_bottom");
    RangeToPointCloudConverter converter;
    ros::spin(); // Ensure that the ROS event loop is running
    return 0;
}