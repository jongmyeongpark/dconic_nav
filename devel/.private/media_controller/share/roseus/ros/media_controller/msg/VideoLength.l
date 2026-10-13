;; Auto-generated. Do not edit!


(when (boundp 'media_controller::VideoLength)
  (if (not (find-package "MEDIA_CONTROLLER"))
    (make-package "MEDIA_CONTROLLER"))
  (shadow 'VideoLength (find-package "MEDIA_CONTROLLER")))
(unless (find-package "MEDIA_CONTROLLER::VIDEOLENGTH")
  (make-package "MEDIA_CONTROLLER::VIDEOLENGTH"))

(in-package "ROS")
;;//! \htmlinclude VideoLength.msg.html


(defclass media_controller::VideoLength
  :super ros::object
  :slots (_videoLength ))

(defmethod media_controller::VideoLength
  (:init
   (&key
    ((:videoLength __videoLength) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _videoLength __videoLength)
   self)
  (:videoLength
   (&optional __videoLength)
   (if __videoLength (setq _videoLength __videoLength)) _videoLength)
  (:serialization-length
   ()
   (+
    ;; uint32[] _videoLength
    (* 4    (length _videoLength)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32[] _videoLength
     (write-long (length _videoLength) s)
     (dotimes (i (length _videoLength))
       (write-long (elt _videoLength i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32[] _videoLength
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _videoLength (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _videoLength i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get media_controller::VideoLength :md5sum-) "42e2ca7a6872ea97a8d5f8554e713583")
(setf (get media_controller::VideoLength :datatype-) "media_controller/VideoLength")
(setf (get media_controller::VideoLength :definition-)
      "uint32[] videoLength
")



(provide :media_controller/VideoLength "42e2ca7a6872ea97a8d5f8554e713583")


