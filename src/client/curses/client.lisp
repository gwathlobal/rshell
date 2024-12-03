;;;; client.lisp

(in-package #:rshell.client.curses)

(defun rshell.client.api:process-main-menu ()
  (let ((scr rshell.client.curses.basic::*scr*))
    (croatoan:clear scr)
    (croatoan:move scr 1 0)
    (format scr "Rogue Shell~%Main Menu~%n - New Game~%q - Quit")
    
    (croatoan:event-case (scr event)
      (#\n (return-from croatoan:event-case :new-game))
      (#\q (return-from croatoan:event-case :quit-game)))))

(defun rshell.client.api:process-game-loop ()
  (let ((scr rshell.client.curses.basic::*scr*)
        (player-x (rshell.server::mob-x rshell.server::*player*))
        (player-y (rshell.server::mob-y rshell.server::*player*)))

    (refresh-screen scr player-x player-y)
    
    (croatoan:event-case (scr event)
      (:up (return-from croatoan:event-case :player-move-up))
      (:down (return-from croatoan:event-case :player-move-down))
      (:left (return-from croatoan:event-case :player-move-left))
      (:right (return-from croatoan:event-case :player-move-right))
      (#\q (return-from croatoan:event-case :quit-game)))))

(defun rshell.client.api:process-game-quit ()
  (let ((scr rshell.client.curses.basic::*scr*))
    (croatoan:clear scr)
    (croatoan:move scr 0 0)))
    
(defun refresh-screen (scr player-x player-y)
  (croatoan:clear scr)
  (croatoan:move scr 23 0)
  (format scr "Arrows for movement. Type q to quit.~%~%")
  
  (croatoan:move scr player-y player-x)
  (format scr "@"))