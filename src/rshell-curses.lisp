;;;; Rogue Shell.lisp

(in-package #:rshell-curses)

(defun refresh-screen (scr)
  (croatoan:clear scr)
  (croatoan:move scr 23 0)
  (format scr "Arrows for movement. Type q to quit.~%~%")
  
  (croatoan:move scr (rshell.server::mob-y rshell.server::*player*) (rshell.server::mob-x rshell.server::*player*))
  (format scr "@"))

(defun croatoan-bindings ()
  (let ((scr rshell.client.curses.basic::*scr*))
    (croatoan:submit (refresh-screen scr))
    
    (croatoan:submit (croatoan:bind scr #\q #'croatoan:exit-event-loop))
    
    (croatoan:submit (croatoan:bind scr :up #'(lambda (win event)
                                                (declare (ignore event)) 
                                                (rshell.server::move-mob rshell.server::*player* 0 -1)
                                                (refresh-screen win))))
    
    (croatoan:submit (croatoan:bind scr :down #'(lambda (win event) 
                                                  (declare (ignore event))
                                                  (rshell.server::move-mob rshell.server::*player* 0 1) 
                                                  (refresh-screen win))))
    
    (croatoan:submit (croatoan:bind scr :left #'(lambda (win event) 
                                                  (declare (ignore event)) 
                                                  (rshell.server::move-mob rshell.server::*player* -1 0) 
                                                  (refresh-screen win))))
    
    (croatoan:submit (croatoan:bind scr :right #'(lambda (win event) 
                                                   (declare (ignore event)) 
                                                   (rshell.server::move-mob rshell.server::*player* 1 0) 
                                                   (refresh-screen win))))))

(defun run-from-repl ()
  (rshell.server::init-game)
  
  (croatoan-bindings))

(defun run-from-lisp ()
  (rshell.server::init-game)
  
  (rshell.client.curses.basic:curses-main-loop #'croatoan-bindings))

#+(and sbcl unix)
(defun make-exec ()
  (sb-ext:save-lisp-and-die "rshell" :toplevel #'run-from-lisp :executable t :compression nil))

#+(and sbcl windows)
(defun make-exec ()
  (sb-ext:save-lisp-and-die "rshell.exe" :toplevel #'run-from-lisp :executable t :compression nil))
