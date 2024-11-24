;;;; Rogue Shell.lisp

(in-package #:rshell.server)

(defparameter *player* nil)

(defun init-game ()
  (setf *player* (make-instance 'mob)))

