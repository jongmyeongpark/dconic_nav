; Auto-generated. Do not edit!


(cl:in-package landmark-msg)


;//! \htmlinclude VisionPose.msg.html

(cl:defclass <VisionPose> (roslisp-msg-protocol:ros-message)
  ((score
    :reader score
    :initarg :score
    :type cl:float
    :initform 0.0)
   (vision_pose
    :reader vision_pose
    :initarg :vision_pose
    :type geometry_msgs-msg:PoseWithCovarianceStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PoseWithCovarianceStamped)))
)

(cl:defclass VisionPose (<VisionPose>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VisionPose>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VisionPose)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name landmark-msg:<VisionPose> is deprecated: use landmark-msg:VisionPose instead.")))

(cl:ensure-generic-function 'score-val :lambda-list '(m))
(cl:defmethod score-val ((m <VisionPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:score-val is deprecated.  Use landmark-msg:score instead.")
  (score m))

(cl:ensure-generic-function 'vision_pose-val :lambda-list '(m))
(cl:defmethod vision_pose-val ((m <VisionPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:vision_pose-val is deprecated.  Use landmark-msg:vision_pose instead.")
  (vision_pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VisionPose>) ostream)
  "Serializes a message object of type '<VisionPose>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'vision_pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VisionPose>) istream)
  "Deserializes a message object of type '<VisionPose>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'score) (roslisp-utils:decode-single-float-bits bits)))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'vision_pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VisionPose>)))
  "Returns string type for a message object of type '<VisionPose>"
  "landmark/VisionPose")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VisionPose)))
  "Returns string type for a message object of type 'VisionPose"
  "landmark/VisionPose")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VisionPose>)))
  "Returns md5sum for a message object of type '<VisionPose>"
  "333e842c272a409f4813f7e13516f5a3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VisionPose)))
  "Returns md5sum for a message object of type 'VisionPose"
  "333e842c272a409f4813f7e13516f5a3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VisionPose>)))
  "Returns full string definition for message of type '<VisionPose>"
  (cl:format cl:nil "float32 score~%geometry_msgs/PoseWithCovarianceStamped vision_pose~%================================================================================~%MSG: geometry_msgs/PoseWithCovarianceStamped~%# This expresses an estimated pose with a reference coordinate frame and timestamp~%~%Header header~%PoseWithCovariance pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VisionPose)))
  "Returns full string definition for message of type 'VisionPose"
  (cl:format cl:nil "float32 score~%geometry_msgs/PoseWithCovarianceStamped vision_pose~%================================================================================~%MSG: geometry_msgs/PoseWithCovarianceStamped~%# This expresses an estimated pose with a reference coordinate frame and timestamp~%~%Header header~%PoseWithCovariance pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VisionPose>))
  (cl:+ 0
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'vision_pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VisionPose>))
  "Converts a ROS message object to a list"
  (cl:list 'VisionPose
    (cl:cons ':score (score msg))
    (cl:cons ':vision_pose (vision_pose msg))
))
