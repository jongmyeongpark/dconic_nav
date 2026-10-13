
(cl:in-package :asdf)

(defsystem "landmark-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :geometry_msgs-msg
               :sensor_msgs-msg
)
  :components ((:file "_package")
    (:file "VisionCheckResult" :depends-on ("_package_VisionCheckResult"))
    (:file "_package_VisionCheckResult" :depends-on ("_package"))
    (:file "VisionPose" :depends-on ("_package_VisionPose"))
    (:file "_package_VisionPose" :depends-on ("_package"))
    (:file "des_vector" :depends-on ("_package_des_vector"))
    (:file "_package_des_vector" :depends-on ("_package"))
    (:file "img_pose" :depends-on ("_package_img_pose"))
    (:file "_package_img_pose" :depends-on ("_package"))
    (:file "img_pose_result" :depends-on ("_package_img_pose_result"))
    (:file "_package_img_pose_result" :depends-on ("_package"))
    (:file "relocal" :depends-on ("_package_relocal"))
    (:file "_package_relocal" :depends-on ("_package"))
  ))