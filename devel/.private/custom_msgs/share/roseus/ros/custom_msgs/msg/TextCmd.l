;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::TextCmd)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'TextCmd (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::TEXTCMD")
  (make-package "CUSTOM_MSGS::TEXTCMD"))

(in-package "ROS")
;;//! \htmlinclude TextCmd.msg.html


(defclass custom_msgs::TextCmd
  :super ros::object
  :slots (_message _duration ))

(defmethod custom_msgs::TextCmd
  (:init
   (&key
    ((:message __message) "")
    ((:duration __duration) 0.0)
    )
   (send-super :init)
   (setq _message (string __message))
   (setq _duration (float __duration))
   self)
  (:message
   (&optional __message)
   (if __message (setq _message __message)) _message)
  (:duration
   (&optional __duration)
   (if __duration (setq _duration __duration)) _duration)
  (:serialization-length
   ()
   (+
    ;; string _message
    4 (length _message)
    ;; float32 _duration
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _message
       (write-long (length _message) s) (princ _message s)
     ;; float32 _duration
       (sys::poke _duration (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float32 _duration
     (setq _duration (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get custom_msgs::TextCmd :md5sum-) "de6f57ebad55f1f6a9ba16d710b7edfa")
(setf (get custom_msgs::TextCmd :datatype-) "custom_msgs/TextCmd")
(setf (get custom_msgs::TextCmd :definition-)
      "string message
float32 duration

")



(provide :custom_msgs/TextCmd "de6f57ebad55f1f6a9ba16d710b7edfa")


