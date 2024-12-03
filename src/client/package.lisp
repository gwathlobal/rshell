;;;; package.lisp

(defpackage #:rshell.client.api
  (:use #:cl)

  (:export :process-main-menu
           :process-game-loop
           :process-game-quit))
