
(cl:in-package :asdf)

(defsystem "wp_data_transfer-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "wpdata" :depends-on ("_package_wpdata"))
    (:file "_package_wpdata" :depends-on ("_package"))
  ))