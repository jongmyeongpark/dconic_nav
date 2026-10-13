
(cl:in-package :asdf)

(defsystem "media_controller-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "CongestionLevel" :depends-on ("_package_CongestionLevel"))
    (:file "_package_CongestionLevel" :depends-on ("_package"))
    (:file "IntArray" :depends-on ("_package_IntArray"))
    (:file "_package_IntArray" :depends-on ("_package"))
    (:file "VideoLength" :depends-on ("_package_VideoLength"))
    (:file "_package_VideoLength" :depends-on ("_package"))
    (:file "VideoPriority" :depends-on ("_package_VideoPriority"))
    (:file "_package_VideoPriority" :depends-on ("_package"))
  ))