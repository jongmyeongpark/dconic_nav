;; Auto-generated. Do not edit!


(when (boundp 'media_controller::video_info)
  (if (not (find-package "MEDIA_CONTROLLER"))
    (make-package "MEDIA_CONTROLLER"))
  (shadow 'video_info (find-package "MEDIA_CONTROLLER")))
(unless (find-package "MEDIA_CONTROLLER::VIDEO_INFO")
  (make-package "MEDIA_CONTROLLER::VIDEO_INFO"))
(unless (find-package "MEDIA_CONTROLLER::VIDEO_INFOREQUEST")
  (make-package "MEDIA_CONTROLLER::VIDEO_INFOREQUEST"))
(unless (find-package "MEDIA_CONTROLLER::VIDEO_INFORESPONSE")
  (make-package "MEDIA_CONTROLLER::VIDEO_INFORESPONSE"))

(in-package "ROS")





(defclass media_controller::video_infoRequest
  :super ros::object
  :slots (_rq ))

(defmethod media_controller::video_infoRequest
  (:init
   (&key
    ((:rq __rq) nil)
    )
   (send-super :init)
   (setq _rq __rq)
   self)
  (:rq
   (&optional (__rq :null))
   (if (not (eq __rq :null)) (setq _rq __rq)) _rq)
  (:serialization-length
   ()
   (+
    ;; bool _rq
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _rq
       (if _rq (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _rq
     (setq _rq (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(defclass media_controller::video_infoResponse
  :super ros::object
  :slots (_videoLength _videoPriority ))

(defmethod media_controller::video_infoResponse
  (:init
   (&key
    ((:videoLength __videoLength) (make-array 0 :initial-element 0 :element-type :integer))
    ((:videoPriority __videoPriority) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _videoLength __videoLength)
   (setq _videoPriority __videoPriority)
   self)
  (:videoLength
   (&optional __videoLength)
   (if __videoLength (setq _videoLength __videoLength)) _videoLength)
  (:videoPriority
   (&optional __videoPriority)
   (if __videoPriority (setq _videoPriority __videoPriority)) _videoPriority)
  (:serialization-length
   ()
   (+
    ;; int16[] _videoLength
    (* 2    (length _videoLength)) 4
    ;; int16[] _videoPriority
    (* 2    (length _videoPriority)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int16[] _videoLength
     (write-long (length _videoLength) s)
     (dotimes (i (length _videoLength))
       (write-word (elt _videoLength i) s)
       )
     ;; int16[] _videoPriority
     (write-long (length _videoPriority) s)
     (dotimes (i (length _videoPriority))
       (write-word (elt _videoPriority i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int16[] _videoLength
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _videoLength (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _videoLength i) (sys::peek buf ptr- :short)) (incf ptr- 2)
     ))
   ;; int16[] _videoPriority
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _videoPriority (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _videoPriority i) (sys::peek buf ptr- :short)) (incf ptr- 2)
     ))
   ;;
   self)
  )

(defclass media_controller::video_info
  :super ros::object
  :slots ())

(setf (get media_controller::video_info :md5sum-) "c9046fbcc43b98494792b0b94103fa5f")
(setf (get media_controller::video_info :datatype-) "media_controller/video_info")
(setf (get media_controller::video_info :request) media_controller::video_infoRequest)
(setf (get media_controller::video_info :response) media_controller::video_infoResponse)

(defmethod media_controller::video_infoRequest
  (:response () (instance media_controller::video_infoResponse :init)))

(setf (get media_controller::video_infoRequest :md5sum-) "c9046fbcc43b98494792b0b94103fa5f")
(setf (get media_controller::video_infoRequest :datatype-) "media_controller/video_infoRequest")
(setf (get media_controller::video_infoRequest :definition-)
      "# Request video info
bool rq
---
int16[] videoLength
int16[] videoPriority
")

(setf (get media_controller::video_infoResponse :md5sum-) "c9046fbcc43b98494792b0b94103fa5f")
(setf (get media_controller::video_infoResponse :datatype-) "media_controller/video_infoResponse")
(setf (get media_controller::video_infoResponse :definition-)
      "# Request video info
bool rq
---
int16[] videoLength
int16[] videoPriority
")



(provide :media_controller/video_info "c9046fbcc43b98494792b0b94103fa5f")


