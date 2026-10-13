;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::State)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'State (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::STATE")
  (make-package "CUSTOM_MSGS::STATE"))

(in-package "ROS")
;;//! \htmlinclude State.msg.html


(defclass custom_msgs::State
  :super ros::object
  :slots (_name _progress ))

(defmethod custom_msgs::State
  (:init
   (&key
    ((:name __name) "")
    ((:progress __progress) "")
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _progress (string __progress))
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:progress
   (&optional __progress)
   (if __progress (setq _progress __progress)) _progress)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; string _progress
    4 (length _progress)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; string _progress
       (write-long (length _progress) s) (princ _progress s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _progress
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _progress (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get custom_msgs::State :md5sum-) "adb9c03ca7fb2f83032518039a8e50f6")
(setf (get custom_msgs::State :datatype-) "custom_msgs/State")
(setf (get custom_msgs::State :definition-)
      "string name
string progress
")



(provide :custom_msgs/State "adb9c03ca7fb2f83032518039a8e50f6")


