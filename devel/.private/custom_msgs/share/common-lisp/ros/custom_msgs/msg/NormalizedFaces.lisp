; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude NormalizedFaces.msg.html

(cl:defclass <NormalizedFaces> (roslisp-msg-protocol:ros-message)
  ((points
    :reader points
    :initarg :points
    :type (cl:vector geometry_msgs-msg:Point)
   :initform (cl:make-array 0 :element-type 'geometry_msgs-msg:Point :initial-element (cl:make-instance 'geometry_msgs-msg:Point)))
   (orientations
    :reader orientations
    :initarg :orientations
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass NormalizedFaces (<NormalizedFaces>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <NormalizedFaces>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'NormalizedFaces)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<NormalizedFaces> is deprecated: use custom_msgs-msg:NormalizedFaces instead.")))

(cl:ensure-generic-function 'points-val :lambda-list '(m))
(cl:defmethod points-val ((m <NormalizedFaces>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:points-val is deprecated.  Use custom_msgs-msg:points instead.")
  (points m))

(cl:ensure-generic-function 'orientations-val :lambda-list '(m))
(cl:defmethod orientations-val ((m <NormalizedFaces>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:orientations-val is deprecated.  Use custom_msgs-msg:orientations instead.")
  (orientations m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <NormalizedFaces>) ostream)
  "Serializes a message object of type '<NormalizedFaces>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'points))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'points))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'orientations))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'orientations))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <NormalizedFaces>) istream)
  "Deserializes a message object of type '<NormalizedFaces>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'points) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'points)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'geometry_msgs-msg:Point))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'orientations) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'orientations)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<NormalizedFaces>)))
  "Returns string type for a message object of type '<NormalizedFaces>"
  "custom_msgs/NormalizedFaces")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'NormalizedFaces)))
  "Returns string type for a message object of type 'NormalizedFaces"
  "custom_msgs/NormalizedFaces")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<NormalizedFaces>)))
  "Returns md5sum for a message object of type '<NormalizedFaces>"
  "1576812d6c1eace4d46c75520392857f")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'NormalizedFaces)))
  "Returns md5sum for a message object of type 'NormalizedFaces"
  "1576812d6c1eace4d46c75520392857f")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<NormalizedFaces>)))
  "Returns full string definition for message of type '<NormalizedFaces>"
  (cl:format cl:nil "geometry_msgs/Point[] points~%float32[] orientations~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'NormalizedFaces)))
  "Returns full string definition for message of type 'NormalizedFaces"
  (cl:format cl:nil "geometry_msgs/Point[] points~%float32[] orientations~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <NormalizedFaces>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'points) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'orientations) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <NormalizedFaces>))
  "Converts a ROS message object to a list"
  (cl:list 'NormalizedFaces
    (cl:cons ':points (points msg))
    (cl:cons ':orientations (orientations msg))
))
