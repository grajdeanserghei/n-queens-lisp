(defpackage :n-queens-solvers
  (:use :common-lisp
	#+:sbcl :sb-ext
          )
  (:export
   #:queens-backtracking-lazy
   #:lazy-evaluator
   #:backtracking-lazy-factory))

(in-package :n-queens-solvers)

(defun queens-backtracking-lazy (n &optional print-func (i 0) (solution '()))
  (format t "i: ~a~% sol: ~a~%" i solution)
  (funcall print-func solution)
  (if (= i n)
      (list #'(lambda()()))      
	 (loop for new-col from 1 to n
	       when (loop for row from 1 to n
		       for col in solution
		       always (/= new-col col (+ col row) (- col row)))
	    collect(let* ((next-i (1+ i))
			  (new-sol (cons new-col solution)))
		     (lambda()(queens-backtracking-lazy n print-func next-i new-sol)))
	      )))

(defun lazy-evaluator(steps)
  (let* ((new-steps (funcall (car steps)))
	 (new-sol (nconc new-steps (cdr steps))))
    (format t "new sol ~a~%" new-sol)
    (format t "len sol ~a~%" (length new-sol))
    (nconc new-sol ))
  )

(defun backtracking-lazy-factory(n print-func)
  (list (lambda()(queens-backtracking-lazy n print-func)))
  )

(defun queens-backtracking (n &optional print-func (i 0) (solution '()))
  (format t "i: ~a~%" i)
  (funcall print-func solution)
  (if (= i n)
	 (list solution)
	 (loop for new-col from 1 to n
	       when (loop for row from 1 to n
		       for col in solution
		       always (/= new-col col (+ col row) (- col row)))
		nconc(queens-backtracking n print-func (1+ i) (cons new-col solution))
	      )))

(defun evaluator(n i new-col print-func solution)
  (if(loop for row from 1 to n
     for col in solution
	always (/= new-col col (+ col row) (- col row)))
     (queens-backtracking n print-func (1+ i) (cons new-col solution)))
  ()
  )

(defun queens (n &optional (m n) (print-func))
  (if (zerop n)
      (list nil)
      (loop for solution in (queens (1- n) m print-func)
	   do(if print-func
		 (funcall print-func solution)
		 ())
            nconc (loop for new-col from 1 to m
                         when (loop for row from 1 to n
                                     for col in solution
                                     always (/= new-col col (+ col row) (- col row)))
		     collect (cons new-col solution)))))
