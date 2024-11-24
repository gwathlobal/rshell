;;;; rshell.client.curses.basic.asd

(asdf:defsystem #:rshell.client.curses.basic
  :description "System to share between normal curses execution and execution inside IDE (Emacs/Lem)"
  :author "Gwathlobal <gwathlobal@yandex.ru>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:croatoan)
  :components ((:file "package")
               (:file "curses-basic")))
