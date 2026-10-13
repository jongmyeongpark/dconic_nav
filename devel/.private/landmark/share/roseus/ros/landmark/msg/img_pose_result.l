;; Auto-generated. Do not edit!


(when (boundp 'landmark::img_pose_result)
  (if (not (find-package "LANDMARK"))
    (make-package "LANDMARK"))
  (shadow 'img_pose_result (find-package "LANDMARK")))
(unless (find-package "LANDMARK::IMG_POSE_RESULT")
  (make-package "LANDMARK::IMG_POSE_RESULT"))

(in-package "ROS")
;;//! \htmlinclude img_pose_result.msg.html


(defclass landmark::img_pose_result
  :super ros::object
  :slots (_stamp _sim_id _score _amclPose _visionPose _diff_xy _diff_rotate _valid_status _mismatch_status _unjudge_status _relocal_status ))

(defmethod landmark::img_pose_result
  (:init
   (&key
    ((:stamp __stamp) (instance ros::time :init))
    ((:sim_id __sim_id) 0)
    ((:score __score) 0.0)
    ((:amclPose __amclPose) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:visionPose __visionPose) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:diff_xy __diff_xy) 0.0)
    ((:diff_rotate __diff_rotate) 0.0)
    ((:valid_status __valid_status) nil)
    ((:mismatch_status __mismatch_status) nil)
    ((:unjudge_status __unjudge_status) nil)
    ((:relocal_status __relocal_status) 0)
    )
   (send-super :init)
   (setq _stamp __stamp)
   (setq _sim_id (round __sim_id))
   (setq _score (float __score))
   (setq _amclPose __amclPose)
   (setq _visionPose __visionPose)
   (setq _diff_xy (float __diff_xy))
   (setq _diff_rotate (float __diff_rotate))
   (setq _valid_status __valid_status)
   (setq _mismatch_status __mismatch_status)
   (setq _unjudge_status __unjudge_status)
   (setq _relocal_status (round __relocal_status))
   self)
  (:stamp
   (&optional __stamp)
   (if __stamp (setq _stamp __stamp)) _stamp)
  (:sim_id
   (&optional __sim_id)
   (if __sim_id (setq _sim_id __sim_id)) _sim_id)
  (:score
   (&optional __score)
   (if __score (setq _score __score)) _score)
  (:amclPose
   (&optional __amclPose)
   (if __amclPose (setq _amclPose __amclPose)) _amclPose)
  (:visionPose
   (&optional __visionPose)
   (if __visionPose (setq _visionPose __visionPose)) _visionPose)
  (:diff_xy
   (&optional __diff_xy)
   (if __diff_xy (setq _diff_xy __diff_xy)) _diff_xy)
  (:diff_rotate
   (&optional __diff_rotate)
   (if __diff_rotate (setq _diff_rotate __diff_rotate)) _diff_rotate)
  (:valid_status
   (&optional (__valid_status :null))
   (if (not (eq __valid_status :null)) (setq _valid_status __valid_status)) _valid_status)
  (:mismatch_status
   (&optional (__mismatch_status :null))
   (if (not (eq __mismatch_status :null)) (setq _mismatch_status __mismatch_status)) _mismatch_status)
  (:unjudge_status
   (&optional (__unjudge_status :null))
   (if (not (eq __unjudge_status :null)) (setq _unjudge_status __unjudge_status)) _unjudge_status)
  (:relocal_status
   (&optional __relocal_status)
   (if __relocal_status (setq _relocal_status __relocal_status)) _relocal_status)
  (:serialization-length
   ()
   (+
    ;; time _stamp
    8
    ;; int32 _sim_id
    4
    ;; float32 _score
    4
    ;; float32[] _amclPose
    (* 4    (length _amclPose)) 4
    ;; float32[] _visionPose
    (* 4    (length _visionPose)) 4
    ;; float32 _diff_xy
    4
    ;; float32 _diff_rotate
    4
    ;; bool _valid_status
    1
    ;; bool _mismatch_status
    1
    ;; bool _unjudge_status
    1
    ;; int8 _relocal_status
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; time _stamp
       (write-long (send _stamp :sec) s) (write-long (send _stamp :nsec) s)
     ;; int32 _sim_id
       (write-long _sim_id s)
     ;; float32 _score
       (sys::poke _score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _amclPose
     (write-long (length _amclPose) s)
     (dotimes (i (length _amclPose))
       (sys::poke (elt _amclPose i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _visionPose
     (write-long (length _visionPose) s)
     (dotimes (i (length _visionPose))
       (sys::poke (elt _visionPose i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _diff_xy
       (sys::poke _diff_xy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _diff_rotate
       (sys::poke _diff_rotate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _valid_status
       (if _valid_status (write-byte -1 s) (write-byte 0 s))
     ;; bool _mismatch_status
       (if _mismatch_status (write-byte -1 s) (write-byte 0 s))
     ;; bool _unjudge_status
       (if _unjudge_status (write-byte -1 s) (write-byte 0 s))
     ;; int8 _relocal_status
       (write-byte _relocal_status s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; time _stamp
     (send _stamp :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _stamp :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _sim_id
     (setq _sim_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _score
     (setq _score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _amclPose
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _amclPose (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _amclPose i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _visionPose
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _visionPose (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _visionPose i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _diff_xy
     (setq _diff_xy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _diff_rotate
     (setq _diff_rotate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _valid_status
     (setq _valid_status (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _mismatch_status
     (setq _mismatch_status (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _unjudge_status
     (setq _unjudge_status (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int8 _relocal_status
     (setq _relocal_status (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _relocal_status 127) (setq _relocal_status (- _relocal_status 256)))
   ;;
   self)
  )

(setf (get landmark::img_pose_result :md5sum-) "4c390e3b380adc5fc1a15fddc1d5517a")
(setf (get landmark::img_pose_result :datatype-) "landmark/img_pose_result")
(setf (get landmark::img_pose_result :definition-)
      "time stamp
int32 sim_id
float32 score
float32[] amclPose
float32[] visionPose
float32 diff_xy
float32 diff_rotate
bool valid_status
bool mismatch_status
bool unjudge_status
int8 relocal_status

")



(provide :landmark/img_pose_result "4c390e3b380adc5fc1a15fddc1d5517a")


