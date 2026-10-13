;; Auto-generated. Do not edit!


(when (boundp 'landmark::VisionPose)
  (if (not (find-package "LANDMARK"))
    (make-package "LANDMARK"))
  (shadow 'VisionPose (find-package "LANDMARK")))
(unless (find-package "LANDMARK::VISIONPOSE")
  (make-package "LANDMARK::VISIONPOSE"))

(in-package "ROS")
;;//! \htmlinclude VisionPose.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass landmark::VisionPose
  :super ros::object
  :slots (_score _vision_pose ))

(defmethod landmark::VisionPose
  (:init
   (&key
    ((:score __score) 0.0)
    ((:vision_pose __vision_pose) (instance geometry_msgs::PoseWithCovarianceStamped :init))
    )
   (send-super :init)
   (setq _score (float __score))
   (setq _vision_pose __vision_pose)
   self)
  (:score
   (&optional __score)
   (if __score (setq _score __score)) _score)
  (:vision_pose
   (&rest __vision_pose)
   (if (keywordp (car __vision_pose))
       (send* _vision_pose __vision_pose)
     (progn
       (if __vision_pose (setq _vision_pose (car __vision_pose)))
       _vision_pose)))
  (:serialization-length
   ()
   (+
    ;; float32 _score
    4
    ;; geometry_msgs/PoseWithCovarianceStamped _vision_pose
    (send _vision_pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _score
       (sys::poke _score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; geometry_msgs/PoseWithCovarianceStamped _vision_pose
       (send _vision_pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _score
     (setq _score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; geometry_msgs/PoseWithCovarianceStamped _vision_pose
     (send _vision_pose :deserialize buf ptr-) (incf ptr- (send _vision_pose :serialization-length))
   ;;
   self)
  )

(setf (get landmark::VisionPose :md5sum-) "333e842c272a409f4813f7e13516f5a3")
(setf (get landmark::VisionPose :datatype-) "landmark/VisionPose")
(setf (get landmark::VisionPose :definition-)
      "float32 score
geometry_msgs/PoseWithCovarianceStamped vision_pose
================================================================================
MSG: geometry_msgs/PoseWithCovarianceStamped
# This expresses an estimated pose with a reference coordinate frame and timestamp

Header header
PoseWithCovariance pose

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: geometry_msgs/PoseWithCovariance
# This represents a pose in free space with uncertainty.

Pose pose

# Row-major representation of the 6x6 covariance matrix
# The orientation parameters use a fixed-axis representation.
# In order, the parameters are:
# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)
float64[36] covariance

================================================================================
MSG: geometry_msgs/Pose
# A representation of pose in free space, composed of position and orientation. 
Point position
Quaternion orientation

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :landmark/VisionPose "333e842c272a409f4813f7e13516f5a3")


