; Auto-generated. Do not edit!


(cl:in-package comm_app-srv)


;//! \htmlinclude start_drive-request.msg.html

(cl:defclass <start_drive-request> (roslisp-msg-protocol:ros-message)
  ((str
    :reader str
    :initarg :str
    :type cl:string
    :initform ""))
)

(cl:defclass start_drive-request (<start_drive-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <start_drive-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'start_drive-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name comm_app-srv:<start_drive-request> is deprecated: use comm_app-srv:start_drive-request instead.")))

(cl:ensure-generic-function 'str-val :lambda-list '(m))
(cl:defmethod str-val ((m <start_drive-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comm_app-srv:str-val is deprecated.  Use comm_app-srv:str instead.")
  (str m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <start_drive-request>) ostream)
  "Serializes a message object of type '<start_drive-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'str))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'str))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <start_drive-request>) istream)
  "Deserializes a message object of type '<start_drive-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'str) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'str) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<start_drive-request>)))
  "Returns string type for a service object of type '<start_drive-request>"
  "comm_app/start_driveRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'start_drive-request)))
  "Returns string type for a service object of type 'start_drive-request"
  "comm_app/start_driveRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<start_drive-request>)))
  "Returns md5sum for a message object of type '<start_drive-request>"
  "671f8e4998eaec79f1c47e339dfd527b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'start_drive-request)))
  "Returns md5sum for a message object of type 'start_drive-request"
  "671f8e4998eaec79f1c47e339dfd527b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<start_drive-request>)))
  "Returns full string definition for message of type '<start_drive-request>"
  (cl:format cl:nil "string str~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'start_drive-request)))
  "Returns full string definition for message of type 'start_drive-request"
  (cl:format cl:nil "string str~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <start_drive-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'str))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <start_drive-request>))
  "Converts a ROS message object to a list"
  (cl:list 'start_drive-request
    (cl:cons ':str (str msg))
))
;//! \htmlinclude start_drive-response.msg.html

(cl:defclass <start_drive-response> (roslisp-msg-protocol:ros-message)
  ((str
    :reader str
    :initarg :str
    :type cl:string
    :initform ""))
)

(cl:defclass start_drive-response (<start_drive-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <start_drive-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'start_drive-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name comm_app-srv:<start_drive-response> is deprecated: use comm_app-srv:start_drive-response instead.")))

(cl:ensure-generic-function 'str-val :lambda-list '(m))
(cl:defmethod str-val ((m <start_drive-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comm_app-srv:str-val is deprecated.  Use comm_app-srv:str instead.")
  (str m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <start_drive-response>) ostream)
  "Serializes a message object of type '<start_drive-response>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'str))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'str))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <start_drive-response>) istream)
  "Deserializes a message object of type '<start_drive-response>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'str) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'str) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<start_drive-response>)))
  "Returns string type for a service object of type '<start_drive-response>"
  "comm_app/start_driveResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'start_drive-response)))
  "Returns string type for a service object of type 'start_drive-response"
  "comm_app/start_driveResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<start_drive-response>)))
  "Returns md5sum for a message object of type '<start_drive-response>"
  "671f8e4998eaec79f1c47e339dfd527b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'start_drive-response)))
  "Returns md5sum for a message object of type 'start_drive-response"
  "671f8e4998eaec79f1c47e339dfd527b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<start_drive-response>)))
  "Returns full string definition for message of type '<start_drive-response>"
  (cl:format cl:nil "string str~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'start_drive-response)))
  "Returns full string definition for message of type 'start_drive-response"
  (cl:format cl:nil "string str~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <start_drive-response>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'str))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <start_drive-response>))
  "Converts a ROS message object to a list"
  (cl:list 'start_drive-response
    (cl:cons ':str (str msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'start_drive)))
  'start_drive-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'start_drive)))
  'start_drive-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'start_drive)))
  "Returns string type for a service object of type '<start_drive>"
  "comm_app/start_drive")