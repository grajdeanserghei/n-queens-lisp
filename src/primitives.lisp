(defpackage :primitives
    (:use :common-lisp
          #+:sbcl :sb-ext
          )
  (:export
   #:translate-coords
   #:scale-coords))
   
(in-package :primitives)

(defun translate-coords(coords x y)
  (let ((index 0))
    (map 'list #'(lambda (val) (let ((r (+ val (if(oddp index) y x))))(incf index) r)) coords)))

(defun scale-coords(coords scale)
  (map 'list #'(lambda (x) (* x scale)) coords)
  )

