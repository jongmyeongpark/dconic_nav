;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::NormalizedFaces)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'NormalizedFaces (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::NORMALIZEDFACES")
  (make-package "CUSTOM_MSGS::NORMALIZEDFACES"))

(in-package "ROS")
;;//! \htmlinclude NormalizedFaces.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))


(defclass custom_msgs::NormalizedFaces
  :super ros::object
  :slots (_points _orientations ))

(defmethod custom_msgs::NormalizedFaces
  (:init
   (&key
    ((:points __points) ())
    ((:orientations __orientations) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _points __points)
   (setq _orientations __orientations)
   self)
  (:points
   (&rest __points)
   (if (keywordp (car __points))
       (send* _points __points)
     (progn
       (if __points (setq _points (car __points)))
       _points)))
  (:orientations
   (&optional __orientations)
   (if __orientations (setq _orientations __orientations)) _orientations)
  (:serialization-length
   ()
   (+
    ;; geometry_msgs/Point[] _points
    (apply #'+ (send-all _points :serialization-length)) 4
    ;; float32[] _orientations
    (* 4    (length _orientations)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; geometry_msgs/Point[] _points
     (write-long (length _points) s)
     (dolist (elem _points)
       (send elem :serialize s)
       )
     ;; float32[] _orientations
     (write-long (length _orientations) s)
     (dotimes (i (length _orientations))
       (sys::poke (elt _orientations i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; geometry_msgs/Point[] _points
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _points (let (r) (dotimes (i n) (push (instance geometry_msgs::Point :init) r)) r))
     (dolist (elem- _points)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; float32[] _orientations
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _orientations (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _orientations i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get custom_msgs::NormalizedFaces :md5sum-) "1576812d6c1eace4d46c75520392857f")
(setf (get custom_msgs::NormalizedFaces :datatype-) "custom_msgs/NormalizedFaces")
(setf (get custom_msgs::NormalizedFaces :definition-)
      "geometry_msgs/Point[] points
float32[] orientations
================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

")



(provide :custom_msgs/NormalizedFaces "1576812d6c1eace4d46c75520392857f")


