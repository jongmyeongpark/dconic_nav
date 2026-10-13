;; Auto-generated. Do not edit!


(when (boundp 'media_controller::CongestionLevel)
  (if (not (find-package "MEDIA_CONTROLLER"))
    (make-package "MEDIA_CONTROLLER"))
  (shadow 'CongestionLevel (find-package "MEDIA_CONTROLLER")))
(unless (find-package "MEDIA_CONTROLLER::CONGESTIONLEVEL")
  (make-package "MEDIA_CONTROLLER::CONGESTIONLEVEL"))

(in-package "ROS")
;;//! \htmlinclude CongestionLevel.msg.html


(defclass media_controller::CongestionLevel
  :super ros::object
  :slots (_time _duration _congestionLevel ))

(defmethod media_controller::CongestionLevel
  (:init
   (&key
    ((:time __time) 0.0)
    ((:duration __duration) 0.0)
    ((:congestionLevel __congestionLevel) 0)
    )
   (send-super :init)
   (setq _time (float __time))
   (setq _duration (float __duration))
   (setq _congestionLevel (round __congestionLevel))
   self)
  (:time
   (&optional __time)
   (if __time (setq _time __time)) _time)
  (:duration
   (&optional __duration)
   (if __duration (setq _duration __duration)) _duration)
  (:congestionLevel
   (&optional __congestionLevel)
   (if __congestionLevel (setq _congestionLevel __congestionLevel)) _congestionLevel)
  (:serialization-length
   ()
   (+
    ;; float64 _time
    8
    ;; float64 _duration
    8
    ;; int32 _congestionLevel
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _time
       (sys::poke _time (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _duration
       (sys::poke _duration (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; int32 _congestionLevel
       (write-long _congestionLevel s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _time
     (setq _time (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _duration
     (setq _duration (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; int32 _congestionLevel
     (setq _congestionLevel (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get media_controller::CongestionLevel :md5sum-) "d721083192e0944c0aea1794baa1891f")
(setf (get media_controller::CongestionLevel :datatype-) "media_controller/CongestionLevel")
(setf (get media_controller::CongestionLevel :definition-)
      "# Sent time
float64 time

# Duration time
float64 duration

# Congestion level
int32 congestionLevel
")



(provide :media_controller/CongestionLevel "d721083192e0944c0aea1794baa1891f")


