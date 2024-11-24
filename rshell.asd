;;;; Rogue Shell.asd

(asdf:defsystem #:rshell
  :description "A roguelike inspired by Mortal Shell game"
  :author "Gwathlobal"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:croatoan #:bordeaux-threads #:rshell.client.curses.basic)
  :components ((:file "package")
               (:file "rshell")))
