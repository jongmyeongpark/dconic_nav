;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Process)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Process (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::PROCESS")
  (make-package "CUSTOM_MSGS::PROCESS"))

(in-package "ROS")
;;//! \htmlinclude Process.msg.html


(defclass custom_msgs::Process
  :super ros::object
  :slots (_name _running _base_process ))

(defmethod custom_msgs::Process
  (:init
   (&key
    ((:name __name) "")
    ((:running __running) nil)
    ((:base_process __base_process) nil)
    )
   (send-super :init)
   (setq _name (string __name))
   (setq _running __running)
   (setq _base_process __base_process)
   self)
  (:name
   (&optional __name)
   (if __name (setq _name __name)) _name)
  (:running
   (&optional (__running :null))
   (if (not (eq __running :null)) (setq _running __running)) _running)
  (:base_process
   (&optional (__base_process :null))
   (if (not (eq __base_process :null)) (setq _base_process __base_process)) _base_process)
  (:serialization-length
   ()
   (+
    ;; string _name
    4 (length _name)
    ;; bool _running
    1
    ;; bool _base_process
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _name
       (write-long (length _name) s) (princ _name s)
     ;; bool _running
       (if _running (write-byte -1 s) (write-byte 0 s))
     ;; bool _base_process
       (if _base_process (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; bool _running
     (setq _running (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _base_process
     (setq _base_process (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get custom_msgs::Process :md5sum-) "790230f4d0eea7c1e89d8558f738f0c2")
(setf (get custom_msgs::Process :datatype-) "custom_msgs/Process")
(setf (get custom_msgs::Process :definition-)
      "string name
bool running
bool base_process
")



(provide :custom_msgs/Process "790230f4d0eea7c1e89d8558f738f0c2")


