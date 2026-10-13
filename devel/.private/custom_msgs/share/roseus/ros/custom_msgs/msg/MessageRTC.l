;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::MessageRTC)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'MessageRTC (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::MESSAGERTC")
  (make-package "CUSTOM_MSGS::MESSAGERTC"))

(in-package "ROS")
;;//! \htmlinclude MessageRTC.msg.html


(defclass custom_msgs::MessageRTC
  :super ros::object
  :slots (_action _sender _sdp _type _candidate _sdpMid _sdpMLineIndex _stream ))

(defmethod custom_msgs::MessageRTC
  (:init
   (&key
    ((:action __action) "")
    ((:sender __sender) "")
    ((:sdp __sdp) "")
    ((:type __type) "")
    ((:candidate __candidate) "")
    ((:sdpMid __sdpMid) "")
    ((:sdpMLineIndex __sdpMLineIndex) 0)
    ((:stream __stream) "")
    )
   (send-super :init)
   (setq _action (string __action))
   (setq _sender (string __sender))
   (setq _sdp (string __sdp))
   (setq _type (string __type))
   (setq _candidate (string __candidate))
   (setq _sdpMid (string __sdpMid))
   (setq _sdpMLineIndex (round __sdpMLineIndex))
   (setq _stream (string __stream))
   self)
  (:action
   (&optional __action)
   (if __action (setq _action __action)) _action)
  (:sender
   (&optional __sender)
   (if __sender (setq _sender __sender)) _sender)
  (:sdp
   (&optional __sdp)
   (if __sdp (setq _sdp __sdp)) _sdp)
  (:type
   (&optional __type)
   (if __type (setq _type __type)) _type)
  (:candidate
   (&optional __candidate)
   (if __candidate (setq _candidate __candidate)) _candidate)
  (:sdpMid
   (&optional __sdpMid)
   (if __sdpMid (setq _sdpMid __sdpMid)) _sdpMid)
  (:sdpMLineIndex
   (&optional __sdpMLineIndex)
   (if __sdpMLineIndex (setq _sdpMLineIndex __sdpMLineIndex)) _sdpMLineIndex)
  (:stream
   (&optional __stream)
   (if __stream (setq _stream __stream)) _stream)
  (:serialization-length
   ()
   (+
    ;; string _action
    4 (length _action)
    ;; string _sender
    4 (length _sender)
    ;; string _sdp
    4 (length _sdp)
    ;; string _type
    4 (length _type)
    ;; string _candidate
    4 (length _candidate)
    ;; string _sdpMid
    4 (length _sdpMid)
    ;; int32 _sdpMLineIndex
    4
    ;; string _stream
    4 (length _stream)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _action
       (write-long (length _action) s) (princ _action s)
     ;; string _sender
       (write-long (length _sender) s) (princ _sender s)
     ;; string _sdp
       (write-long (length _sdp) s) (princ _sdp s)
     ;; string _type
       (write-long (length _type) s) (princ _type s)
     ;; string _candidate
       (write-long (length _candidate) s) (princ _candidate s)
     ;; string _sdpMid
       (write-long (length _sdpMid) s) (princ _sdpMid s)
     ;; int32 _sdpMLineIndex
       (write-long _sdpMLineIndex s)
     ;; string _stream
       (write-long (length _stream) s) (princ _stream s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _action
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _action (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _sender
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _sender (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _sdp
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _sdp (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _candidate
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _candidate (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _sdpMid
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _sdpMid (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _sdpMLineIndex
     (setq _sdpMLineIndex (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _stream
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _stream (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get custom_msgs::MessageRTC :md5sum-) "d26b43f04c953b94dfeecbe80ac33399")
(setf (get custom_msgs::MessageRTC :datatype-) "custom_msgs/MessageRTC")
(setf (get custom_msgs::MessageRTC :definition-)
      "string action
string sender
string sdp 
string type
string candidate
string sdpMid
int32 sdpMLineIndex
string stream

")



(provide :custom_msgs/MessageRTC "d26b43f04c953b94dfeecbe80ac33399")


