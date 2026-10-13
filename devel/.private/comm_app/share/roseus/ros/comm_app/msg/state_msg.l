;; Auto-generated. Do not edit!


(when (boundp 'comm_app::state_msg)
  (if (not (find-package "COMM_APP"))
    (make-package "COMM_APP"))
  (shadow 'state_msg (find-package "COMM_APP")))
(unless (find-package "COMM_APP::STATE_MSG")
  (make-package "COMM_APP::STATE_MSG"))

(in-package "ROS")
;;//! \htmlinclude state_msg.msg.html


(defclass comm_app::state_msg
  :super ros::object
  :slots (_topic_name _result ))

(defmethod comm_app::state_msg
  (:init
   (&key
    ((:topic_name __topic_name) "")
    ((:result __result) 0)
    )
   (send-super :init)
   (setq _topic_name (string __topic_name))
   (setq _result (round __result))
   self)
  (:topic_name
   (&optional __topic_name)
   (if __topic_name (setq _topic_name __topic_name)) _topic_name)
  (:result
   (&optional __result)
   (if __result (setq _result __result)) _result)
  (:serialization-length
   ()
   (+
    ;; string _topic_name
    4 (length _topic_name)
    ;; int32 _result
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _topic_name
       (write-long (length _topic_name) s) (princ _topic_name s)
     ;; int32 _result
       (write-long _result s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _topic_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _topic_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _result
     (setq _result (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get comm_app::state_msg :md5sum-) "c94167c6c6f29721fe9ea18bd0c568d6")
(setf (get comm_app::state_msg :datatype-) "comm_app/state_msg")
(setf (get comm_app::state_msg :definition-)
      "string topic_name
int32 result

")



(provide :comm_app/state_msg "c94167c6c6f29721fe9ea18bd0c568d6")


