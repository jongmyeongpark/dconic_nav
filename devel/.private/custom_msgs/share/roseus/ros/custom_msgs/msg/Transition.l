;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Transition)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Transition (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::TRANSITION")
  (make-package "CUSTOM_MSGS::TRANSITION"))

(in-package "ROS")
;;//! \htmlinclude Transition.msg.html


(defclass custom_msgs::Transition
  :super ros::object
  :slots (_name _in _out ))

(defmethod custom_msgs::Transition
  (:init
   (&key
    ((:name __name) "")
    ((:in __in) (instance custom_msgs::State :init))
    ((:out __out) (instance custom_msgs::State :init))
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _in __in)
   (setq _out __out)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:in
   (&rest __in)
   (if (keywordp (car __in))
       (send* _in __in)
     (progn
       (if __in (setq _in (car __in)))
       _in)))
  (:out
   (&rest __out)
   (if (keywordp (car __out))
       (send* _out __out)
     (progn
       (if __out (setq _out (car __out)))
       _out)))
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; custom_msgs/State _in
    (send _in :serialization-length)
    ;; custom_msgs/State _out
    (send _out :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; custom_msgs/State _in
       (send _in :serialize s)
     ;; custom_msgs/State _out
       (send _out :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; custom_msgs/State _in
     (send _in :deserialize buf ptr-) (incf ptr- (send _in :serialization-length))
   ;; custom_msgs/State _out
     (send _out :deserialize buf ptr-) (incf ptr- (send _out :serialization-length))
   ;;
   self)
  )

(setf (get custom_msgs::Transition :md5sum-) "e8262dc49d6d86b1edcd11009f8370e8")
(setf (get custom_msgs::Transition :datatype-) "custom_msgs/Transition")
(setf (get custom_msgs::Transition :definition-)
      "string name
State in
State out
================================================================================
MSG: custom_msgs/State
string name
string progress
")



(provide :custom_msgs/Transition "e8262dc49d6d86b1edcd11009f8370e8")


