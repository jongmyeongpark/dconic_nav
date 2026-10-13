
(cl:in-package :asdf)

(defsystem "comm_app-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "start_drive" :depends-on ("_package_start_drive"))
    (:file "_package_start_drive" :depends-on ("_package"))
  ))