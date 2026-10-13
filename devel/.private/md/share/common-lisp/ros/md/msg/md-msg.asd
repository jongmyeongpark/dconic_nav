
(cl:in-package :asdf)

(defsystem "md-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "monitor_msg" :depends-on ("_package_monitor_msg"))
    (:file "_package_monitor_msg" :depends-on ("_package"))
    (:file "vel_msg" :depends-on ("_package_vel_msg"))
    (:file "_package_vel_msg" :depends-on ("_package"))
  ))