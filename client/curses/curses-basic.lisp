;;;; curses-main.lisp

(in-package #:rshell.client.curses.basic)

(defparameter *scr* nil)

;; Main entry point, to be called from the terminal thread, it will
;; initialize the screen and enter the event loop
(defun curses-main-loop (&optional (binding-func nil))
  (croatoan:with-screen (scr
                         ;; Set input blocking to 100 ms. This _must_
                         ;; be set for swank to work, otherwise
                         ;; get-event will block and croatoan only
                         ;; polls the job queue when a key is pressed.
                         :input-blocking 100
                         ;; Do not override the swank debugger hook,
                         ;; as we want to enter the slime debugger in
                         ;; emacs when a error occurs.
                         :bind-debugger-hook nil
                         :input-echoing nil
                         :enable-colors t
                         :cursor-visible nil)
    ;; Set *scr* to the initilized scr so that we can access it form
    ;; the swank/micros thread and then enter the event-loop.
    (when binding-func
      (funcall binding-func))
    (croatoan:run-event-loop (setf *scr* scr))))
