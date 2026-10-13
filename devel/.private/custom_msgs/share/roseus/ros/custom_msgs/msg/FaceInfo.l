;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::FaceInfo)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'FaceInfo (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::FACEINFO")
  (make-package "CUSTOM_MSGS::FACEINFO"))

(in-package "ROS")
;;//! \htmlinclude FaceInfo.msg.html


(defclass custom_msgs::FaceInfo
  :super ros::object
  :slots (_id _x _y _radius _height _width ))

(defmethod custom_msgs::FaceInfo
  (:init
   (&key
    ((:id __id) 0)
    ((:x __x) 0)
    ((:y __y) 0)
    ((:radius __radius) 0)
    ((:height __height) 0)
    ((:width __width) 0)
    )
   (send-super :init)
   (setq _id (round __id))
   (setq _x (round __x))
   (setq _y (round __y))
   (setq _radius (round __radius))
   (setq _height (round __height))
   (setq _width (round __width))
   self)
  (:id
   (&optional __id)
   (if __id (setq _id __id)) _id)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:radius
   (&optional __radius)
   (if __radius (setq _radius __radius)) _radius)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:serialization-length
   ()
   (+
    ;; int32 _id
    4
    ;; int32 _x
    4
    ;; int32 _y
    4
    ;; int32 _radius
    4
    ;; int32 _height
    4
    ;; int32 _width
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _id
       (write-long _id s)
     ;; int32 _x
       (write-long _x s)
     ;; int32 _y
       (write-long _y s)
     ;; int32 _radius
       (write-long _radius s)
     ;; int32 _height
       (write-long _height s)
     ;; int32 _width
       (write-long _width s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _id
     (setq _id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _x
     (setq _x (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _y
     (setq _y (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _radius
     (setq _radius (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _height
     (setq _height (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _width
     (setq _width (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get custom_msgs::FaceInfo :md5sum-) "e029eba489458207f867df044caa4001")
(setf (get custom_msgs::FaceInfo :datatype-) "custom_msgs/FaceInfo")
(setf (get custom_msgs::FaceInfo :definition-)
      "int32 id
int32 x
int32 y
int32 radius
int32 height
int32 width

")



(provide :custom_msgs/FaceInfo "e029eba489458207f867df044caa4001")


