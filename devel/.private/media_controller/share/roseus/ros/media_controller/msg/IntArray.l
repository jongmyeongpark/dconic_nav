;; Auto-generated. Do not edit!


(when (boundp 'media_controller::IntArray)
  (if (not (find-package "MEDIA_CONTROLLER"))
    (make-package "MEDIA_CONTROLLER"))
  (shadow 'IntArray (find-package "MEDIA_CONTROLLER")))
(unless (find-package "MEDIA_CONTROLLER::INTARRAY")
  (make-package "MEDIA_CONTROLLER::INTARRAY"))

(in-package "ROS")
;;//! \htmlinclude IntArray.msg.html


(defclass media_controller::IntArray
  :super ros::object
  :slots (_intArray ))

(defmethod media_controller::IntArray
  (:init
   (&key
    ((:intArray __intArray) (make-array 0 :initial-element 0 :element-type :integer))
    )
   (send-super :init)
   (setq _intArray __intArray)
   self)
  (:intArray
   (&optional __intArray)
   (if __intArray (setq _intArray __intArray)) _intArray)
  (:serialization-length
   ()
   (+
    ;; uint32[] _intArray
    (* 4    (length _intArray)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32[] _intArray
     (write-long (length _intArray) s)
     (dotimes (i (length _intArray))
       (write-long (elt _intArray i) s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32[] _intArray
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _intArray (instantiate integer-vector n))
     (dotimes (i n)
     (setf (elt _intArray i) (sys::peek buf ptr- :integer)) (incf ptr- 4)
     ))
   ;;
   self)
  )

(setf (get media_controller::IntArray :md5sum-) "76f7d7f74f2e8dcdd4ba703281016923")
(setf (get media_controller::IntArray :datatype-) "media_controller/IntArray")
(setf (get media_controller::IntArray :definition-)
      "uint32[] intArray
")



(provide :media_controller/IntArray "76f7d7f74f2e8dcdd4ba703281016923")


