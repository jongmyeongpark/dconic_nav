;; Auto-generated. Do not edit!


(when (boundp 'node_alive::ListNodesAlive)
  (if (not (find-package "NODE_ALIVE"))
    (make-package "NODE_ALIVE"))
  (shadow 'ListNodesAlive (find-package "NODE_ALIVE")))
(unless (find-package "NODE_ALIVE::LISTNODESALIVE")
  (make-package "NODE_ALIVE::LISTNODESALIVE"))
(unless (find-package "NODE_ALIVE::LISTNODESALIVEREQUEST")
  (make-package "NODE_ALIVE::LISTNODESALIVEREQUEST"))
(unless (find-package "NODE_ALIVE::LISTNODESALIVERESPONSE")
  (make-package "NODE_ALIVE::LISTNODESALIVERESPONSE"))

(in-package "ROS")





(defclass node_alive::ListNodesAliveRequest
  :super ros::object
  :slots ())

(defmethod node_alive::ListNodesAliveRequest
  (:init
   (&key
    )
   (send-super :init)
   self)
  (:serialization-length
   ()
   (+
    0
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;;
   self)
  )

(defclass node_alive::ListNodesAliveResponse
  :super ros::object
  :slots (_tracked_nodes _seen_nodes _alive_nodes _listed_nodes ))

(defmethod node_alive::ListNodesAliveResponse
  (:init
   (&key
    ((:tracked_nodes __tracked_nodes) 0)
    ((:seen_nodes __seen_nodes) 0)
    ((:alive_nodes __alive_nodes) 0)
    ((:listed_nodes __listed_nodes) 0)
    )
   (send-super :init)
   (setq _tracked_nodes (round __tracked_nodes))
   (setq _seen_nodes (round __seen_nodes))
   (setq _alive_nodes (round __alive_nodes))
   (setq _listed_nodes (round __listed_nodes))
   self)
  (:tracked_nodes
   (&optional __tracked_nodes)
   (if __tracked_nodes (setq _tracked_nodes __tracked_nodes)) _tracked_nodes)
  (:seen_nodes
   (&optional __seen_nodes)
   (if __seen_nodes (setq _seen_nodes __seen_nodes)) _seen_nodes)
  (:alive_nodes
   (&optional __alive_nodes)
   (if __alive_nodes (setq _alive_nodes __alive_nodes)) _alive_nodes)
  (:listed_nodes
   (&optional __listed_nodes)
   (if __listed_nodes (setq _listed_nodes __listed_nodes)) _listed_nodes)
  (:serialization-length
   ()
   (+
    ;; uint32 _tracked_nodes
    4
    ;; uint32 _seen_nodes
    4
    ;; uint32 _alive_nodes
    4
    ;; uint32 _listed_nodes
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint32 _tracked_nodes
       (write-long _tracked_nodes s)
     ;; uint32 _seen_nodes
       (write-long _seen_nodes s)
     ;; uint32 _alive_nodes
       (write-long _alive_nodes s)
     ;; uint32 _listed_nodes
       (write-long _listed_nodes s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint32 _tracked_nodes
     (setq _tracked_nodes (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _seen_nodes
     (setq _seen_nodes (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _alive_nodes
     (setq _alive_nodes (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uint32 _listed_nodes
     (setq _listed_nodes (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(defclass node_alive::ListNodesAlive
  :super ros::object
  :slots ())

(setf (get node_alive::ListNodesAlive :md5sum-) "206cbe3e6af816a2d654986b53d52287")
(setf (get node_alive::ListNodesAlive :datatype-) "node_alive/ListNodesAlive")
(setf (get node_alive::ListNodesAlive :request) node_alive::ListNodesAliveRequest)
(setf (get node_alive::ListNodesAlive :response) node_alive::ListNodesAliveResponse)

(defmethod node_alive::ListNodesAliveRequest
  (:response () (instance node_alive::ListNodesAliveResponse :init)))

(setf (get node_alive::ListNodesAliveRequest :md5sum-) "206cbe3e6af816a2d654986b53d52287")
(setf (get node_alive::ListNodesAliveRequest :datatype-) "node_alive/ListNodesAliveRequest")
(setf (get node_alive::ListNodesAliveRequest :definition-)
      "---
uint32 tracked_nodes
uint32 seen_nodes
uint32 alive_nodes
uint32 listed_nodes
")

(setf (get node_alive::ListNodesAliveResponse :md5sum-) "206cbe3e6af816a2d654986b53d52287")
(setf (get node_alive::ListNodesAliveResponse :datatype-) "node_alive/ListNodesAliveResponse")
(setf (get node_alive::ListNodesAliveResponse :definition-)
      "---
uint32 tracked_nodes
uint32 seen_nodes
uint32 alive_nodes
uint32 listed_nodes
")



(provide :node_alive/ListNodesAlive "206cbe3e6af816a2d654986b53d52287")


