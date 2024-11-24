;; load croatoan and micros
(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload '(:croatoan :micros :rshell.client.curses.basic)))

;; Defining a package is always a good idea
(defpackage #:curses-interop
  (:use #:cl))

(in-package #:curses-interop)

;; Initialize micros, setting dont-close will prevent the server from
;; shutting down in case slime disconnects. The default port is 4005,
;; one can specify a different one with :port.
(micros:create-server :dont-close t)

;; Initialize screen and enter the event loop
(rshell.client.curses.basic:curses-main-loop)
