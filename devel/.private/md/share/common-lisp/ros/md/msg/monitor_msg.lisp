; Auto-generated. Do not edit!


(cl:in-package md-msg)


;//! \htmlinclude monitor_msg.msg.html

(cl:defclass <monitor_msg> (roslisp-msg-protocol:ros-message)
  ((lPosiX
    :reader lPosiX
    :initarg :lPosiX
    :type cl:integer
    :initform 0)
   (lPosiY
    :reader lPosiY
    :initarg :lPosiY
    :type cl:integer
    :initform 0)
   (sTheta
    :reader sTheta
    :initarg :sTheta
    :type cl:fixnum
    :initform 0)
   (sRealLinearVel
    :reader sRealLinearVel
    :initarg :sRealLinearVel
    :type cl:fixnum
    :initform 0)
   (sRealAngularVel
    :reader sRealAngularVel
    :initarg :sRealAngularVel
    :type cl:fixnum
    :initform 0)
   (sVoltIn
    :reader sVoltIn
    :initarg :sVoltIn
    :type cl:fixnum
    :initform 0)
   (sLeftMotCur
    :reader sLeftMotCur
    :initarg :sLeftMotCur
    :type cl:fixnum
    :initform 0)
   (sRightMotCur
    :reader sRightMotCur
    :initarg :sRightMotCur
    :type cl:fixnum
    :initform 0)
   (byUS1
    :reader byUS1
    :initarg :byUS1
    :type cl:fixnum
    :initform 0)
   (byUS2
    :reader byUS2
    :initarg :byUS2
    :type cl:fixnum
    :initform 0)
   (byUS3
    :reader byUS3
    :initarg :byUS3
    :type cl:fixnum
    :initform 0)
   (byUS4
    :reader byUS4
    :initarg :byUS4
    :type cl:fixnum
    :initform 0)
   (byPlatStatus
    :reader byPlatStatus
    :initarg :byPlatStatus
    :type cl:fixnum
    :initform 0)
   (byDocStatus
    :reader byDocStatus
    :initarg :byDocStatus
    :type cl:fixnum
    :initform 0)
   (byLeftMotStatus
    :reader byLeftMotStatus
    :initarg :byLeftMotStatus
    :type cl:fixnum
    :initform 0)
   (byRightMotStatus
    :reader byRightMotStatus
    :initarg :byRightMotStatus
    :type cl:fixnum
    :initform 0)
   (lLeftMotPosi
    :reader lLeftMotPosi
    :initarg :lLeftMotPosi
    :type cl:integer
    :initform 0)
   (lRightMotPosi
    :reader lRightMotPosi
    :initarg :lRightMotPosi
    :type cl:integer
    :initform 0)
   (byLeftIOMonitor
    :reader byLeftIOMonitor
    :initarg :byLeftIOMonitor
    :type cl:fixnum
    :initform 0)
   (byRightIOMonitor
    :reader byRightIOMonitor
    :initarg :byRightIOMonitor
    :type cl:fixnum
    :initform 0))
)

