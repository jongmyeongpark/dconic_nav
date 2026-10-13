;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Dependency)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Dependency (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::DEPENDENCY")
  (make-package "CUSTOM_MSGS::DEPENDENCY"))

(in-package "ROS")
;;//! \htmlinclude Dependency.msg.html


(defclass custom_msgs::Dependency
  :super ros::object
  :slots (_name _is_service ))

(defmethod custom_msgs::Dependency
  (:init
   (&key
    ((:name __name) "")
    ((:is_service __is_service) nil)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _is_service __is_service)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:is_service
   (&optional (__is_service :null))
   (if (not (eq __is_service :null)) (setq _is_service __is_service)) _is_service)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; bool _is_service
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; bool _is_service
       (if _is_service (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _is_service
     (setq _is_service (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get custom_msgs::Dependency :md5sum-) "4731fce1f3d3e6878365b333c34c8ab2")
(setf (get custom_msgs::Dependency :datatype-) "custom_msgs/Dependency")
(setf (get custom_msgs::Dependency :definition-)
      "string name
bool is_service

")



(provide :custom_msgs/Dependency "4731fce1f3d3e6878365b333c34c8ab2")


