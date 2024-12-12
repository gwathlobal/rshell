;;;; mob.lisp

(in-package #:rshell.server)

(defparameter *mobs* (make-array 0 :element-type 'mob :adjustable t))

(defconstant +mob-type-player+ 0)

(defparameter *mob-types* (make-array 0 :element-type 'mob-type :adjustable t))

(defclass mob-type ()
  ((id :initarg :id :reader mob-type-id :type fixnum)))

(defclass mob ()
  ((id :initform (find-free-id *mobs*) :reader id :type fixnum)
   (mob-type :initarg :mob-type :accessor mob-type-id :type fixnum)
   (level :initform nil :initarg :level :accessor mob-level :type (or level null))
   (x :initform 0 :initarg :x :accessor mob-x :type fixnum)
   (y :initform 0 :initarg :y :accessor mob-y :type fixnum)))

(defmethod initialize-instance :after ((mob mob) &key)
  (with-slots (id) mob
    (setf (aref *mobs* id) mob)))

(defun find-free-id (entity-container-array)
  (loop for i from 0 below (length entity-container-array)
        unless (aref entity-container-array i)
        do (return-from find-free-id i))
  (adjust-array entity-container-array (list (1+ (length entity-container-array))))
  (1- (length entity-container-array)))

(defun get-mob-by-id (mob-id)
  (aref *mobs* mob-id))



(defun add-mob-type (mob-type)
  (when (>= (mob-type-id mob-type) (1- (length *mob-types*)))
    (adjust-array *mob-types* (list (1+ (length *mob-types*)))))
  (aref *mob-types* (mob-type-id mob-type)))

(add-mob-type (make-instance 'mob-type :id +mob-type-player+))