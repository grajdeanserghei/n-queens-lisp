(defpackage :models
  (:use :common-lisp
	:cells
	#+:sbcl :sb-ext
          )
  (:export
   #:queen-model
   #:qm-i
   #:qm-j
   #:parse-queens))

(in-package :models)

(defclass queen-model()
  ((i :accessor qm-i :initarg :i)
   (j :accessor qm-j :initarg :j))
  )

(defun parse-queens(queens-list)
  (let* ((index -1)
	 (result '()))
    (loop for queen in queens-list
	 collect(cons (make-instance 'queen-model :i index :j queen) result))
    )
  )

(defmodel queen-model ()
  ((i :accessor i :initarg :i :initform (c-in 0))
   (j :accessor j :initarg :j :initform (c-in 0))))
               
(defmodel solution-model ()
  ((current-queen :accessor i :initarg :i :initform (c-in 0))
   (j :accessor j :initarg :j :initform (c-in 0))))

(defmodel solution-model()
  ((i :accessor i :initarg :i :initfrom (c-in 0))))


(ql:quickload :cells)
