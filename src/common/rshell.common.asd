;;;; rshell.common.asd

(asdf:defsystem #:rshell.common
  :description "A roguelike inspired by Mortal Shell game"
  :author "Gwathlobal"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
               (:file "containers")))
