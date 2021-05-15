;; Auto-generated. Do not edit!


(when (boundp 'dr_ped::Obiettivo)
  (if (not (find-package "DR_PED"))
    (make-package "DR_PED"))
  (shadow 'Obiettivo (find-package "DR_PED")))
(unless (find-package "DR_PED::OBIETTIVO")
  (make-package "DR_PED::OBIETTIVO"))

(in-package "ROS")
;;//! \htmlinclude Obiettivo.msg.html


(defclass dr_ped::Obiettivo
  :super ros::object
  :slots (_sender _x _y _theta ))

(defmethod dr_ped::Obiettivo
  (:init
   (&key
    ((:sender __sender) 0)
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:theta __theta) 0.0)
    )
   (send-super :init)
   (setq _sender (round __sender))
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _theta (float __theta))
   self)
  (:sender
   (&optional __sender)
   (if __sender (setq _sender __sender)) _sender)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:theta
   (&optional __theta)
   (if __theta (setq _theta __theta)) _theta)
  (:serialization-length
   ()
   (+
    ;; int64 _sender
    8
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _theta
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int64 _sender
#+(or :alpha :irix6 :x86_64)
       (progn (sys::poke _sender (send s :buffer) (send s :count) :long) (incf (stream-count s) 8))
#-(or :alpha :irix6 :x86_64)
       (cond ((and (class _sender) (= (length (_sender . bv)) 2)) ;; bignum
              (write-long (ash (elt (_sender . bv) 0) 0) s)
              (write-long (ash (elt (_sender . bv) 1) -1) s))
             ((and (class _sender) (= (length (_sender . bv)) 1)) ;; big1
              (write-long (elt (_sender . bv) 0) s)
              (write-long (if (>= _sender 0) 0 #xffffffff) s))
             (t                                         ;; integer
              (write-long _sender s)(write-long (if (>= _sender 0) 0 #xffffffff) s)))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _theta
       (sys::poke _theta (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int64 _sender
#+(or :alpha :irix6 :x86_64)
      (setf _sender (prog1 (sys::peek buf ptr- :long) (incf ptr- 8)))
#-(or :alpha :irix6 :x86_64)
      (setf _sender (let ((b0 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4)))
                  (b1 (prog1 (sys::peek buf ptr- :integer) (incf ptr- 4))))
              (cond ((= b1 -1) b0)
                     ((and (= b1  0)
                           (<= lisp::most-negative-fixnum b0 lisp::most-positive-fixnum))
                      b0)
                    ((= b1  0) (make-instance bignum :size 1 :bv (integer-vector b0)))
                    (t (make-instance bignum :size 2 :bv (integer-vector b0 (ash b1 1)))))))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _theta
     (setq _theta (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get dr_ped::Obiettivo :md5sum-) "9f1847b7934a339de1227b8e056f487a")
(setf (get dr_ped::Obiettivo :datatype-) "dr_ped/Obiettivo")
(setf (get dr_ped::Obiettivo :definition-)
      "int64 sender
float32 x
float32 y
float32 theta


")



(provide :dr_ped/Obiettivo "9f1847b7934a339de1227b8e056f487a")


