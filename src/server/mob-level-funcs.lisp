;;;; mob-level-funcs.lisp

(in-package #:rshell.server)

(defun add-mob-to-level (mob level &key new-x new-y)
  (with-slots (id x y) mob
    (with-slots (mob-grid mob-set max-x max-y) level
      (let ((nx (if (null new-x)
                    x
                    new-x))
            (ny (if (null new-y)
                    y
                    new-y)))
        (assert (>= nx 0))
        (assert (>= ny 0))
        (assert (< nx max-x))
        (assert (< ny max-y))
        
        (setf x nx)
        (setf y ny)
        
        (setf (gethash id mob-set) t)
        (setf (aref mob-grid x y) id)

        (setf (mob-level mob) level)
        mob))))

(defun remove-mob-from-level (mob level)
  (with-slots (x y id) mob
    (with-slots (mob-grid mob-set) level
      (when (eq (level-get-mob-id-at level x y) id)
        (setf (aref mob-grid x y) nil))
      
      (remhash id mob-set)
      
      (setf (mob-level mob) nil)
      mob)))

(defun move-mob (mob dx dy)
  (let ((level (mob-level mob))
        (nx (+ (mob-x mob) dx))
        (ny (+ (mob-y mob) dy)))
    (when (or (< nx 0)
              (< ny 0)
              (>= nx (level-max-x level))
              (>= ny (level-max-y level)))
      (return-from move-mob `(:result :out-of-bounds :x ,nx :y ,ny)))

    (let ((target-mob-id (level-get-mob-id-at level nx ny)))
      (when (and target-mob-id
                 (/= (mob-id mob) target-mob-id))
        (return-from move-mob `(:result :mob-found :x ,nx :y ,ny))))
    
    (remove-mob-from-level mob level)
    
    (incf (mob-x mob) dx)
    (incf (mob-y mob) dy)
    
    (add-mob-to-level mob level)))