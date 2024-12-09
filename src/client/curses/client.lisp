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
  (let* ((scr rshell.client.curses.basic::*scr*)
         (player rshell.server::*player*)
         (player-x (rshell.server::mob-x player))
         (player-y (rshell.server::mob-y player))
         (level (rshell.server::world-cur-level rshell.server::*world*))
         (terrain (rshell.server::level-terrain level))
         (mob-grid (rshell.server::level-mob-grid level)))

    (refresh-screen scr player-x player-y terrain mob-grid)
    
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
    
(defun refresh-screen (scr player-x player-y terrain mob-grid)
  (croatoan:clear scr)

  (let* ((level-max-x (array-dimension terrain 0))
         (level-max-y (array-dimension terrain 1))
         (win-width 50)
         (win-height 24)
         (half-width (truncate win-width 2))
         (half-height (truncate win-height 2))
         (min-x (- player-x half-width))
         (max-x (+ player-x half-width))
         (min-y (- player-y half-height))
         (max-y (+ player-y half-height)))

    ;; we can't let the camera go out of level bounds, for both coords
    (loop for (min max level-max win-max) in `((,min-x ,max-x ,level-max-x ,win-width)
                                               (,min-y ,max-y ,level-max-y ,win-height))
          do
             (cond
               ((and (< min 0)
                     (>= max level-max)) (progn
                                           (setf min 0)
                                           (setf max (1- level-max))))
               ((< min 0) (progn
                            (setf min 0)
                            (setf max win-max)))
               ((>= max level-max) (progn
                                     (setf max (1- level-max))
                                     (setf min (- level-max win-max)))))
          collect (list min max) into result
          finally (progn (setf min-x (first (first result)))
                         (setf max-x (second (first result)))
                         (setf min-y (first (second result)))
                         (setf max-y (second (second result)))))
          
    (loop with cur-terrain = nil
          for scr-x from 0 below win-width
          for x from min-x to max-x do
             (loop for scr-y from 0 below win-height 
                   for y from min-y to max-y
                   do
                      (setf cur-terrain (case (aref terrain x y)
                                          (:terrain-type-test-floor #\.)
                                          (:terrain-type-test-bush #\#)))

                      (when (not (null (aref mob-grid x y)))
                        (setf cur-terrain #\@))
                      
                      (croatoan:move scr scr-y scr-x)
                      (format scr "~A" cur-terrain))))
  
  (croatoan:move scr 24 0)
  (format scr "Arrows for movement. Type q to quit.~%~%"))