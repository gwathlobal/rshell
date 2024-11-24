;;;; mob.lisp

(in-package #:rshell.server)

(defclass mob ()
  ((x :initform 0 :initarg :x :accessor mob-x)
   (y :initform 0 :initarg :y :accessor mob-y)))

(defun move-mob (mob dx dy)
  (incf (mob-x mob) dx)
  (incf (mob-y mob) dy))
