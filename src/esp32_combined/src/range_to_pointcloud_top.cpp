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
        subscribeToTopics();
        initializePublishers();
        set_counters();
    }

    void rangeCallback(const sensor_msgs::Range::ConstPtr& range_msg) {
        ROS_INFO("Received message from frame_id: %s", range_msg->header.frame_id.c_str());

        pcl::PointCloud<pcl::PointXYZ>::Ptr cloud(new pcl::PointCloud<pcl::PointXYZ>);

        if (cntrs.find(range_msg->header.frame_id) != cntrs.end()) {
            cntrs[range_msg->header.frame_id] += 1;
            cnt = cntrs[range_msg->header.frame_id];
        } else {
            ROS_WARN("No cnt found for frame_id: %s", range_msg->header.frame_id.c_str());
        }

        if (range_msg->range >= range_msg->min_range && range_msg->range < range_msg->max_range) {
            if (cnt > 3) {
                pcl::PointXYZ point;
                point.x = range_msg->range;
                point.y = 0.0;
                point.z = 0.0;
                cloud->points.push_back(point);
            }
        } else {
            cntrs[range_msg->header.frame_id] = 0;
        }

        cloud->width = cloud->points.size();
        cloud->height = 1;
        cloud->is_dense = true;

        sensor_msgs::PointCloud2 output;
        pcl::toROSMsg(*cloud, output);
        output.header.frame_id = range_msg->header.frame_id;
        output.header.stamp = ros::Time::now();

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
        std::vector<std::string> topics = {
            "/sonardata1_topic", "/sonardata2_topic", "/sonardata3_topic", "/sonardata4_topic",
            "/sonardata5_topic", "/sonardata6_topic", "/sonardata7_topic", "/sonardata8_topic"
        };

        for (const auto& topic : topics) {
            subscribers_.push_back(nh_.subscribe<sensor_msgs::Range>(topic, 10, &RangeToPointCloudConverter::rangeCallback, this));
        }
    }

    void initializePublishers() {
        for (int i = 1; i <= 8; ++i) {
            std::string frame_id = "sonar" + std::to_string(i) + "_frame"; // ← 수정
            std::string pub_topic = "/ultrasonic" + std::to_string(i);
            publishers_[frame_id] = nh_.advertise<sensor_msgs::PointCloud2>(pub_topic, 10);
        }
    }

    void set_counters() {
        for (int i = 1; i <= 8; ++i) {
            std::string frame_id = "sonar" + std::to_string(i) + "_frame"; // ← 수정
            cntrs[frame_id] = 0;
        }
    }

};

int main(int argc, char** argv) {
    ros::init(argc, argv, "range_to_pointcloud_top");
    RangeToPointCloudConverter converter;
    ros::spin();
    return 0;
}
