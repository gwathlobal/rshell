;;;; glyph.lisp

(in-package #:rshell.client.curses)

(defparameter *mob-representations* (make-array 0 :element-type 'representation :adjustable t))
(defparameter *terrain-representations* (make-array 0 :element-type 'representation :adjustable t))

(defclass representation ()
  ((type-group :initarg :group :reader rep-type-group :type keyword 
               :documentation 
               "Available values:
                   :terrain
                   :mob")
   (type-id :initarg :type-id :reader rep-type-id :type fixnum)
   (glyph :initarg :glyph :reader rep-glyph :type character)
   (color :initarg :color :initform '(:white :black) :reader rep-color :type list)
   (attr :initarg :attr :initform () :reader rep-attr :type list)))

(defun get-representation-container (type-group)
  (ccase type-group
    (:terrain *terrain-representations*)
    (:mob *mob-representations*)))

(defmethod initialize-instance :after ((representation representation) &key)
  (with-slots (type-group type-id) representation
    (let ((container (get-representation-container type-group)))
      (set-and-adjust-container type-id representation container))))

(defun get-representation (rep-type-id rep-type-group)
  (let ((container (get-representation-container rep-type-group)))
    (aref container rep-type-id)))


;;---------------------------
;;  TERRAIN
;;---------------------------

(make-instance 'representation
               :group :terrain
               :type-id rshell.server::+terrain-type-test-floor+
               :glyph #\.
               :color '(:white :black)
               :attr '(:dim))

(make-instance 'representation
               :group :terrain
               :type-id rshell.server::+terrain-type-test-wall+
               :glyph #\#
               :color '(:white :black))

;;---------------------------
;;  MOB
;;---------------------------

(make-instance 'representation
               :group :mob
               :type-id rshell.server::+mob-type-player+
               :glyph #\@
               :attr '(:bold))

(make-instance 'representation
               :group :mob
               :type-id rshell.server::+mob-type-test-enemy+
               :glyph #\x
               :color '(:red :black))