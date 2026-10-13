
(cl:in-package :asdf)

(defsystem "comm_app-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "state_msg" :depends-on ("_package_state_msg"))
    (:file "_package_state_msg" :depends-on ("_package"))
  ))