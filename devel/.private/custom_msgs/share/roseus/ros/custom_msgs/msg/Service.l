;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Service)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Service (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::SERVICE")
  (make-package "CUSTOM_MSGS::SERVICE"))

(in-package "ROS")
;;//! \htmlinclude Service.msg.html


(defclass custom_msgs::Service
  :super ros::object
  :slots (_name _running _dependencies ))

(defmethod custom_msgs::Service
  (:init
   (&key
    ((:name __name) "")
    ((:running __running) nil)
    ((:dependencies __dependencies) ())
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _running __running)
   (setq _dependencies __dependencies)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:running
   (&optional (__running :null))
   (if (not (eq __running :null)) (setq _running __running)) _running)
  (:dependencies
   (&rest __dependencies)
   (if (keywordp (car __dependencies))
       (send* _dependencies __dependencies)
     (progn
       (if __dependencies (setq _dependencies (car __dependencies)))
       _dependencies)))
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; bool _running
    1
    ;; custom_msgs/Dependency[] _dependencies
    (apply #'+ (send-all _dependencies :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; bool _running
       (if _running (write-byte -1 s) (write-byte 0 s))
     ;; custom_msgs/Dependency[] _dependencies
     (write-long (length _dependencies) s)
     (dolist (elem _dependencies)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _running
     (setq _running (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; custom_msgs/Dependency[] _dependencies
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _dependencies (let (r) (dotimes (i n) (push (instance custom_msgs::Dependency :init) r)) r))
     (dolist (elem- _dependencies)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get custom_msgs::Service :md5sum-) "38e06d554a566cfc75320c104827e776")
(setf (get custom_msgs::Service :datatype-) "custom_msgs/Service")
(setf (get custom_msgs::Service :definition-)
      "string name
bool running
custom_msgs/Dependency[] dependencies
================================================================================
MSG: custom_msgs/Dependency
string name
bool is_service

")



(provide :custom_msgs/Service "38e06d554a566cfc75320c104827e776")


