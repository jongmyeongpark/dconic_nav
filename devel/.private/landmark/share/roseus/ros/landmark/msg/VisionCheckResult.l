;; Auto-generated. Do not edit!


(when (boundp 'landmark::VisionCheckResult)
  (if (not (find-package "LANDMARK"))
    (make-package "LANDMARK"))
  (shadow 'VisionCheckResult (find-package "LANDMARK")))
(unless (find-package "LANDMARK::VISIONCHECKRESULT")
  (make-package "LANDMARK::VISIONCHECKRESULT"))

(in-package "ROS")
;;//! \htmlinclude VisionCheckResult.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass landmark::VisionCheckResult
  :super ros::object
  :slots (_move_status _ReLocalType _vision_pose _amcl_pose ))

(defmethod landmark::VisionCheckResult
  (:init
   (&key
    ((:move_status __move_status) nil)
    ((:ReLocalType __ReLocalType) 0)
    ((:vision_pose __vision_pose) (instance geometry_msgs::PoseWithCovarianceStamped :init))
    ((:amcl_pose __amcl_pose) (instance geometry_msgs::PoseWithCovarianceStamped :init))
    )
   (send-super :init)
   (setq _move_status __move_status)
   (setq _ReLocalType (round __ReLocalType))
   (setq _vision_pose __vision_pose)
   (setq _amcl_pose __amcl_pose)
   self)
  (:move_status
   (&optional (__move_status :null))
   (if (not (eq __move_status :null)) (setq _move_status __move_status)) _move_status)
  (:ReLocalType
   (&optional __ReLocalType)
   (if __ReLocalType (setq _ReLocalType __ReLocalType)) _ReLocalType)
  (:vision_pose
   (&rest __vision_pose)
   (if (keywordp (car __vision_pose))
       (send* _vision_pose __vision_pose)
     (progn
       (if __vision_pose (setq _vision_pose (car __vision_pose)))
       _vision_pose)))
  (:amcl_pose
   (&rest __amcl_pose)
   (if (keywordp (car __amcl_pose))
       (send* _amcl_pose __amcl_pose)
     (progn
       (if __amcl_pose (setq _amcl_pose (car __amcl_pose)))
       _amcl_pose)))
  (:serialization-length
   ()
   (+
    ;; bool _move_status
    1
    ;; int8 _ReLocalType
    1
    ;; geometry_msgs/PoseWithCovarianceStamped _vision_pose
    (send _vision_pose :serialization-length)
    ;; geometry_msgs/PoseWithCovarianceStamped _amcl_pose
    (send _amcl_pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _move_status
       (if _move_status (write-byte -1 s) (write-byte 0 s))
     ;; int8 _ReLocalType
       (write-byte _ReLocalType s)
     ;; geometry_msgs/PoseWithCovarianceStamped _vision_pose
       (send _vision_pose :serialize s)
     ;; geometry_msgs/PoseWithCovarianceStamped _amcl_pose
       (send _amcl_pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _move_status
     (setq _move_status (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int8 _ReLocalType
     (setq _ReLocalType (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _ReLocalType 127) (setq _ReLocalType (- _ReLocalType 256)))
   ;; geometry_msgs/PoseWithCovarianceStamped _vision_pose
     (send _vision_pose :deserialize buf ptr-) (incf ptr- (send _vision_pose :serialization-length))
   ;; geometry_msgs/PoseWithCovarianceStamped _amcl_pose
     (send _amcl_pose :deserialize buf ptr-) (incf ptr- (send _amcl_pose :serialization-length))
   ;;
   self)
  )

(setf (get landmark::VisionCheckResult :md5sum-) "e74925df1339381ec7aba8760cec83b1")
(setf (get landmark::VisionCheckResult :datatype-) "landmark/VisionCheckResult")
(setf (get landmark::VisionCheckResult :definition-)
      "bool move_status
int8 ReLocalType
geometry_msgs/PoseWithCovarianceStamped vision_pose
geometry_msgs/PoseWithCovarianceStamped amcl_pose
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



(provide :landmark/VisionCheckResult "e74925df1339381ec7aba8760cec83b1")


