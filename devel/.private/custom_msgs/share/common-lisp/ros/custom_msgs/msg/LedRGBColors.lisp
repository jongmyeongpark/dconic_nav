; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude LedRGBColors.msg.html

(cl:defclass <LedRGBColors> (roslisp-msg-protocol:ros-message)
  ((values
    :reader values
    :initarg :values
    :type (cl:vector cl:fixnum)
   :initform (cl:make-array 0 :element-type 'cl:fixnum :initial-element 0))
   (color
    :reader color
    :initarg :color
    :type cl:fixnum
    :initform 0))
)

(cl:defclass LedRGBColors (<LedRGBColors>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LedRGBColors>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LedRGBColors)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<LedRGBColors> is deprecated: use custom_msgs-msg:LedRGBColors instead.")))

(cl:ensure-generic-function 'values-val :lambda-list '(m))
(cl:defmethod values-val ((m <LedRGBColors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:values-val is deprecated.  Use custom_msgs-msg:values instead.")
  (values m))

(cl:ensure-generic-function 'color-val :lambda-list '(m))
(cl:defmethod color-val ((m <LedRGBColors>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:color-val is deprecated.  Use custom_msgs-msg:color instead.")
  (color m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LedRGBColors>) ostream)
  "Serializes a message object of type '<LedRGBColors>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'values))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream))
   (cl:slot-value msg 'values))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'color)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LedRGBColors>) istream)
  "Deserializes a message object of type '<LedRGBColors>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'values) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'values)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream)))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'color)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LedRGBColors>)))
  "Returns string type for a message object of type '<LedRGBColors>"
  "custom_msgs/LedRGBColors")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LedRGBColors)))
  "Returns string type for a message object of type 'LedRGBColors"
  "custom_msgs/LedRGBColors")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LedRGBColors>)))
  "Returns md5sum for a message object of type '<LedRGBColors>"
  "2979289bf62edcae7300f6f9812c4e15")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LedRGBColors)))
  "Returns md5sum for a message object of type 'LedRGBColors"
  "2979289bf62edcae7300f6f9812c4e15")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LedRGBColors>)))
  "Returns full string definition for message of type '<LedRGBColors>"
  (cl:format cl:nil "uint8[] values~%uint8 color~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LedRGBColors)))
  "Returns full string definition for message of type 'LedRGBColors"
  (cl:format cl:nil "uint8[] values~%uint8 color~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LedRGBColors>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'values) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 1)))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LedRGBColors>))
  "Converts a ROS message object to a list"
  (cl:list 'LedRGBColors
    (cl:cons ':values (values msg))
    (cl:cons ':color (color msg))
))
