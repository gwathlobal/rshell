;;;; rshell.client.curses.asd

(asdf:defsystem #:rshell.client.curses
  :description "Curses UI for Rogue Shell"
  :author "Gwathlobal <gwathlobal@yandex.ru>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:croatoan #:rshell.client.api #:rshell.client.curses.basic #:rshell.server.api)
  :components ((:file "package")
               (:file "client")))
