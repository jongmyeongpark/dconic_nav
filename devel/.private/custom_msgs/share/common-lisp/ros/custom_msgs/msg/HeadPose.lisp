; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude HeadPose.msg.html

(cl:defclass <HeadPose> (roslisp-msg-protocol:ros-message)
  ((base_tilt
    :reader base_tilt
    :initarg :base_tilt
    :type cl:float
    :initform 0.0)
   (tilt
    :reader tilt
    :initarg :tilt
    :type cl:float
    :initform 0.0)
   (pan
    :reader pan
    :initarg :pan
    :type cl:float
    :initform 0.0))
)

(cl:defclass HeadPose (<HeadPose>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HeadPose>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HeadPose)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<HeadPose> is deprecated: use custom_msgs-msg:HeadPose instead.")))

(cl:ensure-generic-function 'base_tilt-val :lambda-list '(m))
(cl:defmethod base_tilt-val ((m <HeadPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:base_tilt-val is deprecated.  Use custom_msgs-msg:base_tilt instead.")
  (base_tilt m))

(cl:ensure-generic-function 'tilt-val :lambda-list '(m))
(cl:defmethod tilt-val ((m <HeadPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:tilt-val is deprecated.  Use custom_msgs-msg:tilt instead.")
  (tilt m))

(cl:ensure-generic-function 'pan-val :lambda-list '(m))
(cl:defmethod pan-val ((m <HeadPose>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:pan-val is deprecated.  Use custom_msgs-msg:pan instead.")
  (pan m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HeadPose>) ostream)
  "Serializes a message object of type '<HeadPose>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'base_tilt))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tilt))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pan))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HeadPose>) istream)
  "Deserializes a message object of type '<HeadPose>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'base_tilt) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tilt) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pan) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HeadPose>)))
  "Returns string type for a message object of type '<HeadPose>"
  "custom_msgs/HeadPose")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HeadPose)))
  "Returns string type for a message object of type 'HeadPose"
  "custom_msgs/HeadPose")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HeadPose>)))
  "Returns md5sum for a message object of type '<HeadPose>"
  "2bdaec443c73b83bbfd0a1d44c1de57f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HeadPose)))
  "Returns md5sum for a message object of type 'HeadPose"
  "2bdaec443c73b83bbfd0a1d44c1de57f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HeadPose>)))
  "Returns full string definition for message of type '<HeadPose>"
  (cl:format cl:nil "float32 base_tilt~%float32 tilt~%float32 pan~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HeadPose)))
  "Returns full string definition for message of type 'HeadPose"
  (cl:format cl:nil "float32 base_tilt~%float32 tilt~%float32 pan~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HeadPose>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HeadPose>))
  "Converts a ROS message object to a list"
  (cl:list 'HeadPose
    (cl:cons ':base_tilt (base_tilt msg))
    (cl:cons ':tilt (tilt msg))
    (cl:cons ':pan (pan msg))
))
