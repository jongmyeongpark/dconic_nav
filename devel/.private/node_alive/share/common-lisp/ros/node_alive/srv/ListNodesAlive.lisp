; Auto-generated. Do not edit!


(cl:in-package node_alive-srv)


;//! \htmlinclude ListNodesAlive-request.msg.html

(cl:defclass <ListNodesAlive-request> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass ListNodesAlive-request (<ListNodesAlive-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ListNodesAlive-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ListNodesAlive-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name node_alive-srv:<ListNodesAlive-request> is deprecated: use node_alive-srv:ListNodesAlive-request instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ListNodesAlive-request>) ostream)
  "Serializes a message object of type '<ListNodesAlive-request>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ListNodesAlive-request>) istream)
  "Deserializes a message object of type '<ListNodesAlive-request>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ListNodesAlive-request>)))
  "Returns string type for a service object of type '<ListNodesAlive-request>"
  "node_alive/ListNodesAliveRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListNodesAlive-request)))
  "Returns string type for a service object of type 'ListNodesAlive-request"
  "node_alive/ListNodesAliveRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ListNodesAlive-request>)))
  "Returns md5sum for a message object of type '<ListNodesAlive-request>"
  "206cbe3e6af816a2d654986b53d52287")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ListNodesAlive-request)))
  "Returns md5sum for a message object of type 'ListNodesAlive-request"
  "206cbe3e6af816a2d654986b53d52287")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ListNodesAlive-request>)))
  "Returns full string definition for message of type '<ListNodesAlive-request>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ListNodesAlive-request)))
  "Returns full string definition for message of type 'ListNodesAlive-request"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ListNodesAlive-request>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ListNodesAlive-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ListNodesAlive-request
))
;//! \htmlinclude ListNodesAlive-response.msg.html

(cl:defclass <ListNodesAlive-response> (roslisp-msg-protocol:ros-message)
  ((tracked_nodes
    :reader tracked_nodes
    :initarg :tracked_nodes
    :type cl:integer
    :initform 0)
   (seen_nodes
    :reader seen_nodes
    :initarg :seen_nodes
    :type cl:integer
    :initform 0)
   (alive_nodes
    :reader alive_nodes
    :initarg :alive_nodes
    :type cl:integer
    :initform 0)
   (listed_nodes
    :reader listed_nodes
    :initarg :listed_nodes
    :type cl:integer
    :initform 0))
)

(cl:defclass ListNodesAlive-response (<ListNodesAlive-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ListNodesAlive-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ListNodesAlive-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name node_alive-srv:<ListNodesAlive-response> is deprecated: use node_alive-srv:ListNodesAlive-response instead.")))

(cl:ensure-generic-function 'tracked_nodes-val :lambda-list '(m))
(cl:defmethod tracked_nodes-val ((m <ListNodesAlive-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader node_alive-srv:tracked_nodes-val is deprecated.  Use node_alive-srv:tracked_nodes instead.")
  (tracked_nodes m))

(cl:ensure-generic-function 'seen_nodes-val :lambda-list '(m))
(cl:defmethod seen_nodes-val ((m <ListNodesAlive-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader node_alive-srv:seen_nodes-val is deprecated.  Use node_alive-srv:seen_nodes instead.")
  (seen_nodes m))

(cl:ensure-generic-function 'alive_nodes-val :lambda-list '(m))
(cl:defmethod alive_nodes-val ((m <ListNodesAlive-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader node_alive-srv:alive_nodes-val is deprecated.  Use node_alive-srv:alive_nodes instead.")
  (alive_nodes m))

(cl:ensure-generic-function 'listed_nodes-val :lambda-list '(m))
(cl:defmethod listed_nodes-val ((m <ListNodesAlive-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader node_alive-srv:listed_nodes-val is deprecated.  Use node_alive-srv:listed_nodes instead.")
  (listed_nodes m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ListNodesAlive-response>) ostream)
  "Serializes a message object of type '<ListNodesAlive-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'tracked_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'tracked_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'tracked_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'tracked_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'seen_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'seen_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'seen_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'seen_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'alive_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'alive_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'alive_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'alive_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'listed_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'listed_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'listed_nodes)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'listed_nodes)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ListNodesAlive-response>) istream)
  "Deserializes a message object of type '<ListNodesAlive-response>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'tracked_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'tracked_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'tracked_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'tracked_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'seen_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'seen_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'seen_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'seen_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'alive_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'alive_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'alive_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'alive_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'listed_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'listed_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) (cl:slot-value msg 'listed_nodes)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) (cl:slot-value msg 'listed_nodes)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ListNodesAlive-response>)))
  "Returns string type for a service object of type '<ListNodesAlive-response>"
  "node_alive/ListNodesAliveResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListNodesAlive-response)))
  "Returns string type for a service object of type 'ListNodesAlive-response"
  "node_alive/ListNodesAliveResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ListNodesAlive-response>)))
  "Returns md5sum for a message object of type '<ListNodesAlive-response>"
  "206cbe3e6af816a2d654986b53d52287")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ListNodesAlive-response)))
  "Returns md5sum for a message object of type 'ListNodesAlive-response"
  "206cbe3e6af816a2d654986b53d52287")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ListNodesAlive-response>)))
  "Returns full string definition for message of type '<ListNodesAlive-response>"
  (cl:format cl:nil "uint32 tracked_nodes~%uint32 seen_nodes~%uint32 alive_nodes~%uint32 listed_nodes~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ListNodesAlive-response)))
  "Returns full string definition for message of type 'ListNodesAlive-response"
  (cl:format cl:nil "uint32 tracked_nodes~%uint32 seen_nodes~%uint32 alive_nodes~%uint32 listed_nodes~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ListNodesAlive-response>))
  (cl:+ 0
     4
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ListNodesAlive-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ListNodesAlive-response
    (cl:cons ':tracked_nodes (tracked_nodes msg))
    (cl:cons ':seen_nodes (seen_nodes msg))
    (cl:cons ':alive_nodes (alive_nodes msg))
    (cl:cons ':listed_nodes (listed_nodes msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ListNodesAlive)))
  'ListNodesAlive-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ListNodesAlive)))
  'ListNodesAlive-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ListNodesAlive)))
  "Returns string type for a service object of type '<ListNodesAlive>"
  "node_alive/ListNodesAlive")