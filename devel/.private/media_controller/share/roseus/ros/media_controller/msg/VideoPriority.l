;; Auto-generated. Do not edit!


(when (boundp 'media_controller::VideoPriority)
  (if (not (find-package "MEDIA_CONTROLLER"))
    (make-package "MEDIA_CONTROLLER"))
  (shadow 'VideoPriority (find-package "MEDIA_CONTROLLER")))
(unless (find-package "MEDIA_CONTROLLER::VIDEOPRIORITY")
  (make-package "MEDIA_CONTROLLER::VIDEOPRIORITY"))

(in-package "ROS")
;;//! \htmlinclude VideoPriority.msg.html


(defclass media_controller::VideoPriority
  :super ros::object
  :slots (_videoPriority ))

(defmethod media_controller::VideoPriority
  (:init
   (&key
    ((:videoPriority __videoPriority) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _videoPriority __videoPriority)
   self)
  (:videoPriority
   (&optional __videoPriority)
   (if __videoPriority (setq _videoPriority __videoPriority)) _videoPriority)
  (:serialization-length
   ()
   (+
    ;; uint32[] _videoPriority
    (* 4    (length _videoPriority)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32[] _videoPriority
     (write-long (length _videoPriority) s)
     (dotimes (i (length _videoPriority))
       (write-long (elt _videoPriority i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32[] _videoPriority
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _videoPriority (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _videoPriority i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get media_controller::VideoPriority :md5sum-) "2d9b44b37b25759f764816c03dd5c4ee")
(setf (get media_controller::VideoPriority :datatype-) "media_controller/VideoPriority")
(setf (get media_controller::VideoPriority :definition-)
      "uint32[] videoPriority
")



(provide :media_controller/VideoPriority "2d9b44b37b25759f764816c03dd5c4ee")


