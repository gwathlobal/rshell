;;;; Rogue Shell (Curses UI)

(asdf:defsystem #:rshell-curses
  :description "A roguelike inspired by Mortal Shell game (curses UI)"
  :author "Gwathlobal"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:rshell.server #:rshell.client.curses)
  :components ((:file "package")
               (:file "rshell-curses")))
