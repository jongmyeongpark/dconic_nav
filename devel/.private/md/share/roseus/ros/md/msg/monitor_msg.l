;; Auto-generated. Do not edit!


(when (boundp 'md::monitor_msg)
  (if (not (find-package "MD"))
    (make-package "MD"))
  (shadow 'monitor_msg (find-package "MD")))
(unless (find-package "MD::MONITOR_MSG")
  (make-package "MD::MONITOR_MSG"))

(in-package "ROS")
;;//! \htmlinclude monitor_msg.msg.html


(defclass md::monitor_msg
  :super ros::object
  :slots (_lPosiX _lPosiY _sTheta _sRealLinearVel _sRealAngularVel _sVoltIn _sLeftMotCur _sRightMotCur _byUS1 _byUS2 _byUS3 _byUS4 _byPlatStatus _byDocStatus _byLeftMotStatus _byRightMotStatus _lLeftMotPosi _lRightMotPosi _byLeftIOMonitor _byRightIOMonitor ))

(defmethod md::monitor_msg
  (:init
   (&key
    ((:lPosiX __lPosiX) 0)
    ((:lPosiY __lPosiY) 0)
    ((:sTheta __sTheta) 0)
    ((:sRealLinearVel __sRealLinearVel) 0)
    ((:sRealAngularVel __sRealAngularVel) 0)
    ((:sVoltIn __sVoltIn) 0)
    ((:sLeftMotCur __sLeftMotCur) 0)
    ((:sRightMotCur __sRightMotCur) 0)
    ((:byUS1 __byUS1) 0)
    ((:byUS2 __byUS2) 0)
    ((:byUS3 __byUS3) 0)
    ((:byUS4 __byUS4) 0)
    ((:byPlatStatus __byPlatStatus) 0)
    ((:byDocStatus __byDocStatus) 0)
    ((:byLeftMotStatus __byLeftMotStatus) 0)
    ((:byRightMotStatus __byRightMotStatus) 0)
    ((:lLeftMotPosi __lLeftMotPosi) 0)
    ((:lRightMotPosi __lRightMotPosi) 0)
    ((:byLeftIOMonitor __byLeftIOMonitor) 0)
    ((:byRightIOMonitor __byRightIOMonitor) 0)
    )
   (send-super :init)
   (setq _lPosiX (round __lPosiX))
   (setq _lPosiY (round __lPosiY))
   (setq _sTheta (round __sTheta))
   (setq _sRealLinearVel (round __sRealLinearVel))
   (setq _sRealAngularVel (round __sRealAngularVel))
   (setq _sVoltIn (round __sVoltIn))
   (setq _sLeftMotCur (round __sLeftMotCur))
   (setq _sRightMotCur (round __sRightMotCur))
   (setq _byUS1 (round __byUS1))
   (setq _byUS2 (round __byUS2))
   (setq _byUS3 (round __byUS3))
   (setq _byUS4 (round __byUS4))
   (setq _byPlatStatus (round __byPlatStatus))
   (setq _byDocStatus (round __byDocStatus))
   (setq _byLeftMotStatus (round __byLeftMotStatus))
   (setq _byRightMotStatus (round __byRightMotStatus))
   (setq _lLeftMotPosi (round __lLeftMotPosi))
   (setq _lRightMotPosi (round __lRightMotPosi))
   (setq _byLeftIOMonitor (round __byLeftIOMonitor))
   (setq _byRightIOMonitor (round __byRightIOMonitor))
   self)
  (:lPosiX
   (&optional __lPosiX)
   (if __lPosiX (setq _lPosiX __lPosiX)) _lPosiX)
  (:lPosiY
   (&optional __lPosiY)
   (if __lPosiY (setq _lPosiY __lPosiY)) _lPosiY)
  (:sTheta
   (&optional __sTheta)
   (if __sTheta (setq _sTheta __sTheta)) _sTheta)
  (:sRealLinearVel
   (&optional __sRealLinearVel)
   (if __sRealLinearVel (setq _sRealLinearVel __sRealLinearVel)) _sRealLinearVel)
  (:sRealAngularVel
   (&optional __sRealAngularVel)
   (if __sRealAngularVel (setq _sRealAngularVel __sRealAngularVel)) _sRealAngularVel)
  (:sVoltIn
   (&optional __sVoltIn)
   (if __sVoltIn (setq _sVoltIn __sVoltIn)) _sVoltIn)
  (:sLeftMotCur
   (&optional __sLeftMotCur)
   (if __sLeftMotCur (setq _sLeftMotCur __sLeftMotCur)) _sLeftMotCur)
  (:sRightMotCur
   (&optional __sRightMotCur)
   (if __sRightMotCur (setq _sRightMotCur __sRightMotCur)) _sRightMotCur)
  (:byUS1
   (&optional __byUS1)
   (if __byUS1 (setq _byUS1 __byUS1)) _byUS1)
  (:byUS2
   (&optional __byUS2)
   (if __byUS2 (setq _byUS2 __byUS2)) _byUS2)
  (:byUS3
   (&optional __byUS3)
   (if __byUS3 (setq _byUS3 __byUS3)) _byUS3)
  (:byUS4
   (&optional __byUS4)
   (if __byUS4 (setq _byUS4 __byUS4)) _byUS4)
  (:byPlatStatus
   (&optional __byPlatStatus)
   (if __byPlatStatus (setq _byPlatStatus __byPlatStatus)) _byPlatStatus)
  (:byDocStatus
   (&optional __byDocStatus)
   (if __byDocStatus (setq _byDocStatus __byDocStatus)) _byDocStatus)
  (:byLeftMotStatus
   (&optional __byLeftMotStatus)
   (if __byLeftMotStatus (setq _byLeftMotStatus __byLeftMotStatus)) _byLeftMotStatus)
  (:byRightMotStatus
   (&optional __byRightMotStatus)
   (if __byRightMotStatus (setq _byRightMotStatus __byRightMotStatus)) _byRightMotStatus)
  (:lLeftMotPosi
   (&optional __lLeftMotPosi)
   (if __lLeftMotPosi (setq _lLeftMotPosi __lLeftMotPosi)) _lLeftMotPosi)
  (:lRightMotPosi
   (&optional __lRightMotPosi)
   (if __lRightMotPosi (setq _lRightMotPosi __lRightMotPosi)) _lRightMotPosi)
  (:byLeftIOMonitor
   (&optional __byLeftIOMonitor)
   (if __byLeftIOMonitor (setq _byLeftIOMonitor __byLeftIOMonitor)) _byLeftIOMonitor)
  (:byRightIOMonitor
   (&optional __byRightIOMonitor)
   (if __byRightIOMonitor (setq _byRightIOMonitor __byRightIOMonitor)) _byRightIOMonitor)
  (:serialization-length
   ()
   (+
    ;; int32 _lPosiX
    4
    ;; int32 _lPosiY
    4
    ;; int16 _sTheta
    2
    ;; int16 _sRealLinearVel
    2
    ;; int16 _sRealAngularVel
    2
    ;; int16 _sVoltIn
    2
    ;; int16 _sLeftMotCur
    2
    ;; int16 _sRightMotCur
    2
    ;; uint8 _byUS1
    1
    ;; uint8 _byUS2
    1
    ;; uint8 _byUS3
    1
    ;; uint8 _byUS4
    1
    ;; uint8 _byPlatStatus
    1
    ;; uint8 _byDocStatus
    1
    ;; uint8 _byLeftMotStatus
    1
    ;; uint8 _byRightMotStatus
    1
    ;; int32 _lLeftMotPosi
    4
    ;; int32 _lRightMotPosi
    4
    ;; uint8 _byLeftIOMonitor
    1
    ;; uint8 _byRightIOMonitor
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _lPosiX
       (write-long _lPosiX s)
     ;; int32 _lPosiY
       (write-long _lPosiY s)
     ;; int16 _sTheta
       (write-word _sTheta s)
     ;; int16 _sRealLinearVel
       (write-word _sRealLinearVel s)
     ;; int16 _sRealAngularVel
       (write-word _sRealAngularVel s)
     ;; int16 _sVoltIn
       (write-word _sVoltIn s)
     ;; int16 _sLeftMotCur
       (write-word _sLeftMotCur s)
     ;; int16 _sRightMotCur
       (write-word _sRightMotCur s)
     ;; uint8 _byUS1
       (write-byte _byUS1 s)
     ;; uint8 _byUS2
       (write-byte _byUS2 s)
     ;; uint8 _byUS3
       (write-byte _byUS3 s)
     ;; uint8 _byUS4
       (write-byte _byUS4 s)
     ;; uint8 _byPlatStatus
       (write-byte _byPlatStatus s)
     ;; uint8 _byDocStatus
       (write-byte _byDocStatus s)
     ;; uint8 _byLeftMotStatus
       (write-byte _byLeftMotStatus s)
     ;; uint8 _byRightMotStatus
       (write-byte _byRightMotStatus s)
     ;; int32 _lLeftMotPosi
       (write-long _lLeftMotPosi s)
     ;; int32 _lRightMotPosi
       (write-long _lRightMotPosi s)
     ;; uint8 _byLeftIOMonitor
       (write-byte _byLeftIOMonitor s)
     ;; uint8 _byRightIOMonitor
       (write-byte _byRightIOMonitor s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _lPosiX
     (setq _lPosiX (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _lPosiY
     (setq _lPosiY (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int16 _sTheta
     (setq _sTheta (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _sRealLinearVel
     (setq _sRealLinearVel (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _sRealAngularVel
     (setq _sRealAngularVel (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _sVoltIn
     (setq _sVoltIn (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _sLeftMotCur
     (setq _sLeftMotCur (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _sRightMotCur
     (setq _sRightMotCur (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint8 _byUS1
     (setq _byUS1 (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _byUS2
     (setq _byUS2 (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _byUS3
     (setq _byUS3 (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _byUS4
     (setq _byUS4 (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _byPlatStatus
     (setq _byPlatStatus (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _byDocStatus
     (setq _byDocStatus (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _byLeftMotStatus
     (setq _byLeftMotStatus (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _byRightMotStatus
     (setq _byRightMotStatus (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; int32 _lLeftMotPosi
     (setq _lLeftMotPosi (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _lRightMotPosi
     (setq _lRightMotPosi (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint8 _byLeftIOMonitor
     (setq _byLeftIOMonitor (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _byRightIOMonitor
     (setq _byRightIOMonitor (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get md::monitor_msg :md5sum-) "265bab62db87a50551604683361197df")
(setf (get md::monitor_msg :datatype-) "md/monitor_msg")
(setf (get md::monitor_msg :definition-)
      "int32 lPosiX 
int32 lPosiY
int16 sTheta
int16 sRealLinearVel
int16 sRealAngularVel
int16 sVoltIn
int16 sLeftMotCur
int16 sRightMotCur
uint8 byUS1
uint8 byUS2
uint8 byUS3
uint8 byUS4
uint8 byPlatStatus
uint8 byDocStatus
uint8 byLeftMotStatus
uint8 byRightMotStatus
int32 lLeftMotPosi
int32 lRightMotPosi
uint8 byLeftIOMonitor
uint8 byRightIOMonitor

")



(provide :md/monitor_msg "265bab62db87a50551604683361197df")


