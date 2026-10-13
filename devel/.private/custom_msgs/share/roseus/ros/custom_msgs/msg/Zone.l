;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Zone)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Zone (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::ZONE")
  (make-package "CUSTOM_MSGS::ZONE"))

(in-package "ROS")
;;//! \htmlinclude Zone.msg.html


(defclass custom_msgs::Zone
  :super ros::object
  :slots (_area ))

(defmethod custom_msgs::Zone
  (:init
   (&key
    ((:area __area) (instance custom_msgs::Form :init))
    )
   (send-super :init)
   (setq _area __area)
   self)
  (:area
   (&rest __area)
   (if (keywordp (car __area))
       (send* _area __area)
     (progn
       (if __area (setq _area (car __area)))
       _area)))
  (:serialization-length
   ()
   (+
    ;; custom_msgs/Form _area
    (send _area :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; custom_msgs/Form _area
       (send _area :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; custom_msgs/Form _area
     (send _area :deserialize buf ptr-) (incf ptr- (send _area :serialization-length))
   ;;
   self)
  )

(setf (get custom_msgs::Zone :md5sum-) "033c166c5de606dccad7a8a825be6a5d")
(setf (get custom_msgs::Zone :datatype-) "custom_msgs/Zone")
(setf (get custom_msgs::Zone :definition-)
      "custom_msgs/Form area         

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



(provide :custom_msgs/Zone "033c166c5de606dccad7a8a825be6a5d")


