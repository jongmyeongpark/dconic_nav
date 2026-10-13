;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::DetectedFaces)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'DetectedFaces (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::DETECTEDFACES")
  (make-package "CUSTOM_MSGS::DETECTEDFACES"))

(in-package "ROS")
;;//! \htmlinclude DetectedFaces.msg.html


(defclass custom_msgs::DetectedFaces
  :super ros::object
  :slots (_faces _width _height ))

(defmethod custom_msgs::DetectedFaces
  (:init
   (&key
    ((:faces __faces) ())
    ((:width __width) 0)
    ((:height __height) 0)
    )
   (send-super :init)
   (setq _faces __faces)
   (setq _width (round __width))
   (setq _height (round __height))
   self)
  (:faces
   (&rest __faces)
   (if (keywordp (car __faces))
       (send* _faces __faces)
     (progn
       (if __faces (setq _faces (car __faces)))
       _faces)))
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:serialization-length
   ()
   (+
    ;; custom_msgs/FaceInfo[] _faces
    (apply #'+ (send-all _faces :serialization-length)) 4
    ;; uint32 _width
    4
    ;; uint32 _height
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; custom_msgs/FaceInfo[] _faces
     (write-long (length _faces) s)
     (dolist (elem _faces)
       (send elem :serialize s)
       )
     ;; uint32 _width
       (write-long _width s)
     ;; uint32 _height
       (write-long _height s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; custom_msgs/FaceInfo[] _faces
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _faces (let (r) (dotimes (i n) (push (instance custom_msgs::FaceInfo :init) r)) r))
     (dolist (elem- _faces)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; uint32 _width
     (setq _width (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _height
     (setq _height (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get custom_msgs::DetectedFaces :md5sum-) "e3284fee8873073e7cae331fc96b9457")
(setf (get custom_msgs::DetectedFaces :datatype-) "custom_msgs/DetectedFaces")
(setf (get custom_msgs::DetectedFaces :definition-)
      "custom_msgs/FaceInfo[] faces
uint32 width
uint32 height
================================================================================
MSG: custom_msgs/FaceInfo
int32 id
int32 x
int32 y
int32 radius
int32 height
int32 width

")



(provide :custom_msgs/DetectedFaces "e3284fee8873073e7cae331fc96b9457")


