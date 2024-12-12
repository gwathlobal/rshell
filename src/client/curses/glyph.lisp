;;;; glyph.lisp

(in-package #:rshell.client.curses)

(defparameter *mob-representations* (make-array 0 :element-type 'representation :adjustable t))

(defclass mob-representation ()
  ((mob-type :initarg :mob-type :reader rep-mob-type :type fixnum)
   (glyph :initarg :glyph :reader rep-glyph :type character)))

(defun add-mob-representation (mob-representation)
  (when (>= (rep-mob-type mob-representation) (1- (length *mob-representations*)))
    (adjust-array *mob-representations* (list (1+ (length *mob-representations*)))))
  (setf (aref *mob-representations* (rep-mob-type mob-representation)) mob-representation))

(defun get-mob-representation (mob-type-id)
  (aref *mob-representations* mob-type-id))

(add-mob-representation (make-instance 'mob-representation 
                                       :mob-type rshell.server::+mob-type-player+
                                       :glyph #\@))
