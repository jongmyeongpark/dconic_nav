; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude Leds.msg.html

(cl:defclass <Leds> (roslisp-msg-protocol:ros-message)
  ((colors
    :reader colors
    :initarg :colors
    :type (cl:vector custom_msgs-msg:ColorRGB)
   :initform (cl:make-array 0 :element-type 'custom_msgs-msg:ColorRGB :initial-element (cl:make-instance 'custom_msgs-msg:ColorRGB)))
   (color_code
    :reader color_code
    :initarg :color_code
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Leds (<Leds>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Leds>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Leds)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<Leds> is deprecated: use custom_msgs-msg:Leds instead.")))

(cl:ensure-generic-function 'colors-val :lambda-list '(m))
(cl:defmethod colors-val ((m <Leds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:colors-val is deprecated.  Use custom_msgs-msg:colors instead.")
  (colors m))

(cl:ensure-generic-function 'color_code-val :lambda-list '(m))
(cl:defmethod color_code-val ((m <Leds>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:color_code-val is deprecated.  Use custom_msgs-msg:color_code instead.")
  (color_code m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Leds>) ostream)
  "Serializes a message object of type '<Leds>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'colors))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'colors))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'color_code)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Leds>) istream)
  "Deserializes a message object of type '<Leds>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'colors) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'colors)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'custom_msgs-msg:ColorRGB))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'color_code)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Leds>)))
  "Returns string type for a message object of type '<Leds>"
  "custom_msgs/Leds")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Leds)))
  "Returns string type for a message object of type 'Leds"
  "custom_msgs/Leds")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Leds>)))
  "Returns md5sum for a message object of type '<Leds>"
  "5ff7e71a7764a4d0c3311bce28a43225")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Leds)))
  "Returns md5sum for a message object of type 'Leds"
  "5ff7e71a7764a4d0c3311bce28a43225")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Leds>)))
  "Returns full string definition for message of type '<Leds>"
  (cl:format cl:nil "custom_msgs/ColorRGB[] colors~%uint8 color_code~%================================================================================~%MSG: custom_msgs/ColorRGB~%uint8 r~%uint8 g~%uint8 b~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Leds)))
  "Returns full string definition for message of type 'Leds"
  (cl:format cl:nil "custom_msgs/ColorRGB[] colors~%uint8 color_code~%================================================================================~%MSG: custom_msgs/ColorRGB~%uint8 r~%uint8 g~%uint8 b~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Leds>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'colors) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Leds>))
  "Converts a ROS message object to a list"
  (cl:list 'Leds
    (cl:cons ':colors (colors msg))
    (cl:cons ':color_code (color_code msg))
))
