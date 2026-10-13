;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Heartbeat)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Heartbeat (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::HEARTBEAT")
  (make-package "CUSTOM_MSGS::HEARTBEAT"))

(in-package "ROS")
;;//! \htmlinclude Heartbeat.msg.html


(defclass custom_msgs::Heartbeat
  :super ros::object
  :slots (_port _uuid _connection_uuid ))

(defmethod custom_msgs::Heartbeat
  (:init
   (&key
    ((:port __port) 0)
    ((:uuid __uuid) "")
    ((:connection_uuid __connection_uuid) "")
    )
   (send-super :init)
   (setq _port (round __port))
   (setq _uuid (string __uuid))
   (setq _connection_uuid (string __connection_uuid))
   self)
  (:port
   (&optional __port)
   (if __port (setq _port __port)) _port)
  (:uuid
   (&optional __uuid)
   (if __uuid (setq _uuid __uuid)) _uuid)
  (:connection_uuid
   (&optional __connection_uuid)
   (if __connection_uuid (setq _connection_uuid __connection_uuid)) _connection_uuid)
  (:serialization-length
   ()
   (+
    ;; int32 _port
    4
    ;; string _uuid
    4 (length _uuid)
    ;; string _connection_uuid
    4 (length _connection_uuid)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _port
       (write-long _port s)
     ;; string _uuid
       (write-long (length _uuid) s) (princ _uuid s)
     ;; string _connection_uuid
       (write-long (length _connection_uuid) s) (princ _connection_uuid s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _port
     (setq _port (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _uuid
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _uuid (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _connection_uuid
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _connection_uuid (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get custom_msgs::Heartbeat :md5sum-) "4077598408c2d9fd9a1f23b114106d6c")
(setf (get custom_msgs::Heartbeat :datatype-) "custom_msgs/Heartbeat")
(setf (get custom_msgs::Heartbeat :definition-)
      "int32 port
string uuid
string connection_uuid

")



(provide :custom_msgs/Heartbeat "4077598408c2d9fd9a1f23b114106d6c")


