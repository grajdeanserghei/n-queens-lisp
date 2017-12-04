;gnu clisp 2.49
; online compillers
; 1 - http://rextester.com/l/common_lisp_online_compiler
; 2 - https://www.tutorialspoint.com/execute_lisp_online.php

(let* ((l (function (lambda()()))))
      (print l)
      (print (funcall l)))


(defun translate-coords(coords x y)
  (let ((index 0))
    (map 'list #'(lambda (val) (let ((r (+ val (if(oddp index) y x))))(incf index) r)) coords)))


(defun lazy-evaluator(steps)
(format t "step ~a~%" (car steps))
  (let* (
        (h (car steps))
        
        (new-steps (funcall h))
        
	 (new-sol (nconc new-steps (cdr steps))))
;;    
    (nconc new-sol )
    )
  )


(defun queens-bktlz4 (n &optional print-func (i 0) (solution '()))
  (format t "i: ~a~% sol: ~a~%" i solution)
  (funcall print-func solution)
  (if (= i n)
	 (list lambda()())
	 (loop for new-col from 1 to n
	       when (loop for row from 1 to n
		       for col in solution
		       always (/= new-col col (+ col row) (- col row)))
	    collect(let* ((next-i (1+ i))
			  (new-sol (cons new-col solution)))
		     (lambda()(queens-bktlz4 n print-func next-i new-sol))
	      ))))


(setq *q* ( lazy-evaluator (queens-bktlz4 4 #'(lambda (sol)(format t "new sol: ~a~%" sol )))))
(setq *q* ( lazy-evaluator *q*))
(setq *q* ( lazy-evaluator *q*))
(setq *q* ( lazy-evaluator *q*))
(setq *q* ( lazy-evaluator *q*))
(setq *q* ( lazy-evaluator *q*))
(setq *q* ( lazy-evaluator *q*))
(setq *q* ( lazy-evaluator *q*))
(setq *q* ( lazy-evaluator *q*))
(setq *q* ( lazy-evaluator *q*))
(setq *q* ( lazy-evaluator *q*))
(setq *q* ( lazy-evaluator *q*))