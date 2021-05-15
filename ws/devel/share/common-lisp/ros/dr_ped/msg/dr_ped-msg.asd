
(cl:in-package :asdf)

(defsystem "dr_ped-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Obiettivo" :depends-on ("_package_Obiettivo"))
    (:file "_package_Obiettivo" :depends-on ("_package"))
  ))