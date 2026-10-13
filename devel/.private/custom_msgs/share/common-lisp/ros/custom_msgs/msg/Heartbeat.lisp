; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude Heartbeat.msg.html

(cl:defclass <Heartbeat> (roslisp-msg-protocol:ros-message)
  ((port
    :reader port
    :initarg :port
    :type cl:integer
    :initform 0)
   (uuid
    :reader uuid
    :initarg :uuid
    :type cl:string
    :initform "")
   (connection_uuid
    :reader connection_uuid
    :initarg :connection_uuid
    :type cl:string
    :initform ""))
)

(cl:defclass Heartbeat (<Heartbeat>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Heartbeat>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Heartbeat)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<Heartbeat> is deprecated: use custom_msgs-msg:Heartbeat instead.")))

(cl:ensure-generic-function 'port-val :lambda-list '(m))
(cl:defmethod port-val ((m <Heartbeat>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:port-val is deprecated.  Use custom_msgs-msg:port instead.")
  (port m))

(cl:ensure-generic-function 'uuid-val :lambda-list '(m))
(cl:defmethod uuid-val ((m <Heartbeat>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:uuid-val is deprecated.  Use custom_msgs-msg:uuid instead.")
  (uuid m))

(cl:ensure-generic-function 'connection_uuid-val :lambda-list '(m))
(cl:defmethod connection_uuid-val ((m <Heartbeat>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:connection_uuid-val is deprecated.  Use custom_msgs-msg:connection_uuid instead.")
  (connection_uuid m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Heartbeat>) ostream)
  "Serializes a message object of type '<Heartbeat>"
  (cl:let* ((signed (cl:slot-value msg 'port)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'uuid))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'uuid))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'connection_uuid))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'connection_uuid))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Heartbeat>) istream)
  "Deserializes a message object of type '<Heartbeat>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'port) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'uuid) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'uuid) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'connection_uuid) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'connection_uuid) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Heartbeat>)))
  "Returns string type for a message object of type '<Heartbeat>"
  "custom_msgs/Heartbeat")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Heartbeat)))
  "Returns string type for a message object of type 'Heartbeat"
  "custom_msgs/Heartbeat")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Heartbeat>)))
  "Returns md5sum for a message object of type '<Heartbeat>"
  "4077598408c2d9fd9a1f23b114106d6c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Heartbeat)))
  "Returns md5sum for a message object of type 'Heartbeat"
  "4077598408c2d9fd9a1f23b114106d6c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Heartbeat>)))
  "Returns full string definition for message of type '<Heartbeat>"
  (cl:format cl:nil "int32 port~%string uuid~%string connection_uuid~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Heartbeat)))
  "Returns full string definition for message of type 'Heartbeat"
  (cl:format cl:nil "int32 port~%string uuid~%string connection_uuid~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Heartbeat>))
  (cl:+ 0
     4
     4 (cl:length (cl:slot-value msg 'uuid))
     4 (cl:length (cl:slot-value msg 'connection_uuid))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Heartbeat>))
  "Converts a ROS message object to a list"
  (cl:list 'Heartbeat
    (cl:cons ':port (port msg))
    (cl:cons ':uuid (uuid msg))
    (cl:cons ':connection_uuid (connection_uuid msg))
))
