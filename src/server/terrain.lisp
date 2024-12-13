;;;; terrain.lisp

(in-package #:rshell.server)

(defconstant +terrain-type-test-floor+ 0)
(defconstant +terrain-type-test-wall+ 1)

(defparameter *terrain-types* (make-array 0 :element-type 'terrain-type :adjustable t))

(defclass terrain-type ()
  ((id :initarg :id :reader terrain-type-id :type fixnum)))

(defmethod initialize-instance :after ((terrain-type terrain-type) &key)
  (with-slots (id) terrain-type
    (let ((container *terrain-types*))
      (set-and-adjust-container id terrain-type container))))

(make-instance 'terrain-type :id +terrain-type-test-floor+)
(make-instance 'terrain-type :id +terrain-type-test-wall+)