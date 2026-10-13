; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude AppCmd.msg.html

(cl:defclass <AppCmd> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (has_param
    :reader has_param
    :initarg :has_param
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass AppCmd (<AppCmd>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <AppCmd>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'AppCmd)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<AppCmd> is deprecated: use custom_msgs-msg:AppCmd instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <AppCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:name-val is deprecated.  Use custom_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'has_param-val :lambda-list '(m))
(cl:defmethod has_param-val ((m <AppCmd>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:has_param-val is deprecated.  Use custom_msgs-msg:has_param instead.")
  (has_param m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <AppCmd>) ostream)
  "Serializes a message object of type '<AppCmd>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'has_param) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <AppCmd>) istream)
  "Deserializes a message object of type '<AppCmd>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'has_param) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<AppCmd>)))
  "Returns string type for a message object of type '<AppCmd>"
  "custom_msgs/AppCmd")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'AppCmd)))
  "Returns string type for a message object of type 'AppCmd"
  "custom_msgs/AppCmd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<AppCmd>)))
  "Returns md5sum for a message object of type '<AppCmd>"
  "6017ebc226af765a301bb26ab1939ac0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'AppCmd)))
  "Returns md5sum for a message object of type 'AppCmd"
  "6017ebc226af765a301bb26ab1939ac0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<AppCmd>)))
  "Returns full string definition for message of type '<AppCmd>"
  (cl:format cl:nil "string name~%bool has_param~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'AppCmd)))
  "Returns full string definition for message of type 'AppCmd"
  (cl:format cl:nil "string name~%bool has_param~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <AppCmd>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <AppCmd>))
  "Converts a ROS message object to a list"
  (cl:list 'AppCmd
    (cl:cons ':name (name msg))
    (cl:cons ':has_param (has_param msg))
))
