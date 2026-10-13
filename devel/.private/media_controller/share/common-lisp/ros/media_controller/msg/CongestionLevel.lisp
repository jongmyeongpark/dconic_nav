; Auto-generated. Do not edit!


(cl:in-package media_controller-msg)


;//! \htmlinclude CongestionLevel.msg.html

(cl:defclass <CongestionLevel> (roslisp-msg-protocol:ros-message)
  ((time
    :reader time
    :initarg :time
    :type cl:float
    :initform 0.0)
   (duration
    :reader duration
    :initarg :duration
    :type cl:float
    :initform 0.0)
   (congestionLevel
    :reader congestionLevel
    :initarg :congestionLevel
    :type cl:integer
    :initform 0))
)

(cl:defclass CongestionLevel (<CongestionLevel>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <CongestionLevel>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'CongestionLevel)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name media_controller-msg:<CongestionLevel> is deprecated: use media_controller-msg:CongestionLevel instead.")))

(cl:ensure-generic-function 'time-val :lambda-list '(m))
(cl:defmethod time-val ((m <CongestionLevel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader media_controller-msg:time-val is deprecated.  Use media_controller-msg:time instead.")
  (time m))

(cl:ensure-generic-function 'duration-val :lambda-list '(m))
(cl:defmethod duration-val ((m <CongestionLevel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader media_controller-msg:duration-val is deprecated.  Use media_controller-msg:duration instead.")
  (duration m))

(cl:ensure-generic-function 'congestionLevel-val :lambda-list '(m))
(cl:defmethod congestionLevel-val ((m <CongestionLevel>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader media_controller-msg:congestionLevel-val is deprecated.  Use media_controller-msg:congestionLevel instead.")
  (congestionLevel m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <CongestionLevel>) ostream)
  "Serializes a message object of type '<CongestionLevel>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'time))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'duration))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let* ((signed (cl:slot-value msg 'congestionLevel)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <CongestionLevel>) istream)
  "Deserializes a message object of type '<CongestionLevel>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'time) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'duration) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'congestionLevel) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<CongestionLevel>)))
  "Returns string type for a message object of type '<CongestionLevel>"
  "media_controller/CongestionLevel")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'CongestionLevel)))
  "Returns string type for a message object of type 'CongestionLevel"
  "media_controller/CongestionLevel")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<CongestionLevel>)))
  "Returns md5sum for a message object of type '<CongestionLevel>"
  "d721083192e0944c0aea1794baa1891f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'CongestionLevel)))
  "Returns md5sum for a message object of type 'CongestionLevel"
  "d721083192e0944c0aea1794baa1891f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<CongestionLevel>)))
  "Returns full string definition for message of type '<CongestionLevel>"
  (cl:format cl:nil "# Sent time~%float64 time~%~%# Duration time~%float64 duration~%~%# Congestion level~%int32 congestionLevel~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'CongestionLevel)))
  "Returns full string definition for message of type 'CongestionLevel"
  (cl:format cl:nil "# Sent time~%float64 time~%~%# Duration time~%float64 duration~%~%# Congestion level~%int32 congestionLevel~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <CongestionLevel>))
  (cl:+ 0
     8
     8
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <CongestionLevel>))
  "Converts a ROS message object to a list"
  (cl:list 'CongestionLevel
    (cl:cons ':time (time msg))
    (cl:cons ':duration (duration msg))
    (cl:cons ':congestionLevel (congestionLevel msg))
))
