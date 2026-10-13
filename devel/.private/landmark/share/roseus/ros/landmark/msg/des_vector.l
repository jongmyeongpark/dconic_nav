;; Auto-generated. Do not edit!


(when (boundp 'landmark::des_vector)
  (if (not (find-package "LANDMARK"))
    (make-package "LANDMARK"))
  (shadow 'des_vector (find-package "LANDMARK")))
(unless (find-package "LANDMARK::DES_VECTOR")
  (make-package "LANDMARK::DES_VECTOR"))

(in-package "ROS")
;;//! \htmlinclude des_vector.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass landmark::des_vector
  :super ros::object
  :slots (_count _kp _des _pose ))

(defmethod landmark::des_vector
  (:init
   (&key
    ((:count __count) 0)
    ((:kp __kp) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:des __des) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:pose __pose) (instance geometry_msgs::PoseWithCovarianceStamped :init))
    )
   (send-super :init)
   (setq _count (round __count))
   (setq _kp __kp)
   (setq _des __des)
   (setq _pose __pose)
   self)
  (:count
   (&optional __count)
   (if __count (setq _count __count)) _count)
  (:kp
   (&optional __kp)
   (if __kp (setq _kp __kp)) _kp)
  (:des
   (&optional __des)
   (if __des (setq _des __des)) _des)
  (:pose
   (&rest __pose)
   (if (keywordp (car __pose))
       (send* _pose __pose)
     (progn
       (if __pose (setq _pose (car __pose)))
       _pose)))
  (:serialization-length
   ()
   (+
    ;; int32 _count
    4
    ;; float32[] _kp
    (* 4    (length _kp)) 4
    ;; float32[] _des
    (* 4    (length _des)) 4
    ;; geometry_msgs/PoseWithCovarianceStamped _pose
    (send _pose :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _count
       (write-long _count s)
     ;; float32[] _kp
     (write-long (length _kp) s)
     (dotimes (i (length _kp))
       (sys::poke (elt _kp i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _des
     (write-long (length _des) s)
     (dotimes (i (length _des))
       (sys::poke (elt _des i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; geometry_msgs/PoseWithCovarianceStamped _pose
       (send _pose :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _count
     (setq _count (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32[] _kp
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _kp (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _kp i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _des
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _des (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _des i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; geometry_msgs/PoseWithCovarianceStamped _pose
     (send _pose :deserialize buf ptr-) (incf ptr- (send _pose :serialization-length))
   ;;
   self)
  )

(setf (get landmark::des_vector :md5sum-) "dd9174158b91781720e0e95f90094507")
(setf (get landmark::des_vector :datatype-) "landmark/des_vector")
(setf (get landmark::des_vector :definition-)
      "int32 count
float32[] kp
float32[] des
geometry_msgs/PoseWithCovarianceStamped pose

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



(provide :landmark/des_vector "dd9174158b91781720e0e95f90094507")


