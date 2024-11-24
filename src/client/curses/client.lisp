;;;; client.lisp

(in-package #:rshell.client.curses)

(defun refresh-screen (scr)
  (let* ((data (rshell.server.api:get-data-for-client))
         (player-x (getf (getf data :player) :x))
         (player-y (getf (getf data :player) :y)))
    (croatoan:clear scr)
    (croatoan:move scr 23 0)
    (format scr "Arrows for movement. Type q to quit.~%~%")
  
    (croatoan:move scr player-y player-x)
    (format scr "@")))

(defun croatoan-bindings ()
  (let ((scr rshell.client.curses.basic::*scr*))
    (croatoan:submit (refresh-screen scr))
    
    (croatoan:submit (croatoan:bind scr #\q #'croatoan:exit-event-loop))
    
    (croatoan:submit (croatoan:bind scr :up #'(lambda (win event)
                                                (declare (ignore event)) 
                                                (rshell.server.api:player-move 0 -1)
                                                (refresh-screen win))))
    
    (croatoan:submit (croatoan:bind scr :down #'(lambda (win event) 
                                                  (declare (ignore event))
                                                  (rshell.server.api:player-move 0 1) 
                                                  (refresh-screen win))))
    
    (croatoan:submit (croatoan:bind scr :left #'(lambda (win event) 
                                                  (declare (ignore event)) 
                                                  (rshell.server.api:player-move -1 0) 
                                                  (refresh-screen win))))
    
    (croatoan:submit (croatoan:bind scr :right #'(lambda (win event) 
                                                   (declare (ignore event)) 
                                                   (rshell.server.api:player-move 1 0) 
                                                   (refresh-screen win))))))