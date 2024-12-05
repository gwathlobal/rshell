;;;; level.lisp

(in-package #:rshell.server)

(defparameter *world* nil)

(defclass world ()
  ((cur-level :initform nil :initarg :cur-level :accessor world-cur-level :type (or level null))))

(defclass level ()
  ((terrain :initform nil :initarg terrain :accessor level-terrain :type (or array null))
   (max-x :initform 50 :initarg :max-x :accessor level-max-x :type fixnum)
   (max-y :initform 50 :initarg :max-y :accessor level-max-y :type fixnum)))

(defun generate-random-level (level)
  (with-slots (terrain max-x max-y) level
    (setf terrain (make-array (list max-x max-y) 
                              :element-type 'keyword
                              :initial-element :terrain-type-test-floor))
    (loop with rnd = (make-random-state)
          for x from 0 below (array-dimension terrain 0) do
             (loop for y from 0 below (array-dimension terrain 1) 
                   do
                      (when (< (random 100) 30)
                        (setf (aref terrain x y) :terrain-type-test-bush))))))
                      