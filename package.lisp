;;;; package.lisp

(defpackage #:rshell
  (:use #:cl)
  
  (:export #:run #:start-thread #:stop-thread #:run-from-repl))
