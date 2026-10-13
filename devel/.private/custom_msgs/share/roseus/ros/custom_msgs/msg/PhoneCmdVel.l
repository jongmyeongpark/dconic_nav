;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::PhoneCmdVel)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'PhoneCmdVel (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::PHONECMDVEL")
  (make-package "CUSTOM_MSGS::PHONECMDVEL"))

(in-package "ROS")
;;//! \htmlinclude PhoneCmdVel.msg.html


(defclass custom_msgs::PhoneCmdVel
  :super ros::object
  :slots (_linear _angular _deadman _emergency_stop ))

(defmethod custom_msgs::PhoneCmdVel
  (:init
   (&key
    ((:linear __linear) 0.0)
    ((:angular __angular) 0.0)
    ((:deadman __deadman) nil)
    ((:emergency_stop __emergency_stop) nil)
    )
   (send-super :init)
   (setq _linear (float __linear))
   (setq _angular (float __angular))
   (setq _deadman __deadman)
   (setq _emergency_stop __emergency_stop)
   self)
  (:linear
   (&optional __linear)
   (if __linear (setq _linear __linear)) _linear)
  (:angular
   (&optional __angular)
   (if __angular (setq _angular __angular)) _angular)
  (:deadman
   (&optional (__deadman :null))
   (if (not (eq __deadman :null)) (setq _deadman __deadman)) _deadman)
  (:emergency_stop
   (&optional (__emergency_stop :null))
   (if (not (eq __emergency_stop :null)) (setq _emergency_stop __emergency_stop)) _emergency_stop)
  (:serialization-length
   ()
   (+
    ;; float32 _linear
    4
    ;; float32 _angular
    4
    ;; bool _deadman
    1
    ;; bool _emergency_stop
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _linear
       (sys::poke _linear (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _angular
       (sys::poke _angular (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _deadman
       (if _deadman (write-byte -1 s) (write-byte 0 s))
     ;; bool _emergency_stop
       (if _emergency_stop (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _linear
     (setq _linear (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _angular
     (setq _angular (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _deadman
     (setq _deadman (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _emergency_stop
     (setq _emergency_stop (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get custom_msgs::PhoneCmdVel :md5sum-) "992115d4061d600da0037995c70f58d7")
(setf (get custom_msgs::PhoneCmdVel :datatype-) "custom_msgs/PhoneCmdVel")
(setf (get custom_msgs::PhoneCmdVel :definition-)
      "float32 linear
float32 angular
bool deadman
bool emergency_stop
")



(provide :custom_msgs/PhoneCmdVel "992115d4061d600da0037995c70f58d7")


