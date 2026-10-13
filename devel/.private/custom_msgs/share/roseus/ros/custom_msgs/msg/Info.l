;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Info)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Info (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::INFO")
  (make-package "CUSTOM_MSGS::INFO"))

(in-package "ROS")
;;//! \htmlinclude Info.msg.html


(defclass custom_msgs::Info
  :super ros::object
  :slots (_up_time _total_processes _running_processes _mem_usage _free_mem_gb _total_mem_gb _cpu_usage ))

(defmethod custom_msgs::Info
  (:init
   (&key
    ((:up_time __up_time) "")
    ((:total_processes __total_processes) 0)
    ((:running_processes __running_processes) 0)
    ((:mem_usage __mem_usage) 0.0)
    ((:free_mem_gb __free_mem_gb) 0.0)
    ((:total_mem_gb __total_mem_gb) 0.0)
    ((:cpu_usage __cpu_usage) 0.0)
    )
   (send-super :init)
   (setq _up_time (string __up_time))
   (setq _total_processes (round __total_processes))
   (setq _running_processes (round __running_processes))
   (setq _mem_usage (float __mem_usage))
   (setq _free_mem_gb (float __free_mem_gb))
   (setq _total_mem_gb (float __total_mem_gb))
   (setq _cpu_usage (float __cpu_usage))
   self)
  (:up_time
   (&optional __up_time)
   (if __up_time (setq _up_time __up_time)) _up_time)
  (:total_processes
   (&optional __total_processes)
   (if __total_processes (setq _total_processes __total_processes)) _total_processes)
  (:running_processes
   (&optional __running_processes)
   (if __running_processes (setq _running_processes __running_processes)) _running_processes)
  (:mem_usage
   (&optional __mem_usage)
   (if __mem_usage (setq _mem_usage __mem_usage)) _mem_usage)
  (:free_mem_gb
   (&optional __free_mem_gb)
   (if __free_mem_gb (setq _free_mem_gb __free_mem_gb)) _free_mem_gb)
  (:total_mem_gb
   (&optional __total_mem_gb)
   (if __total_mem_gb (setq _total_mem_gb __total_mem_gb)) _total_mem_gb)
  (:cpu_usage
   (&optional __cpu_usage)
   (if __cpu_usage (setq _cpu_usage __cpu_usage)) _cpu_usage)
  (:serialization-length
   ()
   (+
    ;; string _up_time
    4 (length _up_time)
    ;; int32 _total_processes
    4
    ;; int32 _running_processes
    4
    ;; float32 _mem_usage
    4
    ;; float32 _free_mem_gb
    4
    ;; float32 _total_mem_gb
    4
    ;; float32 _cpu_usage
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _up_time
       (write-long (length _up_time) s) (princ _up_time s)
     ;; int32 _total_processes
       (write-long _total_processes s)
     ;; int32 _running_processes
       (write-long _running_processes s)
     ;; float32 _mem_usage
       (sys::poke _mem_usage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _free_mem_gb
       (sys::poke _free_mem_gb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _total_mem_gb
       (sys::poke _total_mem_gb (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _cpu_usage
       (sys::poke _cpu_usage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _up_time
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _up_time (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _total_processes
     (setq _total_processes (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _running_processes
     (setq _running_processes (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _mem_usage
     (setq _mem_usage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _free_mem_gb
     (setq _free_mem_gb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _total_mem_gb
     (setq _total_mem_gb (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _cpu_usage
     (setq _cpu_usage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get custom_msgs::Info :md5sum-) "738f3ea40c97c1008ce1dfe197260832")
(setf (get custom_msgs::Info :datatype-) "custom_msgs/Info")
(setf (get custom_msgs::Info :definition-)
      "string up_time
int32 total_processes
int32 running_processes
float32 mem_usage
float32 free_mem_gb
float32 total_mem_gb
float32 cpu_usage
")



(provide :custom_msgs/Info "738f3ea40c97c1008ce1dfe197260832")


