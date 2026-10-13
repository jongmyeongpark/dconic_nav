
(cl:in-package :asdf)

(defsystem "flyinglet_msgs-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "EventLog" :depends-on ("_package_EventLog"))
    (:file "_package_EventLog" :depends-on ("_package"))
  ))