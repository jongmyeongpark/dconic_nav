; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude Zone.msg.html

(cl:defclass <Zone> (roslisp-msg-protocol:ros-message)
  ((area
    :reader area
    :initarg :area
    :type custom_msgs-msg:Form
    :initform (cl:make-instance 'custom_msgs-msg:Form)))
)

(cl:defclass Zone (<Zone>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Zone>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Zone)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<Zone> is deprecated: use custom_msgs-msg:Zone instead.")))

(cl:ensure-generic-function 'area-val :lambda-list '(m))
(cl:defmethod area-val ((m <Zone>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:area-val is deprecated.  Use custom_msgs-msg:area instead.")
  (area m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Zone>) ostream)
  "Serializes a message object of type '<Zone>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'area) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Zone>) istream)
  "Deserializes a message object of type '<Zone>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'area) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Zone>)))
  "Returns string type for a message object of type '<Zone>"
  "custom_msgs/Zone")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Zone)))
  "Returns string type for a message object of type 'Zone"
  "custom_msgs/Zone")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Zone>)))
  "Returns md5sum for a message object of type '<Zone>"
  "033c166c5de606dccad7a8a825be6a5d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Zone)))
  "Returns md5sum for a message object of type 'Zone"
  "033c166c5de606dccad7a8a825be6a5d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Zone>)))
  "Returns full string definition for message of type '<Zone>"
  (cl:format cl:nil "custom_msgs/Form area         ~%~%================================================================================~%MSG: custom_msgs/Form~%geometry_msgs/Point[] form         ~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Zone)))
  "Returns full string definition for message of type 'Zone"
  (cl:format cl:nil "custom_msgs/Form area         ~%~%================================================================================~%MSG: custom_msgs/Form~%geometry_msgs/Point[] form         ~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Zone>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'area))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Zone>))
  "Converts a ROS message object to a list"
  (cl:list 'Zone
    (cl:cons ':area (area msg))
))
