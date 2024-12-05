;;;; mob.lisp

(in-package #:rshell.server)

(defclass mob ()
  ((level :initform nil :initarg :level :accessor mob-level :type (or level null))
   (x :initform 0 :initarg :x :accessor mob-x :type fixnum)
   (y :initform 0 :initarg :y :accessor mob-y :type fixnum)))

(defun move-mob (mob dx dy)
  (let ((level (mob-level mob))
        (nx (+ (mob-x mob) dx))
        (ny (+ (mob-y mob) dy)))
    (when (< nx 0)
      (return-from move-mob))
    (when (< ny 0)
      (return-from move-mob))
    (when (>= nx (level-max-x level))
      (return-from move-mob))
    (when (>= ny (level-max-y level))
      (return-from move-mob))
    
    (incf (mob-x mob) dx)
    (incf (mob-y mob) dy)))
