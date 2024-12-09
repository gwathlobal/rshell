;;;; level.lisp

(in-package #:rshell.server)

(defparameter *world* nil)

(defclass world ()
  ((cur-level :initform nil :initarg :cur-level :accessor world-cur-level :type (or level null))))

(defclass level ()
  ((max-x :initform 50 :initarg :max-x :accessor level-max-x :type fixnum)
   (max-y :initform 50 :initarg :max-y :accessor level-max-y :type fixnum)
   (terrain :initform nil :initarg terrain :accessor level-terrain :type (or array null))
   (mob-grid :initform nil :accessor level-mob-grid :type (or array null))
   (mob-set :initform (make-hash-table) :reader level-mob-set :type hash-table)))

(defmethod initialize-instance :after ((level level) &key)
  (with-slots (max-x max-y terrain mob-grid) level
    (setf terrain (make-array (list max-x max-y) 
                              :element-type 'keyword
                              :initial-element :terrain-type-test-floor))
    (setf mob-grid (make-array (list max-x max-y) 
                               :element-type '(or null fixnum)
                               :initial-element nil))))

(defun generate-random-level (level)
  (with-slots (terrain max-x max-y) level
    (loop with rnd = (make-random-state)
          for x from 0 below (array-dimension terrain 0) do
             (loop for y from 0 below (array-dimension terrain 1) 
                   do
                      (when (< (random 100) 30)
                        (setf (aref terrain x y) :terrain-type-test-bush))))))

(defun level-get-mob-id-at (level x y)
  (with-slots (mob-grid) level
    (aref mob-grid x y)))