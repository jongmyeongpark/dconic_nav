#include <cmath>
#include <vector>

#include <ros/ros.h>
#include <sensor_msgs/PointCloud2.h>
#include <sensor_msgs/point_cloud2_iterator.h>
#include <dynamic_reconfigure/server.h>
#include <pointcloud_height_filter/HeightFilterConfig.h>

/*
 * Frustum-based height filter with dynamic_reconfigure.
 *
 * World-frame height formula (camera optical frame: Y=down, Z=forward):
 *   y_world = (cam_height) - (y_cam * cos(pitch) + z_cam * sin(pitch))
 *
 * pitch > 0 → camera tilts downward.
 * Tune cam_height / pitch / min / max via rqt_reconfigure without restarting.
 *
 * Subscribes : ~input  (sensor_msgs/PointCloud2, camera optical frame)
 * Publishes  : ~output (sensor_msgs/PointCloud2, same frame, filtered)
 */
class HeightFilterNode
{
public:
    HeightFilterNode()
        : pnh_("~")
        , cam_h_(1.177)
        , pitch_(0.0)
        , min_h_(0.10)
        , max_h_(1.80)
        , enabled_(true)
    {
        pnh_.param("camera_height",       cam_h_,  1.177);
        pnh_.param("camera_pitch",        pitch_,  0.0);
        pnh_.param("min_obstacle_height", min_h_,  0.10);
        pnh_.param("max_obstacle_height", max_h_,  1.80);
        pnh_.param("enabled",             enabled_, true);

        dyn_srv_.setCallback(
            boost::bind(&HeightFilterNode::dynCb, this, _1, _2));

        std::string in_topic  = pnh_.param<std::string>("input_topic",  "input");
        std::string out_topic = pnh_.param<std::string>("output_topic", "output");

        ros::NodeHandle nh;
        sub_ = nh.subscribe(in_topic,  1, &HeightFilterNode::cloudCb, this);
        pub_ = nh.advertise<sensor_msgs::PointCloud2>(out_topic, 1);

        ROS_INFO("[height_filter] cam_h=%.3f  pitch=%.4f rad  min=%.2f  max=%.2f  enabled=%d",
                 cam_h_, pitch_, min_h_, max_h_, (int)enabled_);
        ROS_INFO("[height_filter] in=%s  out=%s", in_topic.c_str(), out_topic.c_str());
        ROS_INFO("[height_filter] open rqt_reconfigure to tune parameters live");
    }

private:
    ros::NodeHandle pnh_;
    ros::Subscriber sub_;
    ros::Publisher  pub_;
    dynamic_reconfigure::Server<pointcloud_height_filter::HeightFilterConfig> dyn_srv_;

    double cam_h_, pitch_, min_h_, max_h_;
    bool   enabled_;

    void dynCb(pointcloud_height_filter::HeightFilterConfig& cfg, uint32_t)
    {
        cam_h_   = cfg.camera_height;
        pitch_   = cfg.camera_pitch;
        min_h_   = cfg.min_obstacle_height;
        max_h_   = cfg.max_obstacle_height;
        enabled_ = cfg.enabled;
        ROS_INFO("[height_filter] updated: cam_h=%.3f  pitch=%.4f rad  min=%.2f  max=%.2f  enabled=%d",
                 cam_h_, pitch_, min_h_, max_h_, (int)enabled_);
    }

    void cloudCb(const sensor_msgs::PointCloud2ConstPtr& in)
    {
        if (!enabled_) {
            pub_.publish(in);
            return;
        }

        const double cos_p = std::cos(pitch_);
        const double sin_p = std::sin(pitch_);

        std::vector<float> xs, ys, zs;
        xs.reserve(in->width);
        ys.reserve(in->width);
        zs.reserve(in->width);

        sensor_msgs::PointCloud2ConstIterator<float> ix(*in, "x");
        sensor_msgs::PointCloud2ConstIterator<float> iy(*in, "y");
        sensor_msgs::PointCloud2ConstIterator<float> iz(*in, "z");

        for (; ix != ix.end(); ++ix, ++iy, ++iz)
        {
            const float yc = *iy;
            const float zc = *iz;
            // y_world = cam_height - (y_cam*cos(pitch) + z_cam*sin(pitch))
            const double y_world = cam_h_ - (static_cast<double>(yc) * cos_p
                                           + static_cast<double>(zc) * sin_p);
            if (y_world >= min_h_ && y_world <= max_h_) {
                xs.push_back(*ix);
                ys.push_back(yc);
                zs.push_back(zc);
            }
        }

        if (xs.empty()) {
            ROS_DEBUG_THROTTLE(3.0, "[height_filter] all points filtered out");
            return;
        }

        sensor_msgs::PointCloud2 out;
        out.header       = in->header;
        out.height       = 1;
        out.width        = static_cast<uint32_t>(xs.size());
        out.is_bigendian = false;
        out.is_dense     = true;
        out.point_step   = 12;
        out.row_step     = 12u * out.width;

        sensor_msgs::PointCloud2Modifier mod(out);
        mod.setPointCloud2Fields(3,
            "x", 1, sensor_msgs::PointField::FLOAT32,
            "y", 1, sensor_msgs::PointField::FLOAT32,
            "z", 1, sensor_msgs::PointField::FLOAT32);
        mod.resize(xs.size());

        sensor_msgs::PointCloud2Iterator<float> ox(out, "x");
        sensor_msgs::PointCloud2Iterator<float> oy(out, "y");
        sensor_msgs::PointCloud2Iterator<float> oz(out, "z");

        for (std::size_t i = 0; i < xs.size(); ++i, ++ox, ++oy, ++oz) {
            *ox = xs[i];
            *oy = ys[i];
            *oz = zs[i];
        }

        pub_.publish(out);
        ROS_DEBUG_THROTTLE(3.0, "[height_filter] in=%u  kept=%zu", in->width, xs.size());
    }
};

int main(int argc, char** argv)
{
    ros::init(argc, argv, "pointcloud_height_filter");
    HeightFilterNode node;
    ros::spin();
    return 0;
}
