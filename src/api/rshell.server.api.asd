;;;; rshell.server.api.asd

(asdf:defsystem #:rshell.server.api
  :description "A roguelike inspired by Mortal Shell game"
  :author "Gwathlobal"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :depends-on (#:rshell.server)
  :components ((:file "package")
               (:file "api")))
