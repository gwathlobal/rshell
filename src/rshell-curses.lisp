;;;; Rogue Shell.lisp

(in-package #:rshell-curses)

(defun run-from-repl ()
  (rshell.server::init-game)
  
  (rshell.client.curses:croatoan-bindings))

(defun run-from-lisp ()
  (rshell.server::init-game)
  
  (rshell.client.curses.basic:curses-main-loop #'rshell.client.curses:croatoan-bindings))

#+(and sbcl unix)
(defun make-exec ()
  (sb-ext:save-lisp-and-die "rshell" :toplevel #'run-from-lisp :executable t :compression nil))

#+(and sbcl windows)
(defun make-exec ()
  (sb-ext:save-lisp-and-die "rshell.exe" :toplevel #'run-from-lisp :executable t :compression nil))
