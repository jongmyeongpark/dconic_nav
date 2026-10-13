; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude Transition.msg.html

(cl:defclass <Transition> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (in
    :reader in
    :initarg :in
    :type custom_msgs-msg:State
    :initform (cl:make-instance 'custom_msgs-msg:State))
   (out
    :reader out
    :initarg :out
    :type custom_msgs-msg:State
    :initform (cl:make-instance 'custom_msgs-msg:State)))
)

(cl:defclass Transition (<Transition>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Transition>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Transition)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<Transition> is deprecated: use custom_msgs-msg:Transition instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <Transition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:name-val is deprecated.  Use custom_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'in-val :lambda-list '(m))
(cl:defmethod in-val ((m <Transition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:in-val is deprecated.  Use custom_msgs-msg:in instead.")
  (in m))

(cl:ensure-generic-function 'out-val :lambda-list '(m))
(cl:defmethod out-val ((m <Transition>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:out-val is deprecated.  Use custom_msgs-msg:out instead.")
  (out m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Transition>) ostream)
  "Serializes a message object of type '<Transition>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'in) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'out) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Transition>) istream)
  "Deserializes a message object of type '<Transition>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'in) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'out) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Transition>)))
  "Returns string type for a message object of type '<Transition>"
  "custom_msgs/Transition")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Transition)))
  "Returns string type for a message object of type 'Transition"
  "custom_msgs/Transition")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Transition>)))
  "Returns md5sum for a message object of type '<Transition>"
  "e8262dc49d6d86b1edcd11009f8370e8")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Transition)))
  "Returns md5sum for a message object of type 'Transition"
  "e8262dc49d6d86b1edcd11009f8370e8")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Transition>)))
  "Returns full string definition for message of type '<Transition>"
  (cl:format cl:nil "string name~%State in~%State out~%================================================================================~%MSG: custom_msgs/State~%string name~%string progress~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Transition)))
  "Returns full string definition for message of type 'Transition"
  (cl:format cl:nil "string name~%State in~%State out~%================================================================================~%MSG: custom_msgs/State~%string name~%string progress~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Transition>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'in))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'out))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Transition>))
  "Converts a ROS message object to a list"
  (cl:list 'Transition
    (cl:cons ':name (name msg))
    (cl:cons ':in (in msg))
    (cl:cons ':out (out msg))
))
