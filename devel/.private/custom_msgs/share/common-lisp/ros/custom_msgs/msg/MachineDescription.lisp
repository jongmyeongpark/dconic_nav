; Auto-generated. Do not edit!


(cl:in-package custom_msgs-msg)


;//! \htmlinclude MachineDescription.msg.html

(cl:defclass <MachineDescription> (roslisp-msg-protocol:ros-message)
  ((name
    :reader name
    :initarg :name
    :type cl:string
    :initform "")
   (states
    :reader states
    :initarg :states
    :type (cl:vector custom_msgs-msg:State)
   :initform (cl:make-array 0 :element-type 'custom_msgs-msg:State :initial-element (cl:make-instance 'custom_msgs-msg:State)))
   (transitions
    :reader transitions
    :initarg :transitions
    :type (cl:vector custom_msgs-msg:Transition)
   :initform (cl:make-array 0 :element-type 'custom_msgs-msg:Transition :initial-element (cl:make-instance 'custom_msgs-msg:Transition))))
)

(cl:defclass MachineDescription (<MachineDescription>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <MachineDescription>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'MachineDescription)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name custom_msgs-msg:<MachineDescription> is deprecated: use custom_msgs-msg:MachineDescription instead.")))

(cl:ensure-generic-function 'name-val :lambda-list '(m))
(cl:defmethod name-val ((m <MachineDescription>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:name-val is deprecated.  Use custom_msgs-msg:name instead.")
  (name m))

(cl:ensure-generic-function 'states-val :lambda-list '(m))
(cl:defmethod states-val ((m <MachineDescription>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:states-val is deprecated.  Use custom_msgs-msg:states instead.")
  (states m))

(cl:ensure-generic-function 'transitions-val :lambda-list '(m))
(cl:defmethod transitions-val ((m <MachineDescription>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader custom_msgs-msg:transitions-val is deprecated.  Use custom_msgs-msg:transitions instead.")
  (transitions m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <MachineDescription>) ostream)
  "Serializes a message object of type '<MachineDescription>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'name))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'states))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'states))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'transitions))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'transitions))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <MachineDescription>) istream)
  "Deserializes a message object of type '<MachineDescription>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'states) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'states)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'custom_msgs-msg:State))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'transitions) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'transitions)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'custom_msgs-msg:Transition))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<MachineDescription>)))
  "Returns string type for a message object of type '<MachineDescription>"
  "custom_msgs/MachineDescription")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'MachineDescription)))
  "Returns string type for a message object of type 'MachineDescription"
  "custom_msgs/MachineDescription")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<MachineDescription>)))
  "Returns md5sum for a message object of type '<MachineDescription>"
  "0aadf3ce88e651d129124e468424db9d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'MachineDescription)))
  "Returns md5sum for a message object of type 'MachineDescription"
  "0aadf3ce88e651d129124e468424db9d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<MachineDescription>)))
  "Returns full string definition for message of type '<MachineDescription>"
  (cl:format cl:nil "string name~%State[] states~%Transition[] transitions~%================================================================================~%MSG: custom_msgs/State~%string name~%string progress~%================================================================================~%MSG: custom_msgs/Transition~%string name~%State in~%State out~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'MachineDescription)))
  "Returns full string definition for message of type 'MachineDescription"
  (cl:format cl:nil "string name~%State[] states~%Transition[] transitions~%================================================================================~%MSG: custom_msgs/State~%string name~%string progress~%================================================================================~%MSG: custom_msgs/Transition~%string name~%State in~%State out~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <MachineDescription>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'name))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'states) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'transitions) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <MachineDescription>))
  "Converts a ROS message object to a list"
  (cl:list 'MachineDescription
    (cl:cons ':name (name msg))
    (cl:cons ':states (states msg))
    (cl:cons ':transitions (transitions msg))
))
