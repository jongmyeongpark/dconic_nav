; Auto-generated. Do not edit!


(cl:in-package flyinglet_msgs-msg)


;//! \htmlinclude EventLog.msg.html

(cl:defclass <EventLog> (roslisp-msg-protocol:ros-message)
  ((source
    :reader source
    :initarg :source
    :type cl:string
    :initform "")
   (type
    :reader type
    :initarg :type
    :type cl:string
    :initform "")
   (data
    :reader data
    :initarg :data
    :type cl:string
    :initform "")
   (action
    :reader action
    :initarg :action
    :type cl:string
    :initform "")
   (state
    :reader state
    :initarg :state
    :type cl:fixnum
    :initform 0))
)

(cl:defclass EventLog (<EventLog>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EventLog>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EventLog)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name flyinglet_msgs-msg:<EventLog> is deprecated: use flyinglet_msgs-msg:EventLog instead.")))

(cl:ensure-generic-function 'source-val :lambda-list '(m))
(cl:defmethod source-val ((m <EventLog>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader flyinglet_msgs-msg:source-val is deprecated.  Use flyinglet_msgs-msg:source instead.")
  (source m))

(cl:ensure-generic-function 'type-val :lambda-list '(m))
(cl:defmethod type-val ((m <EventLog>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader flyinglet_msgs-msg:type-val is deprecated.  Use flyinglet_msgs-msg:type instead.")
  (type m))

(cl:ensure-generic-function 'data-val :lambda-list '(m))
(cl:defmethod data-val ((m <EventLog>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader flyinglet_msgs-msg:data-val is deprecated.  Use flyinglet_msgs-msg:data instead.")
  (data m))

(cl:ensure-generic-function 'action-val :lambda-list '(m))
(cl:defmethod action-val ((m <EventLog>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader flyinglet_msgs-msg:action-val is deprecated.  Use flyinglet_msgs-msg:action instead.")
  (action m))

(cl:ensure-generic-function 'state-val :lambda-list '(m))
(cl:defmethod state-val ((m <EventLog>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader flyinglet_msgs-msg:state-val is deprecated.  Use flyinglet_msgs-msg:state instead.")
  (state m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<EventLog>)))
    "Constants for message type '<EventLog>"
  '((:STATE_READY . 0)
    (:STATE_START . 1)
    (:STATE_RESUME . 2)
    (:STATE_PAUSE . 3)
    (:STATE_STOP . 4)
    (:STATE_FINISH . 5)
    (:STATE_ERROR . 6))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'EventLog)))
    "Constants for message type 'EventLog"
  '((:STATE_READY . 0)
    (:STATE_START . 1)
    (:STATE_RESUME . 2)
    (:STATE_PAUSE . 3)
    (:STATE_STOP . 4)
    (:STATE_FINISH . 5)
    (:STATE_ERROR . 6))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EventLog>) ostream)
  "Serializes a message object of type '<EventLog>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'source))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'source))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'type))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'data))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'data))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'action))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'action))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EventLog>) istream)
  "Deserializes a message object of type '<EventLog>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'source) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'source) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'data) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'data) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'action) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'action) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'state)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EventLog>)))
  "Returns string type for a message object of type '<EventLog>"
  "flyinglet_msgs/EventLog")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EventLog)))
  "Returns string type for a message object of type 'EventLog"
  "flyinglet_msgs/EventLog")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EventLog>)))
  "Returns md5sum for a message object of type '<EventLog>"
  "af7df165f1ee3dfe98782f8478c6a586")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EventLog)))
  "Returns md5sum for a message object of type 'EventLog"
  "af7df165f1ee3dfe98782f8478c6a586")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EventLog>)))
  "Returns full string definition for message of type '<EventLog>"
  (cl:format cl:nil "string source~%~%string type # ???~%~%string data # json~%~%string action~%~%uint8 STATE_READY = 0~%uint8 STATE_START = 1~%uint8 STATE_RESUME = 2~%uint8 STATE_PAUSE = 3~%uint8 STATE_STOP = 4~%uint8 STATE_FINISH = 5~%uint8 STATE_ERROR = 6~%~%uint8 state~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EventLog)))
  "Returns full string definition for message of type 'EventLog"
  (cl:format cl:nil "string source~%~%string type # ???~%~%string data # json~%~%string action~%~%uint8 STATE_READY = 0~%uint8 STATE_START = 1~%uint8 STATE_RESUME = 2~%uint8 STATE_PAUSE = 3~%uint8 STATE_STOP = 4~%uint8 STATE_FINISH = 5~%uint8 STATE_ERROR = 6~%~%uint8 state~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EventLog>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'source))
     4 (cl:length (cl:slot-value msg 'type))
     4 (cl:length (cl:slot-value msg 'data))
     4 (cl:length (cl:slot-value msg 'action))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EventLog>))
  "Converts a ROS message object to a list"
  (cl:list 'EventLog
    (cl:cons ':source (source msg))
    (cl:cons ':type (type msg))
    (cl:cons ':data (data msg))
    (cl:cons ':action (action msg))
    (cl:cons ':state (state msg))
))
