; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude Service.msg.html

(cl:defclass <Service> (roslisp-msg-protocol:ros-message)
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
   (dependencies
    :reader dependencies
    :initarg :dependencies
    :type (cl:vector custom_msgs-msg:Dependency)
   :initform (cl:make-array 0 :element-type 'custom_msgs-msg:Dependency :initial-element (cl:make-instance 'custom_msgs-msg:Dependency))))
)

(cl:defclass Service (<Service>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Service>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Service)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<Service> is deprecated: use custom_msgs-msg:Service instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <Service>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:name-val is deprecated.  Use custom_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'running-val :lambda-list '(m))
(cl:defmethod running-val ((m <Service>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:running-val is deprecated.  Use custom_msgs-msg:running instead.")
  (running m))

(cl:ensure-generic-function 'dependencies-val :lambda-list '(m))
(cl:defmethod dependencies-val ((m <Service>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:dependencies-val is deprecated.  Use custom_msgs-msg:dependencies instead.")
  (dependencies m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Service>) ostream)
  "Serializes a message object of type '<Service>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'running) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'dependencies))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'dependencies))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Service>) istream)
  "Deserializes a message object of type '<Service>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:setf (cl:slot-value msg 'running) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'dependencies) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'dependencies)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'custom_msgs-msg:Dependency))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Service>)))
  "Returns string type for a message object of type '<Service>"
  "custom_msgs/Service")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Service)))
  "Returns string type for a message object of type 'Service"
  "custom_msgs/Service")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Service>)))
  "Returns md5sum for a message object of type '<Service>"
  "38e06d554a566cfc75320c104827e776")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Service)))
  "Returns md5sum for a message object of type 'Service"
  "38e06d554a566cfc75320c104827e776")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Service>)))
  "Returns full string definition for message of type '<Service>"
  (cl:format cl:nil "string name~%bool running~%custom_msgs/Dependency[] dependencies~%================================================================================~%MSG: custom_msgs/Dependency~%string name~%bool is_service~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Service)))
  "Returns full string definition for message of type 'Service"
  (cl:format cl:nil "string name~%bool running~%custom_msgs/Dependency[] dependencies~%================================================================================~%MSG: custom_msgs/Dependency~%string name~%bool is_service~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Service>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'dependencies) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Service>))
  "Converts a ROS message object to a list"
  (cl:list 'Service
    (cl:cons ':name (name msg))
    (cl:cons ':running (running msg))
    (cl:cons ':dependencies (dependencies msg))
))
