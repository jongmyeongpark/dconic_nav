; Auto-generated. Do not edit!


(cl:in-package md-msg)


;//! \htmlinclude vel_msg.msg.html

(cl:defclass <vel_msg> (roslisp-msg-protocol:ros-message)
  ((nLinear
    :reader nLinear
    :initarg :nLinear
    :type cl:integer
    :initform 0)
   (nAngular
    :reader nAngular
    :initarg :nAngular
    :type cl:integer
    :initform 0)
   (byResetOdometry
    :reader byResetOdometry
    :initarg :byResetOdometry
    :type cl:fixnum
    :initform 0)
   (byResetAngle
    :reader byResetAngle
    :initarg :byResetAngle
    :type cl:fixnum
    :initform 0)
   (byResetAlarm
    :reader byResetAlarm
    :initarg :byResetAlarm
    :type cl:fixnum
    :initform 0))
)

(cl:defclass vel_msg (<vel_msg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <vel_msg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'vel_msg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name md-msg:<vel_msg> is deprecated: use md-msg:vel_msg instead.")))

(cl:ensure-generic-function 'nLinear-val :lambda-list '(m))
(cl:defmethod nLinear-val ((m <vel_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:nLinear-val is deprecated.  Use md-msg:nLinear instead.")
  (nLinear m))

(cl:ensure-generic-function 'nAngular-val :lambda-list '(m))
(cl:defmethod nAngular-val ((m <vel_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:nAngular-val is deprecated.  Use md-msg:nAngular instead.")
  (nAngular m))

(cl:ensure-generic-function 'byResetOdometry-val :lambda-list '(m))
(cl:defmethod byResetOdometry-val ((m <vel_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byResetOdometry-val is deprecated.  Use md-msg:byResetOdometry instead.")
  (byResetOdometry m))

(cl:ensure-generic-function 'byResetAngle-val :lambda-list '(m))
(cl:defmethod byResetAngle-val ((m <vel_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byResetAngle-val is deprecated.  Use md-msg:byResetAngle instead.")
  (byResetAngle m))

(cl:ensure-generic-function 'byResetAlarm-val :lambda-list '(m))
(cl:defmethod byResetAlarm-val ((m <vel_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byResetAlarm-val is deprecated.  Use md-msg:byResetAlarm instead.")
  (byResetAlarm m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <vel_msg>) ostream)
  "Serializes a message object of type '<vel_msg>"
  (cl:let* ((signed (cl:slot-value msg 'nLinear)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'nAngular)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'byResetOdometry)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'byResetAngle)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'byResetAlarm)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <vel_msg>) istream)
  "Deserializes a message object of type '<vel_msg>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nLinear) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'nAngular) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'byResetOdometry) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'byResetAngle) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'byResetAlarm) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<vel_msg>)))
  "Returns string type for a message object of type '<vel_msg>"
  "md/vel_msg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'vel_msg)))
  "Returns string type for a message object of type 'vel_msg"
  "md/vel_msg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<vel_msg>)))
  "Returns md5sum for a message object of type '<vel_msg>"
  "e52979e2ff6a0ff38b6f29b2d215648d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'vel_msg)))
  "Returns md5sum for a message object of type 'vel_msg"
  "e52979e2ff6a0ff38b6f29b2d215648d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<vel_msg>)))
  "Returns full string definition for message of type '<vel_msg>"
  (cl:format cl:nil "int32 nLinear~%int32 nAngular~%int8 byResetOdometry~%int8 byResetAngle~%int8 byResetAlarm~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'vel_msg)))
  "Returns full string definition for message of type 'vel_msg"
  (cl:format cl:nil "int32 nLinear~%int32 nAngular~%int8 byResetOdometry~%int8 byResetAngle~%int8 byResetAlarm~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <vel_msg>))
  (cl:+ 0
     4
     4
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <vel_msg>))
  "Converts a ROS message object to a list"
  (cl:list 'vel_msg
    (cl:cons ':nLinear (nLinear msg))
    (cl:cons ':nAngular (nAngular msg))
    (cl:cons ':byResetOdometry (byResetOdometry msg))
    (cl:cons ':byResetAngle (byResetAngle msg))
    (cl:cons ':byResetAlarm (byResetAlarm msg))
))
