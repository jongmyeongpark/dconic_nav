;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Log)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Log (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::LOG")
  (make-package "CUSTOM_MSGS::LOG"))

(in-package "ROS")
;;//! \htmlinclude Log.msg.html


(defclass custom_msgs::Log
  :super ros::object
  :slots (_message _level ))

(defmethod custom_msgs::Log
  (:init
   (&key
    ((:message __message) "")
    ((:level __level) "")
    )
   (send-super :init)
   (setq _message (string __message))
   (setq _level (string __level))
   self)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:level
   (&optional __level)
   (if __level (setq _level __level)) _level)
  (:serialization-length
   ()
   (+
    ;; string _message
    4 (length _message)
    ;; string _level
    4 (length _level)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;; string _level
       (write-long (length _level) s) (princ _level s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _level
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _level (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get custom_msgs::Log :md5sum-) "6a6fdfa23bc9ac5ba6534f1c280c52a2")
(setf (get custom_msgs::Log :datatype-) "custom_msgs/Log")
(setf (get custom_msgs::Log :definition-)
      "string message
string level
")



(provide :custom_msgs/Log "6a6fdfa23bc9ac5ba6534f1c280c52a2")


