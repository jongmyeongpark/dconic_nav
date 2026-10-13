; Auto-generated. Do not edit!


(cl:in-package media_controller-msg)


;//! \htmlinclude VideoLength.msg.html

(cl:defclass <VideoLength> (roslisp-msg-protocol:ros-message)
  ((videoLength
    :reader videoLength
    :initarg :videoLength
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass VideoLength (<VideoLength>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <VideoLength>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'VideoLength)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name media_controller-msg:<VideoLength> is deprecated: use media_controller-msg:VideoLength instead.")))

(cl:ensure-generic-function 'videoLength-val :lambda-list '(m))
(cl:defmethod videoLength-val ((m <VideoLength>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader media_controller-msg:videoLength-val is deprecated.  Use media_controller-msg:videoLength instead.")
  (videoLength m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <VideoLength>) ostream)
  "Serializes a message object of type '<VideoLength>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'videoLength))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) ele) ostream))
   (cl:slot-value msg 'videoLength))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <VideoLength>) istream)
  "Deserializes a message object of type '<VideoLength>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'videoLength) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'videoLength)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<VideoLength>)))
  "Returns string type for a message object of type '<VideoLength>"
  "media_controller/VideoLength")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'VideoLength)))
  "Returns string type for a message object of type 'VideoLength"
  "media_controller/VideoLength")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<VideoLength>)))
  "Returns md5sum for a message object of type '<VideoLength>"
  "42e2ca7a6872ea97a8d5f8554e713583")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'VideoLength)))
  "Returns md5sum for a message object of type 'VideoLength"
  "42e2ca7a6872ea97a8d5f8554e713583")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<VideoLength>)))
  "Returns full string definition for message of type '<VideoLength>"
  (cl:format cl:nil "uint32[] videoLength~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'VideoLength)))
  "Returns full string definition for message of type 'VideoLength"
  (cl:format cl:nil "uint32[] videoLength~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <VideoLength>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'videoLength) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <VideoLength>))
  "Converts a ROS message object to a list"
  (cl:list 'VideoLength
    (cl:cons ':videoLength (videoLength msg))
))
