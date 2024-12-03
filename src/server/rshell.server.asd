;;;; rshell.server.asd

(asdf:defsystem #:rshell.server
  :description "A roguelike inspired by Mortal Shell game"
  :author "Gwathlobal"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:rshell.client.api)
  :components ((:file "package")
               (:file "mob")
               (:file "rshell")))
