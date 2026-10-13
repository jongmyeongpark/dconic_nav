;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::MachineDescription)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'MachineDescription (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::MACHINEDESCRIPTION")
  (make-package "CUSTOM_MSGS::MACHINEDESCRIPTION"))

(in-package "ROS")
;;//! \htmlinclude MachineDescription.msg.html


(defclass custom_msgs::MachineDescription
  :super ros::object
  :slots (_name _states _transitions ))

(defmethod custom_msgs::MachineDescription
  (:init
   (&key
    ((:name __name) "")
    ((:states __states) ())
    ((:transitions __transitions) ())
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _states __states)
   (setq _transitions __transitions)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:states
   (&rest __states)
   (if (keywordp (car __states))
       (send* _states __states)
     (progn
       (if __states (setq _states (car __states)))
       _states)))
  (:transitions
   (&rest __transitions)
   (if (keywordp (car __transitions))
       (send* _transitions __transitions)
     (progn
       (if __transitions (setq _transitions (car __transitions)))
       _transitions)))
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; custom_msgs/State[] _states
    (apply #'+ (send-all _states :serialization-length)) 4
    ;; custom_msgs/Transition[] _transitions
    (apply #'+ (send-all _transitions :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; custom_msgs/State[] _states
     (write-long (length _states) s)
     (dolist (elem _states)
       (send elem :serialize s)
       )
     ;; custom_msgs/Transition[] _transitions
     (write-long (length _transitions) s)
     (dolist (elem _transitions)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; custom_msgs/State[] _states
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _states (let (r) (dotimes (i n) (push (instance custom_msgs::State :init) r)) r))
     (dolist (elem- _states)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; custom_msgs/Transition[] _transitions
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _transitions (let (r) (dotimes (i n) (push (instance custom_msgs::Transition :init) r)) r))
     (dolist (elem- _transitions)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get custom_msgs::MachineDescription :md5sum-) "0aadf3ce88e651d129124e468424db9d")
(setf (get custom_msgs::MachineDescription :datatype-) "custom_msgs/MachineDescription")
(setf (get custom_msgs::MachineDescription :definition-)
      "string name
State[] states
Transition[] transitions
================================================================================
MSG: custom_msgs/State
string name
string progress
================================================================================
MSG: custom_msgs/Transition
string name
State in
State out
")



(provide :custom_msgs/MachineDescription "0aadf3ce88e651d129124e468424db9d")


