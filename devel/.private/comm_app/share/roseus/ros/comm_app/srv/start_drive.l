;; Auto-generated. Do not edit!


(when (boundp 'comm_app::start_drive)
  (if (not (find-package "COMM_APP"))
    (make-package "COMM_APP"))
  (shadow 'start_drive (find-package "COMM_APP")))
(unless (find-package "COMM_APP::START_DRIVE")
  (make-package "COMM_APP::START_DRIVE"))
(unless (find-package "COMM_APP::START_DRIVEREQUEST")
  (make-package "COMM_APP::START_DRIVEREQUEST"))
(unless (find-package "COMM_APP::START_DRIVERESPONSE")
  (make-package "COMM_APP::START_DRIVERESPONSE"))

(in-package "ROS")





(defclass comm_app::start_driveRequest
  :super ros::object
  :slots (_str ))

(defmethod comm_app::start_driveRequest
  (:init
   (&key
    ((:str __str) "")
    )
   (send-super :init)
   (setq _str (string __str))
   self)
  (:str
   (&optional __str)
   (if __str (setq _str __str)) _str)
  (:serialization-length
   ()
   (+
    ;; string _str
    4 (length _str)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _str
       (write-long (length _str) s) (princ _str s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _str
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _str (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass comm_app::start_driveResponse
  :super ros::object
  :slots (_str ))

(defmethod comm_app::start_driveResponse
  (:init
   (&key
    ((:str __str) "")
    )
   (send-super :init)
   (setq _str (string __str))
   self)
  (:str
   (&optional __str)
   (if __str (setq _str __str)) _str)
  (:serialization-length
   ()
   (+
    ;; string _str
    4 (length _str)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _str
       (write-long (length _str) s) (princ _str s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _str
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _str (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(defclass comm_app::start_drive
  :super ros::object
  :slots ())

(setf (get comm_app::start_drive :md5sum-) "671f8e4998eaec79f1c47e339dfd527b")
(setf (get comm_app::start_drive :datatype-) "comm_app/start_drive")
(setf (get comm_app::start_drive :request) comm_app::start_driveRequest)
(setf (get comm_app::start_drive :response) comm_app::start_driveResponse)

(defmethod comm_app::start_driveRequest
  (:response () (instance comm_app::start_driveResponse :init)))

(setf (get comm_app::start_driveRequest :md5sum-) "671f8e4998eaec79f1c47e339dfd527b")
(setf (get comm_app::start_driveRequest :datatype-) "comm_app/start_driveRequest")
(setf (get comm_app::start_driveRequest :definition-)
      "string str
---
string str
")

(setf (get comm_app::start_driveResponse :md5sum-) "671f8e4998eaec79f1c47e339dfd527b")
(setf (get comm_app::start_driveResponse :datatype-) "comm_app/start_driveResponse")
(setf (get comm_app::start_driveResponse :definition-)
      "string str
---
string str
")



(provide :comm_app/start_drive "671f8e4998eaec79f1c47e339dfd527b")


