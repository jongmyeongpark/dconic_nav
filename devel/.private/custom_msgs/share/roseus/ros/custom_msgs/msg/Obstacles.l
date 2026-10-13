;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Obstacles)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Obstacles (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::OBSTACLES")
  (make-package "CUSTOM_MSGS::OBSTACLES"))

(in-package "ROS")
;;//! \htmlinclude Obstacles.msg.html


(defclass custom_msgs::Obstacles
  :super ros::object
  :slots (_list ))

(defmethod custom_msgs::Obstacles
  (:init
   (&key
    ((:list __list) ())
    )
   (send-super :init)
   (setq _list __list)
   self)
  (:list
   (&rest __list)
   (if (keywordp (car __list))
       (send* _list __list)
     (progn
       (if __list (setq _list (car __list)))
       _list)))
  (:serialization-length
   ()
   (+
    ;; custom_msgs/Form[] _list
    (apply #'+ (send-all _list :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; custom_msgs/Form[] _list
     (write-long (length _list) s)
     (dolist (elem _list)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; custom_msgs/Form[] _list
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _list (let (r) (dotimes (i n) (push (instance custom_msgs::Form :init) r)) r))
     (dolist (elem- _list)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get custom_msgs::Obstacles :md5sum-) "17a730197357ae1c7100500a3326c347")
(setf (get custom_msgs::Obstacles :datatype-) "custom_msgs/Obstacles")
(setf (get custom_msgs::Obstacles :definition-)
      "custom_msgs/Form[] list         

================================================================================
MSG: custom_msgs/Form
geometry_msgs/Point[] form         

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :custom_msgs/Obstacles "17a730197357ae1c7100500a3326c347")


