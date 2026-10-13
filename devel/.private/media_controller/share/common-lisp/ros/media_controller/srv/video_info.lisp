; Auto-generated. Do not edit!


(cl:in-package media_controller-srv)


;//! \htmlinclude video_info-request.msg.html

(cl:defclass <video_info-request> (roslisp-msg-protocol:ros-message)
  ((rq
    :reader rq
    :initarg :rq
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass video_info-request (<video_info-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <video_info-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'video_info-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name media_controller-srv:<video_info-request> is deprecated: use media_controller-srv:video_info-request instead.")))

(cl:ensure-generic-function 'rq-val :lambda-list '(m))
(cl:defmethod rq-val ((m <video_info-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader media_controller-srv:rq-val is deprecated.  Use media_controller-srv:rq instead.")
  (rq m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <video_info-request>) ostream)
  "Serializes a message object of type '<video_info-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'rq) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <video_info-request>) istream)
  "Deserializes a message object of type '<video_info-request>"
    (cl:setf (cl:slot-value msg 'rq) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<video_info-request>)))
  "Returns string type for a service object of type '<video_info-request>"
  "media_controller/video_infoRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'video_info-request)))
  "Returns string type for a service object of type 'video_info-request"
  "media_controller/video_infoRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<video_info-request>)))
  "Returns md5sum for a message object of type '<video_info-request>"
  "c9046fbcc43b98494792b0b94103fa5f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'video_info-request)))
  "Returns md5sum for a message object of type 'video_info-request"
  "c9046fbcc43b98494792b0b94103fa5f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<video_info-request>)))
  "Returns full string definition for message of type '<video_info-request>"
  (cl:format cl:nil "# Request video info~%bool rq~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'video_info-request)))
  "Returns full string definition for message of type 'video_info-request"
  (cl:format cl:nil "# Request video info~%bool rq~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <video_info-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <video_info-request>))
  "Converts a ROS message object to a list"
  (cl:list 'video_info-request
    (cl:cons ':rq (rq msg))
))
;//! \htmlinclude video_info-response.msg.html

(cl:defclass <video_info-response> (roslisp-msg-protocol:ros-message)
  ((videoLength
    :reader videoLength
    :initarg :videoLength
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0))
   (videoPriority
    :reader videoPriority
    :initarg :videoPriority
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0)))
)

(cl:defclass video_info-response (<video_info-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <video_info-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'video_info-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name media_controller-srv:<video_info-response> is deprecated: use media_controller-srv:video_info-response instead.")))

(cl:ensure-generic-function 'videoLength-val :lambda-list '(m))
(cl:defmethod videoLength-val ((m <video_info-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader media_controller-srv:videoLength-val is deprecated.  Use media_controller-srv:videoLength instead.")
  (videoLength m))

(cl:ensure-generic-function 'videoPriority-val :lambda-list '(m))
(cl:defmethod videoPriority-val ((m <video_info-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader media_controller-srv:videoPriority-val is deprecated.  Use media_controller-srv:videoPriority instead.")
  (videoPriority m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <video_info-response>) ostream)
  "Serializes a message object of type '<video_info-response>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'videoLength))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    ))
   (cl:slot-value msg 'videoLength))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'videoPriority))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let* ((signed ele) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    ))
   (cl:slot-value msg 'videoPriority))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <video_info-response>) istream)
  "Deserializes a message object of type '<video_info-response>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'videoLength) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'videoLength)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536)))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'videoPriority) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'videoPriority)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:aref vals i) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536)))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<video_info-response>)))
  "Returns string type for a service object of type '<video_info-response>"
  "media_controller/video_infoResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'video_info-response)))
  "Returns string type for a service object of type 'video_info-response"
  "media_controller/video_infoResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<video_info-response>)))
  "Returns md5sum for a message object of type '<video_info-response>"
  "c9046fbcc43b98494792b0b94103fa5f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'video_info-response)))
  "Returns md5sum for a message object of type 'video_info-response"
  "c9046fbcc43b98494792b0b94103fa5f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<video_info-response>)))
  "Returns full string definition for message of type '<video_info-response>"
  (cl:format cl:nil "int16[] videoLength~%int16[] videoPriority~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'video_info-response)))
  "Returns full string definition for message of type 'video_info-response"
  (cl:format cl:nil "int16[] videoLength~%int16[] videoPriority~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <video_info-response>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'videoLength) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 2)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'videoPriority) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 2)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <video_info-response>))
  "Converts a ROS message object to a list"
  (cl:list 'video_info-response
    (cl:cons ':videoLength (videoLength msg))
    (cl:cons ':videoPriority (videoPriority msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'video_info)))
  'video_info-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'video_info)))
  'video_info-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'video_info)))
  "Returns string type for a service object of type '<video_info>"
  "media_controller/video_info")