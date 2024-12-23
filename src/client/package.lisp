;;;; package.lisp

(defpackage #:rshell.client.api
  (:use #:cl)

  (:export :refresh-screen
           :process-main-menu
           :process-game-loop
           :process-game-quit))
