; Auto-generated. Do not edit!


(cl:in-package landmark-msg)


;//! \htmlinclude VisionCheckResult.msg.html

(cl:defclass <VisionCheckResult> (roslisp-msg-protocol:ros-message)
  ((move_status
    :reader move_status
    :initarg :move_status
    :type cl:boolean
    :initform cl:nil)
   (ReLocalType
    :reader ReLocalType
    :initarg :ReLocalType
    :type cl:fixnum
    :initform 0)
   (vision_pose
    :reader vision_pose
    :initarg :vision_pose
    :type geometry_msgs-msg:PoseWithCovarianceStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PoseWithCovarianceStamped))
   (amcl_pose
    :reader amcl_pose
    :initarg :amcl_pose
    :type geometry_msgs-msg:PoseWithCovarianceStamped
    :initform (cl:make-instance 'geometry_msgs-msg:PoseWithCovarianceStamped)))
)

(cl:defclass VisionCheckResult (<VisionCheckResult>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VisionCheckResult>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VisionCheckResult)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name landmark-msg:<VisionCheckResult> is deprecated: use landmark-msg:VisionCheckResult instead.")))

(cl:ensure-generic-function 'move_status-val :lambda-list '(m))
(cl:defmethod move_status-val ((m <VisionCheckResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:move_status-val is deprecated.  Use landmark-msg:move_status instead.")
  (move_status m))

(cl:ensure-generic-function 'ReLocalType-val :lambda-list '(m))
(cl:defmethod ReLocalType-val ((m <VisionCheckResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:ReLocalType-val is deprecated.  Use landmark-msg:ReLocalType instead.")
  (ReLocalType m))

(cl:ensure-generic-function 'vision_pose-val :lambda-list '(m))
(cl:defmethod vision_pose-val ((m <VisionCheckResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:vision_pose-val is deprecated.  Use landmark-msg:vision_pose instead.")
  (vision_pose m))

(cl:ensure-generic-function 'amcl_pose-val :lambda-list '(m))
(cl:defmethod amcl_pose-val ((m <VisionCheckResult>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:amcl_pose-val is deprecated.  Use landmark-msg:amcl_pose instead.")
  (amcl_pose m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VisionCheckResult>) ostream)
  "Serializes a message object of type '<VisionCheckResult>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'move_status) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'ReLocalType)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'vision_pose) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'amcl_pose) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VisionCheckResult>) istream)
  "Deserializes a message object of type '<VisionCheckResult>"
    (cl:setf (cl:slot-value msg 'move_status) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ReLocalType) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'vision_pose) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'amcl_pose) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VisionCheckResult>)))
  "Returns string type for a message object of type '<VisionCheckResult>"
  "landmark/VisionCheckResult")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VisionCheckResult)))
  "Returns string type for a message object of type 'VisionCheckResult"
  "landmark/VisionCheckResult")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VisionCheckResult>)))
  "Returns md5sum for a message object of type '<VisionCheckResult>"
  "e74925df1339381ec7aba8760cec83b1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VisionCheckResult)))
  "Returns md5sum for a message object of type 'VisionCheckResult"
  "e74925df1339381ec7aba8760cec83b1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VisionCheckResult>)))
  "Returns full string definition for message of type '<VisionCheckResult>"
  (cl:format cl:nil "bool move_status~%int8 ReLocalType~%geometry_msgs/PoseWithCovarianceStamped vision_pose~%geometry_msgs/PoseWithCovarianceStamped amcl_pose~%================================================================================~%MSG: geometry_msgs/PoseWithCovarianceStamped~%# This expresses an estimated pose with a reference coordinate frame and timestamp~%~%Header header~%PoseWithCovariance pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VisionCheckResult)))
  "Returns full string definition for message of type 'VisionCheckResult"
  (cl:format cl:nil "bool move_status~%int8 ReLocalType~%geometry_msgs/PoseWithCovarianceStamped vision_pose~%geometry_msgs/PoseWithCovarianceStamped amcl_pose~%================================================================================~%MSG: geometry_msgs/PoseWithCovarianceStamped~%# This expresses an estimated pose with a reference coordinate frame and timestamp~%~%Header header~%PoseWithCovariance pose~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/PoseWithCovariance~%# This represents a pose in free space with uncertainty.~%~%Pose pose~%~%# Row-major representation of the 6x6 covariance matrix~%# The orientation parameters use a fixed-axis representation.~%# In order, the parameters are:~%# (x, y, z, rotation about X axis, rotation about Y axis, rotation about Z axis)~%float64[36] covariance~%~%================================================================================~%MSG: geometry_msgs/Pose~%# A representation of pose in free space, composed of position and orientation. ~%Point position~%Quaternion orientation~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Quaternion~%# This represents an orientation in free space in quaternion form.~%~%float64 x~%float64 y~%float64 z~%float64 w~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VisionCheckResult>))
  (cl:+ 0
     1
     1
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'vision_pose))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'amcl_pose))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VisionCheckResult>))
  "Converts a ROS message object to a list"
  (cl:list 'VisionCheckResult
    (cl:cons ':move_status (move_status msg))
    (cl:cons ':ReLocalType (ReLocalType msg))
    (cl:cons ':vision_pose (vision_pose msg))
    (cl:cons ':amcl_pose (amcl_pose msg))
))
