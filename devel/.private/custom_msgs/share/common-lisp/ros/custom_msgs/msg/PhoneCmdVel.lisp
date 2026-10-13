; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude PhoneCmdVel.msg.html

(cl:defclass <PhoneCmdVel> (roslisp-msg-protocol:ros-message)
  ((linear
    :reader linear
    :initarg :linear
    :type cl:float
    :initform 0.0)
   (angular
    :reader angular
    :initarg :angular
    :type cl:float
    :initform 0.0)
   (deadman
    :reader deadman
    :initarg :deadman
    :type cl:boolean
    :initform cl:nil)
   (emergency_stop
    :reader emergency_stop
    :initarg :emergency_stop
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass PhoneCmdVel (<PhoneCmdVel>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <PhoneCmdVel>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'PhoneCmdVel)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<PhoneCmdVel> is deprecated: use custom_msgs-msg:PhoneCmdVel instead.")))

(cl:ensure-generic-function 'linear-val :lambda-list '(m))
(cl:defmethod linear-val ((m <PhoneCmdVel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:linear-val is deprecated.  Use custom_msgs-msg:linear instead.")
  (linear m))

(cl:ensure-generic-function 'angular-val :lambda-list '(m))
(cl:defmethod angular-val ((m <PhoneCmdVel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:angular-val is deprecated.  Use custom_msgs-msg:angular instead.")
  (angular m))

(cl:ensure-generic-function 'deadman-val :lambda-list '(m))
(cl:defmethod deadman-val ((m <PhoneCmdVel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:deadman-val is deprecated.  Use custom_msgs-msg:deadman instead.")
  (deadman m))

(cl:ensure-generic-function 'emergency_stop-val :lambda-list '(m))
(cl:defmethod emergency_stop-val ((m <PhoneCmdVel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:emergency_stop-val is deprecated.  Use custom_msgs-msg:emergency_stop instead.")
  (emergency_stop m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <PhoneCmdVel>) ostream)
  "Serializes a message object of type '<PhoneCmdVel>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'linear))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'angular))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'deadman) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'emergency_stop) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <PhoneCmdVel>) istream)
  "Deserializes a message object of type '<PhoneCmdVel>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'linear) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'angular) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'deadman) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'emergency_stop) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<PhoneCmdVel>)))
  "Returns string type for a message object of type '<PhoneCmdVel>"
  "custom_msgs/PhoneCmdVel")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'PhoneCmdVel)))
  "Returns string type for a message object of type 'PhoneCmdVel"
  "custom_msgs/PhoneCmdVel")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<PhoneCmdVel>)))
  "Returns md5sum for a message object of type '<PhoneCmdVel>"
  "992115d4061d600da0037995c70f58d7")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'PhoneCmdVel)))
  "Returns md5sum for a message object of type 'PhoneCmdVel"
  "992115d4061d600da0037995c70f58d7")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<PhoneCmdVel>)))
  "Returns full string definition for message of type '<PhoneCmdVel>"
  (cl:format cl:nil "float32 linear~%float32 angular~%bool deadman~%bool emergency_stop~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'PhoneCmdVel)))
  "Returns full string definition for message of type 'PhoneCmdVel"
  (cl:format cl:nil "float32 linear~%float32 angular~%bool deadman~%bool emergency_stop~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <PhoneCmdVel>))
  (cl:+ 0
     4
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <PhoneCmdVel>))
  "Converts a ROS message object to a list"
  (cl:list 'PhoneCmdVel
    (cl:cons ':linear (linear msg))
    (cl:cons ':angular (angular msg))
    (cl:cons ':deadman (deadman msg))
    (cl:cons ':emergency_stop (emergency_stop msg))
))
