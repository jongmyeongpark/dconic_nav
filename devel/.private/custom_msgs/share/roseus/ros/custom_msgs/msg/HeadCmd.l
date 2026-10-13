;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::HeadCmd)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'HeadCmd (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::HEADCMD")
  (make-package "CUSTOM_MSGS::HEADCMD"))

(in-package "ROS")
;;//! \htmlinclude HeadCmd.msg.html


(defclass custom_msgs::HeadCmd
  :super ros::object
  :slots (_base_tilt _tilt _pan _base_tilt_speed_rate _tilt_speed_rate _pan_speed_rate ))

(defmethod custom_msgs::HeadCmd
  (:init
   (&key
    ((:base_tilt __base_tilt) 0.0)
    ((:tilt __tilt) 0.0)
    ((:pan __pan) 0.0)
    ((:base_tilt_speed_rate __base_tilt_speed_rate) 0.0)
    ((:tilt_speed_rate __tilt_speed_rate) 0.0)
    ((:pan_speed_rate __pan_speed_rate) 0.0)
    )
   (send-super :init)
   (setq _base_tilt (float __base_tilt))
   (setq _tilt (float __tilt))
   (setq _pan (float __pan))
   (setq _base_tilt_speed_rate (float __base_tilt_speed_rate))
   (setq _tilt_speed_rate (float __tilt_speed_rate))
   (setq _pan_speed_rate (float __pan_speed_rate))
   self)
  (:base_tilt
   (&optional __base_tilt)
   (if __base_tilt (setq _base_tilt __base_tilt)) _base_tilt)
  (:tilt
   (&optional __tilt)
   (if __tilt (setq _tilt __tilt)) _tilt)
  (:pan
   (&optional __pan)
   (if __pan (setq _pan __pan)) _pan)
  (:base_tilt_speed_rate
   (&optional __base_tilt_speed_rate)
   (if __base_tilt_speed_rate (setq _base_tilt_speed_rate __base_tilt_speed_rate)) _base_tilt_speed_rate)
  (:tilt_speed_rate
   (&optional __tilt_speed_rate)
   (if __tilt_speed_rate (setq _tilt_speed_rate __tilt_speed_rate)) _tilt_speed_rate)
  (:pan_speed_rate
   (&optional __pan_speed_rate)
   (if __pan_speed_rate (setq _pan_speed_rate __pan_speed_rate)) _pan_speed_rate)
  (:serialization-length
   ()
   (+
    ;; float32 _base_tilt
    4
    ;; float32 _tilt
    4
    ;; float32 _pan
    4
    ;; float32 _base_tilt_speed_rate
    4
    ;; float32 _tilt_speed_rate
    4
    ;; float32 _pan_speed_rate
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _base_tilt
       (sys::poke _base_tilt (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _tilt
       (sys::poke _tilt (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pan
       (sys::poke _pan (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _base_tilt_speed_rate
       (sys::poke _base_tilt_speed_rate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _tilt_speed_rate
       (sys::poke _tilt_speed_rate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pan_speed_rate
       (sys::poke _pan_speed_rate (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _base_tilt
     (setq _base_tilt (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _tilt
     (setq _tilt (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pan
     (setq _pan (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _base_tilt_speed_rate
     (setq _base_tilt_speed_rate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _tilt_speed_rate
     (setq _tilt_speed_rate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pan_speed_rate
     (setq _pan_speed_rate (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get custom_msgs::HeadCmd :md5sum-) "367b243a2924fb2bb03e2f8e186db888")
(setf (get custom_msgs::HeadCmd :datatype-) "custom_msgs/HeadCmd")
(setf (get custom_msgs::HeadCmd :definition-)
      "float32 base_tilt
float32 tilt
float32 pan

float32 base_tilt_speed_rate
float32 tilt_speed_rate
float32 pan_speed_rate
")



(provide :custom_msgs/HeadCmd "367b243a2924fb2bb03e2f8e186db888")


