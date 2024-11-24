;; load croatoan and swank
(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload '(:croatoan :swank :rshell.client.curses.basic)))

;; Defining a package is always a good idea
(defpackage #:curses-interop
  (:use #:cl))

(in-package #:curses-interop)

;; Initialize swank, setting dont-close will prevent the server from
;; shutting down in case slime disconnects. The default port is 4005,
;; one can specify a different one with :port.
(swank:create-server :dont-close t)

;; Initialize screen and enter the event loop
(rshell.client.curses.basic:curses-main-loop)
