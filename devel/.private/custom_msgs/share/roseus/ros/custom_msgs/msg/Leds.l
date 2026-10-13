;; Auto-generated. Do not edit!


(when (boundp 'custom_msgs::Leds)
  (if (not (find-package "CUSTOM_MSGS"))
    (make-package "CUSTOM_MSGS"))
  (shadow 'Leds (find-package "CUSTOM_MSGS")))
(unless (find-package "CUSTOM_MSGS::LEDS")
  (make-package "CUSTOM_MSGS::LEDS"))

(in-package "ROS")
;;//! \htmlinclude Leds.msg.html


(defclass custom_msgs::Leds
  :super ros::object
  :slots (_colors _color_code ))

(defmethod custom_msgs::Leds
  (:init
   (&key
    ((:colors __colors) ())
    ((:color_code __color_code) 0)
    )
   (send-super :init)
   (setq _colors __colors)
   (setq _color_code (round __color_code))
   self)
  (:colors
   (&rest __colors)
   (if (keywordp (car __colors))
       (send* _colors __colors)
     (progn
       (if __colors (setq _colors (car __colors)))
       _colors)))
  (:color_code
   (&optional __color_code)
   (if __color_code (setq _color_code __color_code)) _color_code)
  (:serialization-length
   ()
   (+
    ;; custom_msgs/ColorRGB[] _colors
    (apply #'+ (send-all _colors :serialization-length)) 4
    ;; uint8 _color_code
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; custom_msgs/ColorRGB[] _colors
     (write-long (length _colors) s)
     (dolist (elem _colors)
       (send elem :serialize s)
       )
     ;; uint8 _color_code
       (write-byte _color_code s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; custom_msgs/ColorRGB[] _colors
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _colors (let (r) (dotimes (i n) (push (instance custom_msgs::ColorRGB :init) r)) r))
     (dolist (elem- _colors)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; uint8 _color_code
     (setq _color_code (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(setf (get custom_msgs::Leds :md5sum-) "5ff7e71a7764a4d0c3311bce28a43225")
(setf (get custom_msgs::Leds :datatype-) "custom_msgs/Leds")
(setf (get custom_msgs::Leds :definition-)
      "custom_msgs/ColorRGB[] colors
uint8 color_code
================================================================================
MSG: custom_msgs/ColorRGB
uint8 r
uint8 g
uint8 b
")



(provide :custom_msgs/Leds "5ff7e71a7764a4d0c3311bce28a43225")


