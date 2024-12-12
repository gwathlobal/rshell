;;;; Rogue Shell.lisp

(in-package #:rshell.server)

(defparameter *player* nil)

(defun init-game ()
  (setf *server-state* :server-state-main-menu))

(defparameter *server-state* :server-state-main-menu
  "Available server states:
   :server-state-main-menu
   :server-state-game-loop
   :server-state-game-quit")


(defun process-server-state ()
  (loop with cmd = nil
        do
           (case cmd
             (:new-game (progn
                          (start-new-game)
                          (setf *server-state* :server-state-game-loop)))
             (:quit-game (setf *server-state* :server-state-game-quit)))
        
           (setf cmd (case *server-state*
                       (:server-state-main-menu (let ((result (rshell.client.api:process-main-menu)))
                                                  (ccase result
                                                    (:new-game :new-game)
                                                    (:quit-game :quit-game))))
                       (:server-state-game-loop (let ((result (rshell.client.api:process-game-loop)))
                                                  (ccase result
                                                    (:player-move-up (move-mob *player* 0 -1))
                                                    (:player-move-down (move-mob *player* 0 1))
                                                    (:player-move-left (move-mob *player* -1 0))
                                                    (:player-move-right (move-mob *player* 1 0))
                                                    (:quit-game :quit-game))))
                       (:server-state-game-quit (progn 
                                                  (rshell.client.api:process-game-quit)
                                                  (return-from process-server-state)))))))

(defun start-new-game ()
  (adjust-array *mobs* 0)
  
  (setf *player* (make-instance 'mob :mob-type +mob-type-player+))
  (setf *world* (make-instance 'world :cur-level (make-instance 'level)))
  
  (add-mob-to-level *player* (world-cur-level *world*))
  
  (generate-random-level (world-cur-level *world*)))