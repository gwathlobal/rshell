;;;; Rogue Shell.lisp

(in-package #:rshell)

(defparameter *game-thread* nil)

(defparameter *x* 10)
(defparameter *y* 10)

(defun refresh-screen (scr)
  (croatoan:clear scr)
  (croatoan:move scr 20 0)
  (format scr "WASD for movement. Type q to quit.~%~%")
  
  (croatoan:move scr *x* *y*)
  (format scr "@"))

(defun croatoan-bindings ()
  (croatoan:submit (refresh-screen rshell.client.curses.basic::*scr*))
  
  (croatoan:submit (croatoan:bind rshell.client.curses.basic::*scr* #\q #'croatoan:exit-event-loop))
  
  (croatoan:submit (croatoan:bind rshell.client.curses.basic::*scr* #\w #'(lambda (win event) (declare (ignore event)) (decf *x*) (refresh-screen win))))
  
  (croatoan:submit (croatoan:bind rshell.client.curses.basic::*scr* #\s #'(lambda (win event) (declare (ignore event)) (incf *x*) (refresh-screen win))))
  
  (croatoan:submit (croatoan:bind rshell.client.curses.basic::*scr* #\a #'(lambda (win event) (declare (ignore event)) (decf *y*) (refresh-screen win))))
  
  (croatoan:submit (croatoan:bind rshell.client.curses.basic::*scr* #\d #'(lambda (win event) (declare (ignore event)) (incf *y*) (refresh-screen win)))))

(defun run-from-repl ()
  (croatoan-bindings))

(defun run-from-lisp ()
  (rshell.client.curses.basic:curses-main-loop #'croatoan-bindings))

#+(and sbcl unix)
(defun make-exec ()
  (sb-ext:save-lisp-and-die "rshell" :toplevel #'run-from-lisp :executable t :compression nil))

#+(and sbcl windows)
(defun make-exec ()
  (sb-ext:save-lisp-and-die "rshell.exe" :toplevel #'run-from-lisp :executable t :compression nil))
