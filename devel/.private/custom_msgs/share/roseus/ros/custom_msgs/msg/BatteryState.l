;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::BatteryState)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'BatteryState (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::BATTERYSTATE")
  (make-package "CUSTOM_MSGS::BATTERYSTATE"))

(in-package "ROS")
;;//! \htmlinclude BatteryState.msg.html


(defclass custom_msgs::BatteryState
  :super ros::object
  :slots (_voltage _charge _plug_mode ))

(defmethod custom_msgs::BatteryState
  (:init
   (&key
    ((:voltage __voltage) 0.0)
    ((:charge __charge) 0)
    ((:plug_mode __plug_mode) 0)
    )
   (send-super :init)
   (setq _voltage (float __voltage))
   (setq _charge (round __charge))
   (setq _plug_mode (round __plug_mode))
   self)
  (:voltage
   (&optional __voltage)
   (if __voltage (setq _voltage __voltage)) _voltage)
  (:charge
   (&optional __charge)
   (if __charge (setq _charge __charge)) _charge)
  (:plug_mode
   (&optional __plug_mode)
   (if __plug_mode (setq _plug_mode __plug_mode)) _plug_mode)
  (:serialization-length
   ()
   (+
    ;; float32 _voltage
    4
    ;; int32 _charge
    4
    ;; int32 _plug_mode
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _voltage
       (sys::poke _voltage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; int32 _charge
       (write-long _charge s)
     ;; int32 _plug_mode
       (write-long _plug_mode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _voltage
     (setq _voltage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; int32 _charge
     (setq _charge (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _plug_mode
     (setq _plug_mode (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get custom_msgs::BatteryState :md5sum-) "31c657e7fb6d2293bc6edeb004ace904")
(setf (get custom_msgs::BatteryState :datatype-) "custom_msgs/BatteryState")
(setf (get custom_msgs::BatteryState :definition-)
      "float32 voltage
int32 charge
int32 plug_mode 

")



(provide :custom_msgs/BatteryState "31c657e7fb6d2293bc6edeb004ace904")


