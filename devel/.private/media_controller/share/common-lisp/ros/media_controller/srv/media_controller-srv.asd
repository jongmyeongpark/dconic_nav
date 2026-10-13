
(cl:in-package :asdf)

(defsystem "media_controller-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "video_info" :depends-on ("_package_video_info"))
    (:file "_package_video_info" :depends-on ("_package"))
  ))