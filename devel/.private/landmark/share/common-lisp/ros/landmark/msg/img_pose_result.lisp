; Auto-generated. Do not edit!


(cl:in-package landmark-msg)


;//! \htmlinclude img_pose_result.msg.html

(cl:defclass <img_pose_result> (roslisp-msg-protocol:ros-message)
  ((stamp
    :reader stamp
    :initarg :stamp
    :type cl:real
    :initform 0)
   (sim_id
    :reader sim_id
    :initarg :sim_id
    :type cl:integer
    :initform 0)
   (score
    :reader score
    :initarg :score
    :type cl:float
    :initform 0.0)
   (amclPose
    :reader amclPose
    :initarg :amclPose
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (visionPose
    :reader visionPose
    :initarg :visionPose
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (diff_xy
    :reader diff_xy
    :initarg :diff_xy
    :type cl:float
    :initform 0.0)
   (diff_rotate
    :reader diff_rotate
    :initarg :diff_rotate
    :type cl:float
    :initform 0.0)
   (valid_status
    :reader valid_status
    :initarg :valid_status
    :type cl:boolean
    :initform cl:nil)
   (mismatch_status
    :reader mismatch_status
    :initarg :mismatch_status
    :type cl:boolean
    :initform cl:nil)
   (unjudge_status
    :reader unjudge_status
    :initarg :unjudge_status
    :type cl:boolean
    :initform cl:nil)
   (relocal_status
    :reader relocal_status
    :initarg :relocal_status
    :type cl:fixnum
    :initform 0))
)

(cl:defclass img_pose_result (<img_pose_result>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <img_pose_result>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'img_pose_result)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name landmark-msg:<img_pose_result> is deprecated: use landmark-msg:img_pose_result instead.")))

(cl:ensure-generic-function 'stamp-val :lambda-list '(m))
(cl:defmethod stamp-val ((m <img_pose_result>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:stamp-val is deprecated.  Use landmark-msg:stamp instead.")
  (stamp m))

(cl:ensure-generic-function 'sim_id-val :lambda-list '(m))
(cl:defmethod sim_id-val ((m <img_pose_result>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:sim_id-val is deprecated.  Use landmark-msg:sim_id instead.")
  (sim_id m))

(cl:ensure-generic-function 'score-val :lambda-list '(m))
(cl:defmethod score-val ((m <img_pose_result>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:score-val is deprecated.  Use landmark-msg:score instead.")
  (score m))

(cl:ensure-generic-function 'amclPose-val :lambda-list '(m))
(cl:defmethod amclPose-val ((m <img_pose_result>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:amclPose-val is deprecated.  Use landmark-msg:amclPose instead.")
  (amclPose m))

(cl:ensure-generic-function 'visionPose-val :lambda-list '(m))
(cl:defmethod visionPose-val ((m <img_pose_result>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:visionPose-val is deprecated.  Use landmark-msg:visionPose instead.")
  (visionPose m))

(cl:ensure-generic-function 'diff_xy-val :lambda-list '(m))
(cl:defmethod diff_xy-val ((m <img_pose_result>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:diff_xy-val is deprecated.  Use landmark-msg:diff_xy instead.")
  (diff_xy m))

(cl:ensure-generic-function 'diff_rotate-val :lambda-list '(m))
(cl:defmethod diff_rotate-val ((m <img_pose_result>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:diff_rotate-val is deprecated.  Use landmark-msg:diff_rotate instead.")
  (diff_rotate m))

(cl:ensure-generic-function 'valid_status-val :lambda-list '(m))
(cl:defmethod valid_status-val ((m <img_pose_result>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:valid_status-val is deprecated.  Use landmark-msg:valid_status instead.")
  (valid_status m))

(cl:ensure-generic-function 'mismatch_status-val :lambda-list '(m))
(cl:defmethod mismatch_status-val ((m <img_pose_result>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:mismatch_status-val is deprecated.  Use landmark-msg:mismatch_status instead.")
  (mismatch_status m))

(cl:ensure-generic-function 'unjudge_status-val :lambda-list '(m))
(cl:defmethod unjudge_status-val ((m <img_pose_result>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:unjudge_status-val is deprecated.  Use landmark-msg:unjudge_status instead.")
  (unjudge_status m))

(cl:ensure-generic-function 'relocal_status-val :lambda-list '(m))
(cl:defmethod relocal_status-val ((m <img_pose_result>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:relocal_status-val is deprecated.  Use landmark-msg:relocal_status instead.")
  (relocal_status m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <img_pose_result>) ostream)
  "Serializes a message object of type '<img_pose_result>"
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'stamp)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'stamp) (cl:floor (cl:slot-value msg 'stamp)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:let* ((signed (cl:slot-value msg 'sim_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'amclPose))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'amclPose))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'visionPose))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'visionPose))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'diff_xy))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'diff_rotate))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'valid_status) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'mismatch_status) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'unjudge_status) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'relocal_status)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <img_pose_result>) istream)
  "Deserializes a message object of type '<img_pose_result>"
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'stamp) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sim_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'score) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'amclPose) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'amclPose)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'visionPose) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'visionPose)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-single-float-bits bits))))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'diff_xy) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'diff_rotate) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'valid_status) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'mismatch_status) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'unjudge_status) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'relocal_status) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<img_pose_result>)))
  "Returns string type for a message object of type '<img_pose_result>"
  "landmark/img_pose_result")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'img_pose_result)))
  "Returns string type for a message object of type 'img_pose_result"
  "landmark/img_pose_result")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<img_pose_result>)))
  "Returns md5sum for a message object of type '<img_pose_result>"
  "4c390e3b380adc5fc1a15fddc1d5517a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'img_pose_result)))
  "Returns md5sum for a message object of type 'img_pose_result"
  "4c390e3b380adc5fc1a15fddc1d5517a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<img_pose_result>)))
  "Returns full string definition for message of type '<img_pose_result>"
  (cl:format cl:nil "time stamp~%int32 sim_id~%float32 score~%float32[] amclPose~%float32[] visionPose~%float32 diff_xy~%float32 diff_rotate~%bool valid_status~%bool mismatch_status~%bool unjudge_status~%int8 relocal_status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'img_pose_result)))
  "Returns full string definition for message of type 'img_pose_result"
  (cl:format cl:nil "time stamp~%int32 sim_id~%float32 score~%float32[] amclPose~%float32[] visionPose~%float32 diff_xy~%float32 diff_rotate~%bool valid_status~%bool mismatch_status~%bool unjudge_status~%int8 relocal_status~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <img_pose_result>))
  (cl:+ 0
     8
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'amclPose) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'visionPose) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <img_pose_result>))
  "Converts a ROS message object to a list"
  (cl:list 'img_pose_result
    (cl:cons ':stamp (stamp msg))
    (cl:cons ':sim_id (sim_id msg))
    (cl:cons ':score (score msg))
    (cl:cons ':amclPose (amclPose msg))
    (cl:cons ':visionPose (visionPose msg))
    (cl:cons ':diff_xy (diff_xy msg))
    (cl:cons ':diff_rotate (diff_rotate msg))
    (cl:cons ':valid_status (valid_status msg))
    (cl:cons ':mismatch_status (mismatch_status msg))
    (cl:cons ':unjudge_status (unjudge_status msg))
    (cl:cons ':relocal_status (relocal_status msg))
))
