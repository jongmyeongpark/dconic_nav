;; Auto-generated. Do not edit!


(when (boundp 'md::vel_msg)
  (if (not (find-package "MD"))
    (make-package "MD"))
  (shadow 'vel_msg (find-package "MD")))
(unless (find-package "MD::VEL_MSG")
  (make-package "MD::VEL_MSG"))

(in-package "ROS")
;;//! \htmlinclude vel_msg.msg.html


(defclass md::vel_msg
  :super ros::object
  :slots (_nLinear _nAngular _byResetOdometry _byResetAngle _byResetAlarm ))

(defmethod md::vel_msg
  (:init
   (&key
    ((:nLinear __nLinear) 0)
    ((:nAngular __nAngular) 0)
    ((:byResetOdometry __byResetOdometry) 0)
    ((:byResetAngle __byResetAngle) 0)
    ((:byResetAlarm __byResetAlarm) 0)
    )
   (send-super :init)
   (setq _nLinear (round __nLinear))
   (setq _nAngular (round __nAngular))
   (setq _byResetOdometry (round __byResetOdometry))
   (setq _byResetAngle (round __byResetAngle))
   (setq _byResetAlarm (round __byResetAlarm))
   self)
  (:nLinear
   (&optional __nLinear)
   (if __nLinear (setq _nLinear __nLinear)) _nLinear)
  (:nAngular
   (&optional __nAngular)
   (if __nAngular (setq _nAngular __nAngular)) _nAngular)
  (:byResetOdometry
   (&optional __byResetOdometry)
   (if __byResetOdometry (setq _byResetOdometry __byResetOdometry)) _byResetOdometry)
  (:byResetAngle
   (&optional __byResetAngle)
   (if __byResetAngle (setq _byResetAngle __byResetAngle)) _byResetAngle)
  (:byResetAlarm
   (&optional __byResetAlarm)
   (if __byResetAlarm (setq _byResetAlarm __byResetAlarm)) _byResetAlarm)
  (:serialization-length
   ()
   (+
    ;; int32 _nLinear
    4
    ;; int32 _nAngular
    4
    ;; int8 _byResetOdometry
    1
    ;; int8 _byResetAngle
    1
    ;; int8 _byResetAlarm
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _nLinear
       (write-long _nLinear s)
     ;; int32 _nAngular
       (write-long _nAngular s)
     ;; int8 _byResetOdometry
       (write-byte _byResetOdometry s)
     ;; int8 _byResetAngle
       (write-byte _byResetAngle s)
     ;; int8 _byResetAlarm
       (write-byte _byResetAlarm s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _nLinear
     (setq _nLinear (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _nAngular
     (setq _nAngular (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int8 _byResetOdometry
     (setq _byResetOdometry (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _byResetOdometry 127) (setq _byResetOdometry (- _byResetOdometry 256)))
   ;; int8 _byResetAngle
     (setq _byResetAngle (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _byResetAngle 127) (setq _byResetAngle (- _byResetAngle 256)))
   ;; int8 _byResetAlarm
     (setq _byResetAlarm (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _byResetAlarm 127) (setq _byResetAlarm (- _byResetAlarm 256)))
   ;;
   self)
  )

(setf (get md::vel_msg :md5sum-) "e52979e2ff6a0ff38b6f29b2d215648d")
(setf (get md::vel_msg :datatype-) "md/vel_msg")
(setf (get md::vel_msg :definition-)
      "int32 nLinear
int32 nAngular
int8 byResetOdometry
int8 byResetAngle
int8 byResetAlarm

")



(provide :md/vel_msg "e52979e2ff6a0ff38b6f29b2d215648d")


