; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude Form.msg.html

(cl:defclass <Form> (roslisp-msg-protocol:ros-message)
  ((form
    :reader form
    :initarg :form
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point))))
)

(cl:defclass Form (<Form>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Form>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Form)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<Form> is deprecated: use custom_msgs-msg:Form instead.")))

(cl:ensure-generic-function 'form-val :lambda-list '(m))
(cl:defmethod form-val ((m <Form>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:form-val is deprecated.  Use custom_msgs-msg:form instead.")
  (form m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Form>) ostream)
  "Serializes a message object of type '<Form>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'form))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'form))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Form>) istream)
  "Deserializes a message object of type '<Form>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'form) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'form)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Form>)))
  "Returns string type for a message object of type '<Form>"
  "custom_msgs/Form")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Form)))
  "Returns string type for a message object of type 'Form"
  "custom_msgs/Form")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Form>)))
  "Returns md5sum for a message object of type '<Form>"
  "46c4b2c357456de61f855d80140cd91b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Form)))
  "Returns md5sum for a message object of type 'Form"
  "46c4b2c357456de61f855d80140cd91b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Form>)))
  "Returns full string definition for message of type '<Form>"
  (cl:format cl:nil "geometry_msgs/Point[] form         ~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Form)))
  "Returns full string definition for message of type 'Form"
  (cl:format cl:nil "geometry_msgs/Point[] form         ~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Form>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'form) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Form>))
  "Converts a ROS message object to a list"
  (cl:list 'Form
    (cl:cons ':form (form msg))
))
