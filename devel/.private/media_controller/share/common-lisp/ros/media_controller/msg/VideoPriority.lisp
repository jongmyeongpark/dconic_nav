; Auto-generated. Do not edit!


(cl:in-package media_controller-msg)


;//! \htmlinclude VideoPriority.msg.html

(cl:defclass <VideoPriority> (roslisp-msg-protocol:ros-message)
  ((videoPriority
    :reader videoPriority
    :initarg :videoPriority
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass VideoPriority (<VideoPriority>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VideoPriority>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VideoPriority)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name media_controller-msg:<VideoPriority> is deprecated: use media_controller-msg:VideoPriority instead.")))

(cl:ensure-generic-function 'videoPriority-val :lambda-list '(m))
(cl:defmethod videoPriority-val ((m <VideoPriority>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader media_controller-msg:videoPriority-val is deprecated.  Use media_controller-msg:videoPriority instead.")
  (videoPriority m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VideoPriority>) ostream)
  "Serializes a message object of type '<VideoPriority>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'videoPriority))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) ele) ostream))
   (cl:slot-value msg 'videoPriority))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VideoPriority>) istream)
  "Deserializes a message object of type '<VideoPriority>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'videoPriority) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'videoPriority)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VideoPriority>)))
  "Returns string type for a message object of type '<VideoPriority>"
  "media_controller/VideoPriority")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VideoPriority)))
  "Returns string type for a message object of type 'VideoPriority"
  "media_controller/VideoPriority")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VideoPriority>)))
  "Returns md5sum for a message object of type '<VideoPriority>"
  "2d9b44b37b25759f764816c03dd5c4ee")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VideoPriority)))
  "Returns md5sum for a message object of type 'VideoPriority"
  "2d9b44b37b25759f764816c03dd5c4ee")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VideoPriority>)))
  "Returns full string definition for message of type '<VideoPriority>"
  (cl:format cl:nil "uint32[] videoPriority~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VideoPriority)))
  "Returns full string definition for message of type 'VideoPriority"
  (cl:format cl:nil "uint32[] videoPriority~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VideoPriority>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'videoPriority) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VideoPriority>))
  "Converts a ROS message object to a list"
  (cl:list 'VideoPriority
    (cl:cons ':videoPriority (videoPriority msg))
))
