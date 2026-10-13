; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude Dependency.msg.html

(cl:defclass <Dependency> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (is_service
    :reader is_service
    :initarg :is_service
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Dependency (<Dependency>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Dependency>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Dependency)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<Dependency> is deprecated: use custom_msgs-msg:Dependency instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <Dependency>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:name-val is deprecated.  Use custom_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'is_service-val :lambda-list '(m))
(cl:defmethod is_service-val ((m <Dependency>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:is_service-val is deprecated.  Use custom_msgs-msg:is_service instead.")
  (is_service m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Dependency>) ostream)
  "Serializes a message object of type '<Dependency>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'is_service) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Dependency>) istream)
  "Deserializes a message object of type '<Dependency>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'is_service) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Dependency>)))
  "Returns string type for a message object of type '<Dependency>"
  "custom_msgs/Dependency")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Dependency)))
  "Returns string type for a message object of type 'Dependency"
  "custom_msgs/Dependency")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Dependency>)))
  "Returns md5sum for a message object of type '<Dependency>"
  "4731fce1f3d3e6878365b333c34c8ab2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Dependency)))
  "Returns md5sum for a message object of type 'Dependency"
  "4731fce1f3d3e6878365b333c34c8ab2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Dependency>)))
  "Returns full string definition for message of type '<Dependency>"
  (cl:format cl:nil "string name~%bool is_service~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Dependency)))
  "Returns full string definition for message of type 'Dependency"
  (cl:format cl:nil "string name~%bool is_service~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Dependency>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Dependency>))
  "Converts a ROS message object to a list"
  (cl:list 'Dependency
    (cl:cons ':name (name msg))
    (cl:cons ':is_service (is_service msg))
))
