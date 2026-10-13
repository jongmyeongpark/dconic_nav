;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::LedRGBColors)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'LedRGBColors (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::LEDRGBCOLORS")
  (make-package "CUSTOM_MSGS::LEDRGBCOLORS"))

(in-package "ROS")
;;//! \htmlinclude LedRGBColors.msg.html


(defclass custom_msgs::LedRGBColors
  :super ros::object
  :slots (_values _color ))

(defmethod custom_msgs::LedRGBColors
  (:init
   (&key
    ((:values __values) (make-array 0 :initial-element 0 :element-type :char))
    ((:color __color) 0)
    )
   (send-super :init)
   (setq _values __values)
   (setq _color (round __color))
   self)
  (:values
   (&optional __values)
   (if __values (setq _values __values)) _values)
  (:color
   (&optional __color)
   (if __color (setq _color __color)) _color)
  (:serialization-length
   ()
   (+
    ;; uint8[] _values
    (* 1    (length _values)) 4
    ;; uint8 _color
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8[] _values
     (write-long (length _values) s)
     (princ _values s)
     ;; uint8 _color
       (write-byte _color s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8[] _values
   (let ((n (sys::peek buf ptr- :integer))) (incf ptr- 4)
     (setq _values (make-array n :element-type :char))
     (replace _values buf :start2 ptr-) (incf ptr- n))
   ;; uint8 _color
     (setq _color (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get custom_msgs::LedRGBColors :md5sum-) "2979289bf62edcae7300f6f9812c4e15")
(setf (get custom_msgs::LedRGBColors :datatype-) "custom_msgs/LedRGBColors")
(setf (get custom_msgs::LedRGBColors :definition-)
      "uint8[] values
uint8 color
")



(provide :custom_msgs/LedRGBColors "2979289bf62edcae7300f6f9812c4e15")


