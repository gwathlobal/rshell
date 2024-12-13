;;;; mob.lisp

(in-package #:rshell.server)

(defparameter *mobs* (make-array 0 :element-type 'mob :adjustable t))

(defconstant +mob-type-player+ 0)

(defparameter *mob-types* (make-array 0 :element-type 'mob-type :adjustable t))

(defclass mob-type ()
  ((id :initarg :id :reader mob-type-id :type fixnum)))

(defclass mob ()
  ((id :reader id :type fixnum)
   (mob-type :initarg :mob-type :accessor mob-type-id :type fixnum)
   (level :initform nil :initarg :level :accessor mob-level :type (or level null))
   (x :initform 0 :initarg :x :accessor mob-x :type fixnum)
   (y :initform 0 :initarg :y :accessor mob-y :type fixnum)))

(defmethod initialize-instance :after ((mob mob) &key)
  (with-slots (id) mob
    (setf id (find-free-id *mobs*))
    (setf (aref *mobs* id) mob)))

(defun get-mob-by-id (mob-id)
  (aref *mobs* mob-id))

(defmethod initialize-instance :after ((mob-type mob-type) &key)
  (with-slots (id) mob-type
    (let ((container *mob-types*))
      (set-and-adjust-container id mob-type container))))

(make-instance 'mob-type :id +mob-type-player+)