; Auto-generated. Do not edit!


(cl:in-package landmark-msg)


;//! \htmlinclude relocal.msg.html

(cl:defclass <relocal> (roslisp-msg-protocol:ros-message)
  ((count
    :reader count
    :initarg :count
    :type cl:integer
    :initform 0)
   (time_start
    :reader time_start
    :initarg :time_start
    :type cl:real
    :initform 0)
   (time_end
    :reader time_end
    :initarg :time_end
    :type cl:real
    :initform 0)
   (odom_reset
    :reader odom_reset
    :initarg :odom_reset
    :type cl:boolean
    :initform cl:nil)
   (visionPoseType
    :reader visionPoseType
    :initarg :visionPoseType
    :type cl:fixnum
    :initform 0)
   (count_repeat
    :reader count_repeat
    :initarg :count_repeat
    :type cl:fixnum
    :initform 0)
   (amclPose
    :reader amclPose
    :initarg :amclPose
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (initialPose
    :reader initialPose
    :initarg :initialPose
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
   (amclPose_relocal
    :reader amclPose_relocal
    :initarg :amclPose_relocal
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0))
   (diff_xy_relocal
    :reader diff_xy_relocal
    :initarg :diff_xy_relocal
    :type cl:float
    :initform 0.0)
   (diff_rotate_relocal
    :reader diff_rotate_relocal
    :initarg :diff_rotate_relocal
    :type cl:float
    :initform 0.0)
   (relocal_result
    :reader relocal_result
    :initarg :relocal_result
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass relocal (<relocal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <relocal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'relocal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name landmark-msg:<relocal> is deprecated: use landmark-msg:relocal instead.")))

(cl:ensure-generic-function 'count-val :lambda-list '(m))
(cl:defmethod count-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:count-val is deprecated.  Use landmark-msg:count instead.")
  (count m))

(cl:ensure-generic-function 'time_start-val :lambda-list '(m))
(cl:defmethod time_start-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:time_start-val is deprecated.  Use landmark-msg:time_start instead.")
  (time_start m))

(cl:ensure-generic-function 'time_end-val :lambda-list '(m))
(cl:defmethod time_end-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:time_end-val is deprecated.  Use landmark-msg:time_end instead.")
  (time_end m))

(cl:ensure-generic-function 'odom_reset-val :lambda-list '(m))
(cl:defmethod odom_reset-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:odom_reset-val is deprecated.  Use landmark-msg:odom_reset instead.")
  (odom_reset m))

(cl:ensure-generic-function 'visionPoseType-val :lambda-list '(m))
(cl:defmethod visionPoseType-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:visionPoseType-val is deprecated.  Use landmark-msg:visionPoseType instead.")
  (visionPoseType m))

(cl:ensure-generic-function 'count_repeat-val :lambda-list '(m))
(cl:defmethod count_repeat-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:count_repeat-val is deprecated.  Use landmark-msg:count_repeat instead.")
  (count_repeat m))

(cl:ensure-generic-function 'amclPose-val :lambda-list '(m))
(cl:defmethod amclPose-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:amclPose-val is deprecated.  Use landmark-msg:amclPose instead.")
  (amclPose m))

(cl:ensure-generic-function 'initialPose-val :lambda-list '(m))
(cl:defmethod initialPose-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:initialPose-val is deprecated.  Use landmark-msg:initialPose instead.")
  (initialPose m))

(cl:ensure-generic-function 'diff_xy-val :lambda-list '(m))
(cl:defmethod diff_xy-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:diff_xy-val is deprecated.  Use landmark-msg:diff_xy instead.")
  (diff_xy m))

(cl:ensure-generic-function 'diff_rotate-val :lambda-list '(m))
(cl:defmethod diff_rotate-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:diff_rotate-val is deprecated.  Use landmark-msg:diff_rotate instead.")
  (diff_rotate m))

(cl:ensure-generic-function 'amclPose_relocal-val :lambda-list '(m))
(cl:defmethod amclPose_relocal-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:amclPose_relocal-val is deprecated.  Use landmark-msg:amclPose_relocal instead.")
  (amclPose_relocal m))

(cl:ensure-generic-function 'diff_xy_relocal-val :lambda-list '(m))
(cl:defmethod diff_xy_relocal-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:diff_xy_relocal-val is deprecated.  Use landmark-msg:diff_xy_relocal instead.")
  (diff_xy_relocal m))

(cl:ensure-generic-function 'diff_rotate_relocal-val :lambda-list '(m))
(cl:defmethod diff_rotate_relocal-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:diff_rotate_relocal-val is deprecated.  Use landmark-msg:diff_rotate_relocal instead.")
  (diff_rotate_relocal m))

(cl:ensure-generic-function 'relocal_result-val :lambda-list '(m))
(cl:defmethod relocal_result-val ((m <relocal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader landmark-msg:relocal_result-val is deprecated.  Use landmark-msg:relocal_result instead.")
  (relocal_result m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <relocal>) ostream)
  "Serializes a message object of type '<relocal>"
  (cl:let* ((signed (cl:slot-value msg 'count)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'time_start)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'time_start) (cl:floor (cl:slot-value msg 'time_start)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'time_end)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'time_end) (cl:floor (cl:slot-value msg 'time_end)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'odom_reset) 1 0)) ostream)
  (cl:let* ((signed (cl:slot-value msg 'visionPoseType)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'count_repeat)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
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
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'initialPose))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'initialPose))
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
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'amclPose_relocal))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-single-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)))
   (cl:slot-value msg 'amclPose_relocal))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'diff_xy_relocal))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'diff_rotate_relocal))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'relocal_result) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <relocal>) istream)
  "Deserializes a message object of type '<relocal>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'count) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'time_start) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'time_end) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:setf (cl:slot-value msg 'odom_reset) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'visionPoseType) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'count_repeat) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
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
  (cl:setf (cl:slot-value msg 'initialPose) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'initialPose)))
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
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'amclPose_relocal) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'amclPose_relocal)))
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
    (cl:setf (cl:slot-value msg 'diff_xy_relocal) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'diff_rotate_relocal) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'relocal_result) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<relocal>)))
  "Returns string type for a message object of type '<relocal>"
  "landmark/relocal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'relocal)))
  "Returns string type for a message object of type 'relocal"
  "landmark/relocal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<relocal>)))
  "Returns md5sum for a message object of type '<relocal>"
  "fa066a9c18b30ac702fc89437c3d0ea4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'relocal)))
  "Returns md5sum for a message object of type 'relocal"
  "fa066a9c18b30ac702fc89437c3d0ea4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<relocal>)))
  "Returns full string definition for message of type '<relocal>"
  (cl:format cl:nil "int32 count~%time time_start~%time time_end~%bool odom_reset~%int8 visionPoseType~%int8 count_repeat~%float32[] amclPose~%float32[] initialPose~%float32 diff_xy~%float32 diff_rotate~%float32[] amclPose_relocal~%float32 diff_xy_relocal~%float32 diff_rotate_relocal~%bool relocal_result~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'relocal)))
  "Returns full string definition for message of type 'relocal"
  (cl:format cl:nil "int32 count~%time time_start~%time time_end~%bool odom_reset~%int8 visionPoseType~%int8 count_repeat~%float32[] amclPose~%float32[] initialPose~%float32 diff_xy~%float32 diff_rotate~%float32[] amclPose_relocal~%float32 diff_xy_relocal~%float32 diff_rotate_relocal~%bool relocal_result~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <relocal>))
  (cl:+ 0
     4
     8
     8
     1
     1
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'amclPose) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'initialPose) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'amclPose_relocal) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 4)))
     4
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <relocal>))
  "Converts a ROS message object to a list"
  (cl:list 'relocal
    (cl:cons ':count (count msg))
    (cl:cons ':time_start (time_start msg))
    (cl:cons ':time_end (time_end msg))
    (cl:cons ':odom_reset (odom_reset msg))
    (cl:cons ':visionPoseType (visionPoseType msg))
    (cl:cons ':count_repeat (count_repeat msg))
    (cl:cons ':amclPose (amclPose msg))
    (cl:cons ':initialPose (initialPose msg))
    (cl:cons ':diff_xy (diff_xy msg))
    (cl:cons ':diff_rotate (diff_rotate msg))
    (cl:cons ':amclPose_relocal (amclPose_relocal msg))
    (cl:cons ':diff_xy_relocal (diff_xy_relocal msg))
    (cl:cons ':diff_rotate_relocal (diff_rotate_relocal msg))
    (cl:cons ':relocal_result (relocal_result msg))
))
