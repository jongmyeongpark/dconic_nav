; Auto-generated. Do not edit!


(cl:in-package comm_app-msg)


;//! \htmlinclude state_msg.msg.html

(cl:defclass <state_msg> (roslisp-msg-protocol:ros-message)
  ((topic_name
    :reader topic_name
    :initarg :topic_name
    :type cl:string
    :initform "")
   (result
    :reader result
    :initarg :result
    :type cl:integer
    :initform 0))
)

(cl:defclass state_msg (<state_msg>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <state_msg>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'state_msg)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name comm_app-msg:<state_msg> is deprecated: use comm_app-msg:state_msg instead.")))

(cl:ensure-generic-function 'topic_name-val :lambda-list '(m))
(cl:defmethod topic_name-val ((m <state_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comm_app-msg:topic_name-val is deprecated.  Use comm_app-msg:topic_name instead.")
  (topic_name m))

(cl:ensure-generic-function 'result-val :lambda-list '(m))
(cl:defmethod result-val ((m <state_msg>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comm_app-msg:result-val is deprecated.  Use comm_app-msg:result instead.")
  (result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <state_msg>) ostream)
  "Serializes a message object of type '<state_msg>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'topic_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'topic_name))
  (cl:let* ((signed (cl:slot-value msg 'result)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <state_msg>) istream)
  "Deserializes a message object of type '<state_msg>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'topic_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'topic_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'result) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<state_msg>)))
  "Returns string type for a message object of type '<state_msg>"
  "comm_app/state_msg")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'state_msg)))
  "Returns string type for a message object of type 'state_msg"
  "comm_app/state_msg")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<state_msg>)))
  "Returns md5sum for a message object of type '<state_msg>"
  "c94167c6c6f29721fe9ea18bd0c568d6")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'state_msg)))
  "Returns md5sum for a message object of type 'state_msg"
  "c94167c6c6f29721fe9ea18bd0c568d6")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<state_msg>)))
  "Returns full string definition for message of type '<state_msg>"
  (cl:format cl:nil "string topic_name~%int32 result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'state_msg)))
  "Returns full string definition for message of type 'state_msg"
  (cl:format cl:nil "string topic_name~%int32 result~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <state_msg>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'topic_name))
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <state_msg>))
  "Converts a ROS message object to a list"
  (cl:list 'state_msg
    (cl:cons ':topic_name (topic_name msg))
    (cl:cons ':result (result msg))
))
