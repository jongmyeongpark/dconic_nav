;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Form)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Form (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::FORM")
  (make-package "CUSTOM_MSGS::FORM"))

(in-package "ROS")
;;//! \htmlinclude Form.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass custom_msgs::Form
  :super ros::object
  :slots (_form ))

(defmethod custom_msgs::Form
  (:init
   (&key
    ((:form __form) ())
    )
   (send-super :init)
   (setq _form __form)
   self)
  (:form
   (&rest __form)
   (if (keywordp (car __form))
       (send* _form __form)
     (progn
       (if __form (setq _form (car __form)))
       _form)))
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Point[] _form
    (apply #'+ (send-all _form :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Point[] _form
     (write-long (length _form) s)
     (dolist (elem _form)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Point[] _form
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _form (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _form)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get custom_msgs::Form :md5sum-) "46c4b2c357456de61f855d80140cd91b")
(setf (get custom_msgs::Form :datatype-) "custom_msgs/Form")
(setf (get custom_msgs::Form :definition-)
      "geometry_msgs/Point[] form         

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :custom_msgs/Form "46c4b2c357456de61f855d80140cd91b")


