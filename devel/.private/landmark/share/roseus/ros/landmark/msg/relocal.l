;; Auto-generated. Do not edit!


(when (boundp 'landmark::relocal)
  (if (not (find-package "LANDMARK"))
    (make-package "LANDMARK"))
  (shadow 'relocal (find-package "LANDMARK")))
(unless (find-package "LANDMARK::RELOCAL")
  (make-package "LANDMARK::RELOCAL"))

(in-package "ROS")
;;//! \htmlinclude relocal.msg.html


(defclass landmark::relocal
  :super ros::object
  :slots (_count _time_start _time_end _odom_reset _visionPoseType _count_repeat _amclPose _initialPose _diff_xy _diff_rotate _amclPose_relocal _diff_xy_relocal _diff_rotate_relocal _relocal_result ))

(defmethod landmark::relocal
  (:init
   (&key
    ((:count __count) 0)
    ((:time_start __time_start) (instance ros::time :init))
    ((:time_end __time_end) (instance ros::time :init))
    ((:odom_reset __odom_reset) nil)
    ((:visionPoseType __visionPoseType) 0)
    ((:count_repeat __count_repeat) 0)
    ((:amclPose __amclPose) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:initialPose __initialPose) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:diff_xy __diff_xy) 0.0)
    ((:diff_rotate __diff_rotate) 0.0)
    ((:amclPose_relocal __amclPose_relocal) (make-array 0 :initial-element 0.0 :element-type :float))
    ((:diff_xy_relocal __diff_xy_relocal) 0.0)
    ((:diff_rotate_relocal __diff_rotate_relocal) 0.0)
    ((:relocal_result __relocal_result) nil)
    )
   (send-super :init)
   (setq _count (round __count))
   (setq _time_start __time_start)
   (setq _time_end __time_end)
   (setq _odom_reset __odom_reset)
   (setq _visionPoseType (round __visionPoseType))
   (setq _count_repeat (round __count_repeat))
   (setq _amclPose __amclPose)
   (setq _initialPose __initialPose)
   (setq _diff_xy (float __diff_xy))
   (setq _diff_rotate (float __diff_rotate))
   (setq _amclPose_relocal __amclPose_relocal)
   (setq _diff_xy_relocal (float __diff_xy_relocal))
   (setq _diff_rotate_relocal (float __diff_rotate_relocal))
   (setq _relocal_result __relocal_result)
   self)
  (:count
   (&optional __count)
   (if __count (setq _count __count)) _count)
  (:time_start
   (&optional __time_start)
   (if __time_start (setq _time_start __time_start)) _time_start)
  (:time_end
   (&optional __time_end)
   (if __time_end (setq _time_end __time_end)) _time_end)
  (:odom_reset
   (&optional (__odom_reset :null))
   (if (not (eq __odom_reset :null)) (setq _odom_reset __odom_reset)) _odom_reset)
  (:visionPoseType
   (&optional __visionPoseType)
   (if __visionPoseType (setq _visionPoseType __visionPoseType)) _visionPoseType)
  (:count_repeat
   (&optional __count_repeat)
   (if __count_repeat (setq _count_repeat __count_repeat)) _count_repeat)
  (:amclPose
   (&optional __amclPose)
   (if __amclPose (setq _amclPose __amclPose)) _amclPose)
  (:initialPose
   (&optional __initialPose)
   (if __initialPose (setq _initialPose __initialPose)) _initialPose)
  (:diff_xy
   (&optional __diff_xy)
   (if __diff_xy (setq _diff_xy __diff_xy)) _diff_xy)
  (:diff_rotate
   (&optional __diff_rotate)
   (if __diff_rotate (setq _diff_rotate __diff_rotate)) _diff_rotate)
  (:amclPose_relocal
   (&optional __amclPose_relocal)
   (if __amclPose_relocal (setq _amclPose_relocal __amclPose_relocal)) _amclPose_relocal)
  (:diff_xy_relocal
   (&optional __diff_xy_relocal)
   (if __diff_xy_relocal (setq _diff_xy_relocal __diff_xy_relocal)) _diff_xy_relocal)
  (:diff_rotate_relocal
   (&optional __diff_rotate_relocal)
   (if __diff_rotate_relocal (setq _diff_rotate_relocal __diff_rotate_relocal)) _diff_rotate_relocal)
  (:relocal_result
   (&optional (__relocal_result :null))
   (if (not (eq __relocal_result :null)) (setq _relocal_result __relocal_result)) _relocal_result)
  (:serialization-length
   ()
   (+
    ;; int32 _count
    4
    ;; time _time_start
    8
    ;; time _time_end
    8
    ;; bool _odom_reset
    1
    ;; int8 _visionPoseType
    1
    ;; int8 _count_repeat
    1
    ;; float32[] _amclPose
    (* 4    (length _amclPose)) 4
    ;; float32[] _initialPose
    (* 4    (length _initialPose)) 4
    ;; float32 _diff_xy
    4
    ;; float32 _diff_rotate
    4
    ;; float32[] _amclPose_relocal
    (* 4    (length _amclPose_relocal)) 4
    ;; float32 _diff_xy_relocal
    4
    ;; float32 _diff_rotate_relocal
    4
    ;; bool _relocal_result
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _count
       (write-long _count s)
     ;; time _time_start
       (write-long (send _time_start :sec) s) (write-long (send _time_start :nsec) s)
     ;; time _time_end
       (write-long (send _time_end :sec) s) (write-long (send _time_end :nsec) s)
     ;; bool _odom_reset
       (if _odom_reset (write-byte -1 s) (write-byte 0 s))
     ;; int8 _visionPoseType
       (write-byte _visionPoseType s)
     ;; int8 _count_repeat
       (write-byte _count_repeat s)
     ;; float32[] _amclPose
     (write-long (length _amclPose) s)
     (dotimes (i (length _amclPose))
       (sys::poke (elt _amclPose i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[] _initialPose
     (write-long (length _initialPose) s)
     (dotimes (i (length _initialPose))
       (sys::poke (elt _initialPose i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _diff_xy
       (sys::poke _diff_xy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _diff_rotate
       (sys::poke _diff_rotate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[] _amclPose_relocal
     (write-long (length _amclPose_relocal) s)
     (dotimes (i (length _amclPose_relocal))
       (sys::poke (elt _amclPose_relocal i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _diff_xy_relocal
       (sys::poke _diff_xy_relocal (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _diff_rotate_relocal
       (sys::poke _diff_rotate_relocal (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _relocal_result
       (if _relocal_result (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _count
     (setq _count (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; time _time_start
     (send _time_start :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _time_start :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; time _time_end
     (send _time_end :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _time_end :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _odom_reset
     (setq _odom_reset (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; int8 _visionPoseType
     (setq _visionPoseType (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _visionPoseType 127) (setq _visionPoseType (- _visionPoseType 256)))
   ;; int8 _count_repeat
     (setq _count_repeat (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _count_repeat 127) (setq _count_repeat (- _count_repeat 256)))
   ;; float32[] _amclPose
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _amclPose (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _amclPose i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32[] _initialPose
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _initialPose (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _initialPose i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _diff_xy
     (setq _diff_xy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _diff_rotate
     (setq _diff_rotate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[] _amclPose_relocal
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _amclPose_relocal (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _amclPose_relocal i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;; float32 _diff_xy_relocal
     (setq _diff_xy_relocal (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _diff_rotate_relocal
     (setq _diff_rotate_relocal (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _relocal_result
     (setq _relocal_result (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get landmark::relocal :md5sum-) "fa066a9c18b30ac702fc89437c3d0ea4")
(setf (get landmark::relocal :datatype-) "landmark/relocal")
(setf (get landmark::relocal :definition-)
      "int32 count
time time_start
time time_end
bool odom_reset
int8 visionPoseType
int8 count_repeat
float32[] amclPose
float32[] initialPose
float32 diff_xy
float32 diff_rotate
float32[] amclPose_relocal
float32 diff_xy_relocal
float32 diff_rotate_relocal
bool relocal_result
")



(provide :landmark/relocal "fa066a9c18b30ac702fc89437c3d0ea4")


