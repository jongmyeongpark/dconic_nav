;; Auto-generated. Do not edit!


(when (boundp 'flyinglet_msgs::EventLog)
  (if (not (find-package "FLYINGLET_MSGS"))
    (make-package "FLYINGLET_MSGS"))
  (shadow 'EventLog (find-package "FLYINGLET_MSGS")))
(unless (find-package "FLYINGLET_MSGS::EVENTLOG")
  (make-package "FLYINGLET_MSGS::EVENTLOG"))

(in-package "ROS")
;;//! \htmlinclude EventLog.msg.html


(intern "*STATE_READY*" (find-package "FLYINGLET_MSGS::EVENTLOG"))
(shadow '*STATE_READY* (find-package "FLYINGLET_MSGS::EVENTLOG"))
(defconstant flyinglet_msgs::EventLog::*STATE_READY* 0)
(intern "*STATE_START*" (find-package "FLYINGLET_MSGS::EVENTLOG"))
(shadow '*STATE_START* (find-package "FLYINGLET_MSGS::EVENTLOG"))
(defconstant flyinglet_msgs::EventLog::*STATE_START* 1)
(intern "*STATE_RESUME*" (find-package "FLYINGLET_MSGS::EVENTLOG"))
(shadow '*STATE_RESUME* (find-package "FLYINGLET_MSGS::EVENTLOG"))
(defconstant flyinglet_msgs::EventLog::*STATE_RESUME* 2)
(intern "*STATE_PAUSE*" (find-package "FLYINGLET_MSGS::EVENTLOG"))
(shadow '*STATE_PAUSE* (find-package "FLYINGLET_MSGS::EVENTLOG"))
(defconstant flyinglet_msgs::EventLog::*STATE_PAUSE* 3)
(intern "*STATE_STOP*" (find-package "FLYINGLET_MSGS::EVENTLOG"))
(shadow '*STATE_STOP* (find-package "FLYINGLET_MSGS::EVENTLOG"))
(defconstant flyinglet_msgs::EventLog::*STATE_STOP* 4)
(intern "*STATE_FINISH*" (find-package "FLYINGLET_MSGS::EVENTLOG"))
(shadow '*STATE_FINISH* (find-package "FLYINGLET_MSGS::EVENTLOG"))
(defconstant flyinglet_msgs::EventLog::*STATE_FINISH* 5)
(intern "*STATE_ERROR*" (find-package "FLYINGLET_MSGS::EVENTLOG"))
(shadow '*STATE_ERROR* (find-package "FLYINGLET_MSGS::EVENTLOG"))
(defconstant flyinglet_msgs::EventLog::*STATE_ERROR* 6)

(defun flyinglet_msgs::EventLog-to-symbol (const)
  (cond
        ((= const 0) 'flyinglet_msgs::EventLog::*STATE_READY*)
        ((= const 1) 'flyinglet_msgs::EventLog::*STATE_START*)
        ((= const 2) 'flyinglet_msgs::EventLog::*STATE_RESUME*)
        ((= const 3) 'flyinglet_msgs::EventLog::*STATE_PAUSE*)
        ((= const 4) 'flyinglet_msgs::EventLog::*STATE_STOP*)
        ((= const 5) 'flyinglet_msgs::EventLog::*STATE_FINISH*)
        ((= const 6) 'flyinglet_msgs::EventLog::*STATE_ERROR*)
        (t nil)))

(defclass flyinglet_msgs::EventLog
  :super ros::object
  :slots (_source _type _data _action _state ))

(defmethod flyinglet_msgs::EventLog
  (:init
   (&key
    ((:source __source) "")
    ((:type __type) "")
    ((:data __data) "")
    ((:action __action) "")
    ((:state __state) 0)
    )
   (send-super :init)
   (setq _source (string __source))
   (setq _type (string __type))
   (setq _data (string __data))
   (setq _action (string __action))
   (setq _state (round __state))
   self)
  (:source
   (&optional __source)
   (if __source (setq _source __source)) _source)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:data
   (&optional __data)
   (if __data (setq _data __data)) _data)
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:state
   (&optional __state)
   (if __state (setq _state __state)) _state)
  (:serialization-length
   ()
   (+
    ;; string _source
    4 (length _source)
    ;; string _type
    4 (length _type)
    ;; string _data
    4 (length _data)
    ;; string _action
    4 (length _action)
    ;; uint8 _state
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _source
       (write-long (length _source) s) (princ _source s)
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; string _data
       (write-long (length _data) s) (princ _data s)
     ;; string _action
       (write-long (length _action) s) (princ _action s)
     ;; uint8 _state
       (write-byte _state s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _source
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _source (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _data
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _data (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _action
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _action (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint8 _state
     (setq _state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get flyinglet_msgs::EventLog :md5sum-) "af7df165f1ee3dfe98782f8478c6a586")
(setf (get flyinglet_msgs::EventLog :datatype-) "flyinglet_msgs/EventLog")
(setf (get flyinglet_msgs::EventLog :definition-)
      "string source

string type # ???

string data # json

string action

uint8 STATE_READY = 0
uint8 STATE_START = 1
uint8 STATE_RESUME = 2
uint8 STATE_PAUSE = 3
uint8 STATE_STOP = 4
uint8 STATE_FINISH = 5
uint8 STATE_ERROR = 6

uint8 state
")



(provide :flyinglet_msgs/EventLog "af7df165f1ee3dfe98782f8478c6a586")


