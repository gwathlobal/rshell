;;;; api.lisp

(in-package #:rshell.server.api)

(defun get-data-for-client ()
  (let ((player rshell.server::*player*))
  `(:player (:x ,(rshell.server::mob-x player) :y ,(rshell.server::mob-y player)))))

(defun player-move (dx dy)
  (let ((player rshell.server::*player*))
    (rshell.server::move-mob player dx dy)))
