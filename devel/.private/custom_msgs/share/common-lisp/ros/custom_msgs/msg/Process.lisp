; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude Process.msg.html

(cl:defclass <Process> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (running
    :reader running
    :initarg :running
    :type cl:boolean
    :initform cl:nil)
   (base_process
    :reader base_process
    :initarg :base_process
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass Process (<Process>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Process>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Process)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<Process> is deprecated: use custom_msgs-msg:Process instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <Process>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:name-val is deprecated.  Use custom_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'running-val :lambda-list '(m))
(cl:defmethod running-val ((m <Process>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:running-val is deprecated.  Use custom_msgs-msg:running instead.")
  (running m))

(cl:ensure-generic-function 'base_process-val :lambda-list '(m))
(cl:defmethod base_process-val ((m <Process>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:base_process-val is deprecated.  Use custom_msgs-msg:base_process instead.")
  (base_process m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Process>) ostream)
  "Serializes a message object of type '<Process>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'running) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'base_process) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Process>) istream)
  "Deserializes a message object of type '<Process>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'running) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'base_process) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Process>)))
  "Returns string type for a message object of type '<Process>"
  "custom_msgs/Process")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Process)))
  "Returns string type for a message object of type 'Process"
  "custom_msgs/Process")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Process>)))
  "Returns md5sum for a message object of type '<Process>"
  "790230f4d0eea7c1e89d8558f738f0c2")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Process)))
  "Returns md5sum for a message object of type 'Process"
  "790230f4d0eea7c1e89d8558f738f0c2")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Process>)))
  "Returns full string definition for message of type '<Process>"
  (cl:format cl:nil "string name~%bool running~%bool base_process~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Process)))
  "Returns full string definition for message of type 'Process"
  (cl:format cl:nil "string name~%bool running~%bool base_process~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Process>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Process>))
  "Converts a ROS message object to a list"
  (cl:list 'Process
    (cl:cons ':name (name msg))
    (cl:cons ':running (running msg))
    (cl:cons ':base_process (base_process msg))
))
