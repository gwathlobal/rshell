;;;; containers.lisp

(in-package #:rshell.common)

(defun find-free-id (entity-container-array)
  (loop for i from 0 below (length entity-container-array)
        unless (aref entity-container-array i)
        do (return-from find-free-id i))
  (adjust-array entity-container-array (list (1+ (length entity-container-array))))
  (1- (length entity-container-array)))

(defun set-and-adjust-container (id object container)
  (when (>= id (1- (length container)))
    (adjust-array container (list (1+ id))))
  (setf (aref container id) object))

