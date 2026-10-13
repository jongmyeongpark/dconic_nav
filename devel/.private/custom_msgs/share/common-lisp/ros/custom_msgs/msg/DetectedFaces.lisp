; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude DetectedFaces.msg.html

(cl:defclass <DetectedFaces> (roslisp-msg-protocol:ros-message)
  ((faces
    :reader faces
    :initarg :faces
    :type (cl:vector custom_msgs-msg:FaceInfo)
   :initform (cl:make-array 0 :element-type 'custom_msgs-msg:FaceInfo :initial-element (cl:make-instance 'custom_msgs-msg:FaceInfo)))
   (width
    :reader width
    :initarg :width
    :type cl:integer
    :initform 0)
   (height
    :reader height
    :initarg :height
    :type cl:integer
    :initform 0))
)

(cl:defclass DetectedFaces (<DetectedFaces>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <DetectedFaces>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'DetectedFaces)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<DetectedFaces> is deprecated: use custom_msgs-msg:DetectedFaces instead.")))

(cl:ensure-generic-function 'faces-val :lambda-list '(m))
(cl:defmethod faces-val ((m <DetectedFaces>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:faces-val is deprecated.  Use custom_msgs-msg:faces instead.")
  (faces m))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <DetectedFaces>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:width-val is deprecated.  Use custom_msgs-msg:width instead.")
  (width m))

(cl:ensure-generic-function 'height-val :lambda-list '(m))
(cl:defmethod height-val ((m <DetectedFaces>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:height-val is deprecated.  Use custom_msgs-msg:height instead.")
  (height m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <DetectedFaces>) ostream)
  "Serializes a message object of type '<DetectedFaces>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'faces))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'faces))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'width)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'width)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'width)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'width)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'height)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'height)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'height)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'height)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <DetectedFaces>) istream)
  "Deserializes a message object of type '<DetectedFaces>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'faces) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'faces)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'custom_msgs-msg:FaceInfo))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'width)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'width)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'width)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'width)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'height)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'height)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'height)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'height)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<DetectedFaces>)))
  "Returns string type for a message object of type '<DetectedFaces>"
  "custom_msgs/DetectedFaces")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'DetectedFaces)))
  "Returns string type for a message object of type 'DetectedFaces"
  "custom_msgs/DetectedFaces")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<DetectedFaces>)))
  "Returns md5sum for a message object of type '<DetectedFaces>"
  "e3284fee8873073e7cae331fc96b9457")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'DetectedFaces)))
  "Returns md5sum for a message object of type 'DetectedFaces"
  "e3284fee8873073e7cae331fc96b9457")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<DetectedFaces>)))
  "Returns full string definition for message of type '<DetectedFaces>"
  (cl:format cl:nil "custom_msgs/FaceInfo[] faces~%uint32 width~%uint32 height~%================================================================================~%MSG: custom_msgs/FaceInfo~%int32 id~%int32 x~%int32 y~%int32 radius~%int32 height~%int32 width~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'DetectedFaces)))
  "Returns full string definition for message of type 'DetectedFaces"
  (cl:format cl:nil "custom_msgs/FaceInfo[] faces~%uint32 width~%uint32 height~%================================================================================~%MSG: custom_msgs/FaceInfo~%int32 id~%int32 x~%int32 y~%int32 radius~%int32 height~%int32 width~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <DetectedFaces>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'faces) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <DetectedFaces>))
  "Converts a ROS message object to a list"
  (cl:list 'DetectedFaces
    (cl:cons ':faces (faces msg))
    (cl:cons ':width (width msg))
    (cl:cons ':height (height msg))
))
