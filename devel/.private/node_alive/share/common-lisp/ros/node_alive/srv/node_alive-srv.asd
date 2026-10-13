
(cl:in-package :asdf)

(defsystem "node_alive-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ListNodesAlive" :depends-on ("_package_ListNodesAlive"))
    (:file "_package_ListNodesAlive" :depends-on ("_package"))
  ))