;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::HeadPose)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'HeadPose (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::HEADPOSE")
  (make-package "CUSTOM_MSGS::HEADPOSE"))

(in-package "ROS")
;;//! \htmlinclude HeadPose.msg.html


(defclass custom_msgs::HeadPose
  :super ros::object
  :slots (_base_tilt _tilt _pan ))

(defmethod custom_msgs::HeadPose
  (:init
   (&key
    ((:base_tilt __base_tilt) 0.0)
    ((:tilt __tilt) 0.0)
    ((:pan __pan) 0.0)
    )
   (send-super :init)
   (setq _base_tilt (float __base_tilt))
   (setq _tilt (float __tilt))
   (setq _pan (float __pan))
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
  (:serialization-length
   ()
   (+
    ;; float32 _base_tilt
    4
    ;; float32 _tilt
    4
    ;; float32 _pan
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
   ;;
   self)
  )

(setf (get custom_msgs::HeadPose :md5sum-) "2bdaec443c73b83bbfd0a1d44c1de57f")
(setf (get custom_msgs::HeadPose :datatype-) "custom_msgs/HeadPose")
(setf (get custom_msgs::HeadPose :definition-)
      "float32 base_tilt
float32 tilt
float32 pan

")



(provide :custom_msgs/HeadPose "2bdaec443c73b83bbfd0a1d44c1de57f")


