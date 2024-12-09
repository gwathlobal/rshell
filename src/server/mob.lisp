;;;; mob.lisp

(in-package #:rshell.server)

(defparameter *mobs* (make-array 0 :element-type 'mob :adjustable t))

(defun find-free-id (entity-container-array)
  (loop for i from 0 below (length entity-container-array)
        unless (aref entity-container-array i)
        do (return-from find-free-id i))
  (adjust-array entity-container-array (list (1+ (length entity-container-array))))
  (1- (length entity-container-array)))

(defclass mob ()
  ((id :initform (find-free-id *mobs*) :reader id :type fixnum)
   (mob-type :initarg :mob-type :accessor mob-type :type keyword
             :documentation 
             "Available types:
                :mob-type-player
                :mob-type-enemy
             ")
   (level :initform nil :initarg :level :accessor mob-level :type (or level null))
   (x :initform 0 :initarg :x :accessor mob-x :type fixnum)
   (y :initform 0 :initarg :y :accessor mob-y :type fixnum)))

(defun get-mob-by-id (mob-id)
  (aref *mobs* mob-id))


