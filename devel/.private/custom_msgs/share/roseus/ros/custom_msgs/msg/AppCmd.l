;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::AppCmd)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'AppCmd (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::APPCMD")
  (make-package "CUSTOM_MSGS::APPCMD"))

(in-package "ROS")
;;//! \htmlinclude AppCmd.msg.html


(defclass custom_msgs::AppCmd
  :super ros::object
  :slots (_name _has_param ))

(defmethod custom_msgs::AppCmd
  (:init
   (&key
    ((:name __name) "")
    ((:has_param __has_param) nil)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _has_param __has_param)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:has_param
   (&optional (__has_param :null))
   (if (not (eq __has_param :null)) (setq _has_param __has_param)) _has_param)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; bool _has_param
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; bool _has_param
       (if _has_param (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _has_param
     (setq _has_param (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get custom_msgs::AppCmd :md5sum-) "6017ebc226af765a301bb26ab1939ac0")
(setf (get custom_msgs::AppCmd :datatype-) "custom_msgs/AppCmd")
(setf (get custom_msgs::AppCmd :definition-)
      "string name
bool has_param

")



(provide :custom_msgs/AppCmd "6017ebc226af765a301bb26ab1939ac0")


