; Auto-generated. Do not edit!


(cl:in-package dr_ped-msg)


;//! \htmlinclude Obiettivo.msg.html

(cl:defclass <Obiettivo> (roslisp-msg-protocol:ros-message)
  ((sender
    :reader sender
    :initarg :sender
    :type cl:integer
    :initform 0)
   (x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (theta
    :reader theta
    :initarg :theta
    :type cl:float
    :initform 0.0))
)

(cl:defclass Obiettivo (<Obiettivo>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Obiettivo>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Obiettivo)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name dr_ped-msg:<Obiettivo> is deprecated: use dr_ped-msg:Obiettivo instead.")))

(cl:ensure-generic-function 'sender-val :lambda-list '(m))
(cl:defmethod sender-val ((m <Obiettivo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dr_ped-msg:sender-val is deprecated.  Use dr_ped-msg:sender instead.")
  (sender m))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <Obiettivo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dr_ped-msg:x-val is deprecated.  Use dr_ped-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <Obiettivo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dr_ped-msg:y-val is deprecated.  Use dr_ped-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'theta-val :lambda-list '(m))
(cl:defmethod theta-val ((m <Obiettivo>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader dr_ped-msg:theta-val is deprecated.  Use dr_ped-msg:theta instead.")
  (theta m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Obiettivo>) ostream)
  "Serializes a message object of type '<Obiettivo>"
  (cl:let* ((signed (cl:slot-value msg 'sender)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'theta))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Obiettivo>) istream)
  "Deserializes a message object of type '<Obiettivo>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'sender) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'theta) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Obiettivo>)))
  "Returns string type for a message object of type '<Obiettivo>"
  "dr_ped/Obiettivo")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Obiettivo)))
  "Returns string type for a message object of type 'Obiettivo"
  "dr_ped/Obiettivo")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Obiettivo>)))
  "Returns md5sum for a message object of type '<Obiettivo>"
  "9f1847b7934a339de1227b8e056f487a")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Obiettivo)))
  "Returns md5sum for a message object of type 'Obiettivo"
  "9f1847b7934a339de1227b8e056f487a")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Obiettivo>)))
  "Returns full string definition for message of type '<Obiettivo>"
  (cl:format cl:nil "int64 sender~%float32 x~%float32 y~%float32 theta~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Obiettivo)))
  "Returns full string definition for message of type 'Obiettivo"
  (cl:format cl:nil "int64 sender~%float32 x~%float32 y~%float32 theta~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Obiettivo>))
  (cl:+ 0
     8
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Obiettivo>))
  "Converts a ROS message object to a list"
  (cl:list 'Obiettivo
    (cl:cons ':sender (sender msg))
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':theta (theta msg))
))