(cl:defclass monitor_msg (<monitor_msg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <monitor_msg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'monitor_msg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name md-msg:<monitor_msg> is deprecated: use md-msg:monitor_msg instead.")))

(cl:ensure-generic-function 'lPosiX-val :lambda-list '(m))
(cl:defmethod lPosiX-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:lPosiX-val is deprecated.  Use md-msg:lPosiX instead.")
  (lPosiX m))

(cl:ensure-generic-function 'lPosiY-val :lambda-list '(m))
(cl:defmethod lPosiY-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:lPosiY-val is deprecated.  Use md-msg:lPosiY instead.")
  (lPosiY m))

(cl:ensure-generic-function 'sTheta-val :lambda-list '(m))
(cl:defmethod sTheta-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:sTheta-val is deprecated.  Use md-msg:sTheta instead.")
  (sTheta m))

(cl:ensure-generic-function 'sRealLinearVel-val :lambda-list '(m))
(cl:defmethod sRealLinearVel-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:sRealLinearVel-val is deprecated.  Use md-msg:sRealLinearVel instead.")
  (sRealLinearVel m))

(cl:ensure-generic-function 'sRealAngularVel-val :lambda-list '(m))
(cl:defmethod sRealAngularVel-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:sRealAngularVel-val is deprecated.  Use md-msg:sRealAngularVel instead.")
  (sRealAngularVel m))

(cl:ensure-generic-function 'sVoltIn-val :lambda-list '(m))
(cl:defmethod sVoltIn-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:sVoltIn-val is deprecated.  Use md-msg:sVoltIn instead.")
  (sVoltIn m))

(cl:ensure-generic-function 'sLeftMotCur-val :lambda-list '(m))
(cl:defmethod sLeftMotCur-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:sLeftMotCur-val is deprecated.  Use md-msg:sLeftMotCur instead.")
  (sLeftMotCur m))

(cl:ensure-generic-function 'sRightMotCur-val :lambda-list '(m))
(cl:defmethod sRightMotCur-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:sRightMotCur-val is deprecated.  Use md-msg:sRightMotCur instead.")
  (sRightMotCur m))

(cl:ensure-generic-function 'byUS1-val :lambda-list '(m))
(cl:defmethod byUS1-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byUS1-val is deprecated.  Use md-msg:byUS1 instead.")
  (byUS1 m))

(cl:ensure-generic-function 'byUS2-val :lambda-list '(m))
(cl:defmethod byUS2-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byUS2-val is deprecated.  Use md-msg:byUS2 instead.")
  (byUS2 m))

(cl:ensure-generic-function 'byUS3-val :lambda-list '(m))
(cl:defmethod byUS3-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byUS3-val is deprecated.  Use md-msg:byUS3 instead.")
  (byUS3 m))

(cl:ensure-generic-function 'byUS4-val :lambda-list '(m))
(cl:defmethod byUS4-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byUS4-val is deprecated.  Use md-msg:byUS4 instead.")
  (byUS4 m))

(cl:ensure-generic-function 'byPlatStatus-val :lambda-list '(m))
(cl:defmethod byPlatStatus-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byPlatStatus-val is deprecated.  Use md-msg:byPlatStatus instead.")
  (byPlatStatus m))

(cl:ensure-generic-function 'byDocStatus-val :lambda-list '(m))
(cl:defmethod byDocStatus-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byDocStatus-val is deprecated.  Use md-msg:byDocStatus instead.")
  (byDocStatus m))

(cl:ensure-generic-function 'byLeftMotStatus-val :lambda-list '(m))
(cl:defmethod byLeftMotStatus-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byLeftMotStatus-val is deprecated.  Use md-msg:byLeftMotStatus instead.")
  (byLeftMotStatus m))

(cl:ensure-generic-function 'byRightMotStatus-val :lambda-list '(m))
(cl:defmethod byRightMotStatus-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byRightMotStatus-val is deprecated.  Use md-msg:byRightMotStatus instead.")
  (byRightMotStatus m))

(cl:ensure-generic-function 'lLeftMotPosi-val :lambda-list '(m))
(cl:defmethod lLeftMotPosi-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:lLeftMotPosi-val is deprecated.  Use md-msg:lLeftMotPosi instead.")
  (lLeftMotPosi m))

(cl:ensure-generic-function 'lRightMotPosi-val :lambda-list '(m))
(cl:defmethod lRightMotPosi-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:lRightMotPosi-val is deprecated.  Use md-msg:lRightMotPosi instead.")
  (lRightMotPosi m))

(cl:ensure-generic-function 'byLeftIOMonitor-val :lambda-list '(m))
(cl:defmethod byLeftIOMonitor-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byLeftIOMonitor-val is deprecated.  Use md-msg:byLeftIOMonitor instead.")
  (byLeftIOMonitor m))

(cl:ensure-generic-function 'byRightIOMonitor-val :lambda-list '(m))
(cl:defmethod byRightIOMonitor-val ((m <monitor_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader md-msg:byRightIOMonitor-val is deprecated.  Use md-msg:byRightIOMonitor instead.")
  (byRightIOMonitor m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <monitor_msg>) ostream)
  "Serializes a message object of type '<monitor_msg>"
  (cl:let* ((signed (cl:slot-value msg 'lPosiX)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'lPosiY)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'sTheta)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'sRealLinearVel)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'sRealAngularVel)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'sVoltIn)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'sLeftMotCur)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'sRightMotCur)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byUS1)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byUS2)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byUS3)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byUS4)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byPlatStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byDocStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byLeftMotStatus)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byRightMotStatus)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'lLeftMotPosi)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'lRightMotPosi)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byLeftIOMonitor)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byRightIOMonitor)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <monitor_msg>) istream)
  "Deserializes a message object of type '<monitor_msg>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lPosiX) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lPosiY) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sTheta) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sRealLinearVel) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sRealAngularVel) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sVoltIn) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sLeftMotCur) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sRightMotCur) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byUS1)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byUS2)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byUS3)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byUS4)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byPlatStatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byDocStatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byLeftMotStatus)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byRightMotStatus)) (cl:read-byte istream))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lLeftMotPosi) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'lRightMotPosi) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byLeftIOMonitor)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'byRightIOMonitor)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<monitor_msg>)))
  "Returns string type for a message object of type '<monitor_msg>"
  "md/monitor_msg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'monitor_msg)))
  "Returns string type for a message object of type 'monitor_msg"
  "md/monitor_msg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<monitor_msg>)))
  "Returns md5sum for a message object of type '<monitor_msg>"
  "265bab62db87a50551604683361197df")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'monitor_msg)))
  "Returns md5sum for a message object of type 'monitor_msg"
  "265bab62db87a50551604683361197df")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<monitor_msg>)))
  "Returns full string definition for message of type '<monitor_msg>"
  (cl:format cl:nil "int32 lPosiX ~%int32 lPosiY~%int16 sTheta~%int16 sRealLinearVel~%int16 sRealAngularVel~%int16 sVoltIn~%int16 sLeftMotCur~%int16 sRightMotCur~%uint8 byUS1~%uint8 byUS2~%uint8 byUS3~%uint8 byUS4~%uint8 byPlatStatus~%uint8 byDocStatus~%uint8 byLeftMotStatus~%uint8 byRightMotStatus~%int32 lLeftMotPosi~%int32 lRightMotPosi~%uint8 byLeftIOMonitor~%uint8 byRightIOMonitor~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'monitor_msg)))
  "Returns full string definition for message of type 'monitor_msg"
  (cl:format cl:nil "int32 lPosiX ~%int32 lPosiY~%int16 sTheta~%int16 sRealLinearVel~%int16 sRealAngularVel~%int16 sVoltIn~%int16 sLeftMotCur~%int16 sRightMotCur~%uint8 byUS1~%uint8 byUS2~%uint8 byUS3~%uint8 byUS4~%uint8 byPlatStatus~%uint8 byDocStatus~%uint8 byLeftMotStatus~%uint8 byRightMotStatus~%int32 lLeftMotPosi~%int32 lRightMotPosi~%uint8 byLeftIOMonitor~%uint8 byRightIOMonitor~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <monitor_msg>))
  (cl:+ 0
     4
     4
     2
     2
     2
     2
     2
     2
     1
     1
     1
     1
     1
     1
     1
     1
     4
     4
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <monitor_msg>))
  "Converts a ROS message object to a list"
  (cl:list 'monitor_msg
    (cl:cons ':lPosiX (lPosiX msg))
    (cl:cons ':lPosiY (lPosiY msg))
    (cl:cons ':sTheta (sTheta msg))
    (cl:cons ':sRealLinearVel (sRealLinearVel msg))
    (cl:cons ':sRealAngularVel (sRealAngularVel msg))
    (cl:cons ':sVoltIn (sVoltIn msg))
    (cl:cons ':sLeftMotCur (sLeftMotCur msg))
    (cl:cons ':sRightMotCur (sRightMotCur msg))
    (cl:cons ':byUS1 (byUS1 msg))
    (cl:cons ':byUS2 (byUS2 msg))
    (cl:cons ':byUS3 (byUS3 msg))
    (cl:cons ':byUS4 (byUS4 msg))
    (cl:cons ':byPlatStatus (byPlatStatus msg))
    (cl:cons ':byDocStatus (byDocStatus msg))
    (cl:cons ':byLeftMotStatus (byLeftMotStatus msg))
    (cl:cons ':byRightMotStatus (byRightMotStatus msg))
    (cl:cons ':lLeftMotPosi (lLeftMotPosi msg))
    (cl:cons ':lRightMotPosi (lRightMotPosi msg))
    (cl:cons ':byLeftIOMonitor (byLeftIOMonitor msg))
    (cl:cons ':byRightIOMonitor (byRightIOMonitor msg))
))
