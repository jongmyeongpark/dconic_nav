; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude HeadCmd.msg.html

(cl:defclass <HeadCmd> (roslisp-msg-protocol:ros-message)
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
    :initform 0.0)
   (base_tilt_speed_rate
    :reader base_tilt_speed_rate
    :initarg :base_tilt_speed_rate
    :type cl:float
    :initform 0.0)
   (tilt_speed_rate
    :reader tilt_speed_rate
    :initarg :tilt_speed_rate
    :type cl:float
    :initform 0.0)
   (pan_speed_rate
    :reader pan_speed_rate
    :initarg :pan_speed_rate
    :type cl:float
    :initform 0.0))
)

(cl:defclass HeadCmd (<HeadCmd>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HeadCmd>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HeadCmd)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<HeadCmd> is deprecated: use custom_msgs-msg:HeadCmd instead.")))

(cl:ensure-generic-function 'base_tilt-val :lambda-list '(m))
(cl:defmethod base_tilt-val ((m <HeadCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:base_tilt-val is deprecated.  Use custom_msgs-msg:base_tilt instead.")
  (base_tilt m))

(cl:ensure-generic-function 'tilt-val :lambda-list '(m))
(cl:defmethod tilt-val ((m <HeadCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:tilt-val is deprecated.  Use custom_msgs-msg:tilt instead.")
  (tilt m))

(cl:ensure-generic-function 'pan-val :lambda-list '(m))
(cl:defmethod pan-val ((m <HeadCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:pan-val is deprecated.  Use custom_msgs-msg:pan instead.")
  (pan m))

(cl:ensure-generic-function 'base_tilt_speed_rate-val :lambda-list '(m))
(cl:defmethod base_tilt_speed_rate-val ((m <HeadCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:base_tilt_speed_rate-val is deprecated.  Use custom_msgs-msg:base_tilt_speed_rate instead.")
  (base_tilt_speed_rate m))

(cl:ensure-generic-function 'tilt_speed_rate-val :lambda-list '(m))
(cl:defmethod tilt_speed_rate-val ((m <HeadCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:tilt_speed_rate-val is deprecated.  Use custom_msgs-msg:tilt_speed_rate instead.")
  (tilt_speed_rate m))

(cl:ensure-generic-function 'pan_speed_rate-val :lambda-list '(m))
(cl:defmethod pan_speed_rate-val ((m <HeadCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:pan_speed_rate-val is deprecated.  Use custom_msgs-msg:pan_speed_rate instead.")
  (pan_speed_rate m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HeadCmd>) ostream)
  "Serializes a message object of type '<HeadCmd>"
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
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'base_tilt_speed_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'tilt_speed_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pan_speed_rate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HeadCmd>) istream)
  "Deserializes a message object of type '<HeadCmd>"
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
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'base_tilt_speed_rate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'tilt_speed_rate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pan_speed_rate) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HeadCmd>)))
  "Returns string type for a message object of type '<HeadCmd>"
  "custom_msgs/HeadCmd")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HeadCmd)))
  "Returns string type for a message object of type 'HeadCmd"
  "custom_msgs/HeadCmd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HeadCmd>)))
  "Returns md5sum for a message object of type '<HeadCmd>"
  "367b243a2924fb2bb03e2f8e186db888")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HeadCmd)))
  "Returns md5sum for a message object of type 'HeadCmd"
  "367b243a2924fb2bb03e2f8e186db888")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HeadCmd>)))
  "Returns full string definition for message of type '<HeadCmd>"
  (cl:format cl:nil "float32 base_tilt~%float32 tilt~%float32 pan~%~%float32 base_tilt_speed_rate~%float32 tilt_speed_rate~%float32 pan_speed_rate~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HeadCmd)))
  "Returns full string definition for message of type 'HeadCmd"
  (cl:format cl:nil "float32 base_tilt~%float32 tilt~%float32 pan~%~%float32 base_tilt_speed_rate~%float32 tilt_speed_rate~%float32 pan_speed_rate~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HeadCmd>))
  (cl:+ 0
     4
     4
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HeadCmd>))
  "Converts a ROS message object to a list"
  (cl:list 'HeadCmd
    (cl:cons ':base_tilt (base_tilt msg))
    (cl:cons ':tilt (tilt msg))
    (cl:cons ':pan (pan msg))
    (cl:cons ':base_tilt_speed_rate (base_tilt_speed_rate msg))
    (cl:cons ':tilt_speed_rate (tilt_speed_rate msg))
    (cl:cons ':pan_speed_rate (pan_speed_rate msg))
))
