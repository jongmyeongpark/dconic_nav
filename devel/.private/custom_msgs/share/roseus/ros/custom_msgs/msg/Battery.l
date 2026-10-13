;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Battery)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Battery (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::BATTERY")
  (make-package "CUSTOM_MSGS::BATTERY"))

(in-package "ROS")
;;//! \htmlinclude Battery.msg.html


(defclass custom_msgs::Battery
  :super ros::object
  :slots (_percentage _voltage _current _temperature _plugged _remaining_time ))

(defmethod custom_msgs::Battery
  (:init
   (&key
    ((:percentage __percentage) 0)
    ((:voltage __voltage) 0.0)
    ((:current __current) 0.0)
    ((:temperature __temperature) 0.0)
    ((:plugged __plugged) nil)
    ((:remaining_time __remaining_time) 0.0)
    )
   (send-super :init)
   (setq _percentage (round __percentage))
   (setq _voltage (float __voltage))
   (setq _current (float __current))
   (setq _temperature (float __temperature))
   (setq _plugged __plugged)
   (setq _remaining_time (float __remaining_time))
   self)
  (:percentage
   (&optional __percentage)
   (if __percentage (setq _percentage __percentage)) _percentage)
  (:voltage
   (&optional __voltage)
   (if __voltage (setq _voltage __voltage)) _voltage)
  (:current
   (&optional __current)
   (if __current (setq _current __current)) _current)
  (:temperature
   (&optional __temperature)
   (if __temperature (setq _temperature __temperature)) _temperature)
  (:plugged
   (&optional (__plugged :null))
   (if (not (eq __plugged :null)) (setq _plugged __plugged)) _plugged)
  (:remaining_time
   (&optional __remaining_time)
   (if __remaining_time (setq _remaining_time __remaining_time)) _remaining_time)
  (:serialization-length
   ()
   (+
    ;; int8 _percentage
    1
    ;; float32 _voltage
    4
    ;; float32 _current
    4
    ;; float32 _temperature
    4
    ;; bool _plugged
    1
    ;; float32 _remaining_time
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _percentage
       (write-byte _percentage s)
     ;; float32 _voltage
       (sys::poke _voltage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _current
       (sys::poke _current (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _temperature
       (sys::poke _temperature (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _plugged
       (if _plugged (write-byte -1 s) (write-byte 0 s))
     ;; float32 _remaining_time
       (sys::poke _remaining_time (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _percentage
     (setq _percentage (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _percentage 127) (setq _percentage (- _percentage 256)))
   ;; float32 _voltage
     (setq _voltage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _current
     (setq _current (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _temperature
     (setq _temperature (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _plugged
     (setq _plugged (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _remaining_time
     (setq _remaining_time (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get custom_msgs::Battery :md5sum-) "754aef2f38fdf18945e0dfe6b23b7a6f")
(setf (get custom_msgs::Battery :datatype-) "custom_msgs/Battery")
(setf (get custom_msgs::Battery :definition-)
      "int8 percentage
float32 voltage
float32 current
float32 temperature
bool plugged
float32 remaining_time
")



(provide :custom_msgs/Battery "754aef2f38fdf18945e0dfe6b23b7a6f")


