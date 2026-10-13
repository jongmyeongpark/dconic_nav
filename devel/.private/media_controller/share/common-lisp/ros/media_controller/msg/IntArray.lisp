; Auto-generated. Do not edit!


(cl:in-package media_controller-msg)


;//! \htmlinclude IntArray.msg.html

(cl:defclass <IntArray> (roslisp-msg-protocol:ros-message)
  ((intArray
    :reader intArray
    :initarg :intArray
    :type (cl:vector cl:integer)
   :initform (cl:make-array 0 :element-type 'cl:integer :initial-element 0)))
)

(cl:defclass IntArray (<IntArray>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <IntArray>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'IntArray)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name media_controller-msg:<IntArray> is deprecated: use media_controller-msg:IntArray instead.")))

(cl:ensure-generic-function 'intArray-val :lambda-list '(m))
(cl:defmethod intArray-val ((m <IntArray>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader media_controller-msg:intArray-val is deprecated.  Use media_controller-msg:intArray instead.")
  (intArray m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <IntArray>) ostream)
  "Serializes a message object of type '<IntArray>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'intArray))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:write-byte (cl:ldb (cl:byte 8 0) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) ele) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) ele) ostream))
   (cl:slot-value msg 'intArray))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <IntArray>) istream)
  "Deserializes a message object of type '<IntArray>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'intArray) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'intArray)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:aref vals i)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:aref vals i)) (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<IntArray>)))
  "Returns string type for a message object of type '<IntArray>"
  "media_controller/IntArray")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'IntArray)))
  "Returns string type for a message object of type 'IntArray"
  "media_controller/IntArray")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<IntArray>)))
  "Returns md5sum for a message object of type '<IntArray>"
  "76f7d7f74f2e8dcdd4ba703281016923")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'IntArray)))
  "Returns md5sum for a message object of type 'IntArray"
  "76f7d7f74f2e8dcdd4ba703281016923")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<IntArray>)))
  "Returns full string definition for message of type '<IntArray>"
  (cl:format cl:nil "uint32[] intArray~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'IntArray)))
  "Returns full string definition for message of type 'IntArray"
  (cl:format cl:nil "uint32[] intArray~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <IntArray>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'intArray) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <IntArray>))
  "Converts a ROS message object to a list"
  (cl:list 'IntArray
    (cl:cons ':intArray (intArray msg))
))
