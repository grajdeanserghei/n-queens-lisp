(defpackage :n-queens
  (:use :common-lisp
	:primitives
	:ltk
	#+:sbcl :sb-ext
          )
  (:export
   #:hello-1))

#||
(asdf:load-system :ltk)

(use-package :ltk)
||#

(in-package :n-queens)

(defun hello-1()
  (with-ltk ()
   (let ((b (make-instance 'button 
                           :master nil
                           :text "Press Me"
                           :command (lambda ()
                                      (format t "Hello World!~&")))))
     (pack b))))

(funcall (funcall (trec 1)))


(defun queens-bkt-lz (n &optional print-func (i 0) (solution '()))
  (format t "i: ~a~%" i)
  (funcall print-func solution)
  (if (= i n)
	 (list solution)
	 (loop for new-col from 1 to n
	       when (loop for row from 1 to n
		       for col in solution
		       always (/= new-col col (+ col row) (- col row)))
nconc(cons solution (lambda()(queens-bkt-lz n print-func (1+ i) (cons new-col solution))))
	      )))


(defun evaluator(n i new-col print-func solution)
  (if(loop for row from 1 to n
     for col in solution
	always (/= new-col col (+ col row) (- col row)))
     (queens-bkt n print-func (1+ i) (cons new-col solution)))
  ()
  )


(defun queens-bktlz4 (n &optional print-func (i 0) (solution '()))
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
		     (lambda()(queens-bktlz4 n print-func next-i new-sol)))
	      )))

(defun testc()
  (loop for i from 1 to 4
     collect(let* ((c i))
	      (lambda()(1+ c))))
  )

(defun tr()
  (let* ((lam (testc)))
    (loop for lamb in lam
	 do(funcall lamb)))
  )

(funcall (car (testc)))

(format t "I ~a~%" ())

(defun lazy-evaluator(steps)
  (let* ((new-steps (funcall (car steps)))
	 (new-sol (nconc new-steps (cdr steps))))
;;    (format t "new sol ~a~%" new-sol)
    (nconc new-sol )
    )
  )

(defun queens-bkt (n &optional print-func (i 0) (solution '()))
  (format t "i: ~a~%" i)
  (funcall print-func solution)
  (if (= i n)
	 (list solution)
	 (loop for new-col from 1 to n
	       when (loop for row from 1 to n
		       for col in solution
		       always (/= new-col col (+ col row) (- col row)))
		nconc(queens-bkt n print-func (1+ i) (cons new-col solution))
	      )))

(queens-bkt 4 #'(lambda (sol)(format t "new sol: ~a~%" (translate-coords sol -1 -1))))


(lazy-evaluator (queens-bktlz4 4 #'(lambda (sol)(format t "new sol: ~a~%" (translate-coords sol -1 -1)))))

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

(queens 4 4 #'(lambda (sol)(format t "new sol: ~a~%" sol)))


(defclass queen-model2()
  ((i :initarg :i)
   (j :initarg :j))
  )

(defun parse-queens(queens-list)
  (let* ((index -1))
    (loop for queen in queens-list
	 collect(make-instance 'queen-model2 :i (incf index) :j queen))
    )
  )

(defun show-solution(solution gui-model)
  (clear-board gui-model)
  (let* ((queens (parse-queens (translate-coords solution -1 -1))))
    (draw-queens queens gui-model))
  )

(defun draw-queens(queens board-model)
  (let* ((canvas (gethash 'canvas board-model))
	 )
    (let* (
    (q (loop for queen in queens
	  collect(let* ((i (slot-value queen 'i))
			 (j (slot-value queen 'j)))
		  (draw-queen i j canvas board-model)))))
      (setf (gethash 'queens board-model) q)
      )
    )
  
  )

(defun clear-board(gui-model)
  (let* ((solution (gethash 'queens gui-model '()))
	 (board-canvas (gethash 'canvas gui-model)))
    (loop for queen in solution
	 do(remove-queen queen board-canvas))
    )
  )

(defun get-board-settings(size)
  (let ((settings (make-hash-table)))
    (setf (gethash 'side settings) 40)
    (setf (gethash 'margin settings) 10)
    (setf (gethash 'size settings) size)
	 settings)
  )

(defun draw-menu()
  (let* ((bar (make-instance 'frame))
	 (bstop  (make-instance 'button :master bar :text "Stop"  :command 'hide-queen))
	 )
    (pack bar :side :bottom)
    
    (pack bstop :side :left)
    )
  )

(defun draw-chessboard(n)
  
  (with-ltk ()
    (let* ((*debug-tk* nil)
	   (n (1- n))
	   ;;(queens (parse-queens '(2 4 6)))
	   (c (make-instance 'canvas :width 400 :height 300))
	   (board-model (get-board-settings n))
	   (squares (loop for i from 0 to n
		      nconc (loop for j from 0 to n
			       collect(draw-square i j c board-model)))))
     (pack c :expand 1 :fill :both)
     (scrollregion c 0 0 800 800)
     (setf (gethash 'squares board-model) squares)
     (setf (gethash 'canvas board-model) c)
 ;;    (draw-queen 0 0 c board-model)
;;     (draw-queen 1 2 c board-model)
     (let* ((q3 (draw-queen 7 7 c board-model))
	    )
       (after 1000 #'(lambda()(alter-queen q3 c)))
       (after 2000 #'(lambda()(remove-queen q3 c)))
       )
     (draw-menu)
;;     (draw-queens queens board-model)
;;     (show-solution '(2 3 4) board-model)
     ;;     (queens-bkt n #'(lambda (sol)(show-solution sol board-model)))
     (let* ((solutions (queens-bktlz4 n #'(lambda (sol)(show-solution sol board-model)))))
       (setf (gethash 'solutions board-model) solutions))
     (update-solutions board-model)

;;     (after 2000 #'(lambda()(show-solution '(5 2 1 5) board-model)))
     board-model
     )))

(defun draw-square(i j board-canvas board-settings)
  (let* ((side (gethash 'side board-settings))
	 (x1 (get-square-coords i board-settings))
	 (y1 (get-square-coords j board-settings))
	 (coords (list 0 0 side side))
	 (coords (primitives:translate-coords coords x1 y1))
	 (args (push board-canvas coords))
 	 (square (apply #'create-rectangle args))
	 (color (if (oddp (+ i j)) "black" "white"))
	 )
    (itemconfigure board-canvas square "fill" color)
    square
    ))

(defun update-solutions(board-model)
  (let* ((solutions (gethash 'solutions board-model))
	 (new-solutions (lazy-evaluator solutions))
	 )
    (after 1000 #'(lambda()(update-solutions board-model)))
    (setf (gethash 'solutions board-model) new-solutions))
  )

(defun draw-queen(x y canvas board-model)
  (let* ((queen-coords '(10 70 70 70 60 60 70 45 75 12 60 40 58 6 47 40 40 2 32 40 21 6 17 40 3 12 5 40 18 60 10 70))
	 (scalled-coords (primitives:scale-coords queen-coords 0.5))
	 (translated-coords (primitives:translate-coords scalled-coords (get-square-coords x board-model) (get-square-coords y board-model)))
	 (queen (create-polygon canvas translated-coords)))
    (itemconfigure canvas queen "fill" "gold")
    queen)
  )

(defun remove-queen(queen canvas)
  (itemdelete canvas queen)
  )

(defun get-square-coords(x board-model)
  (let* ((margin (gethash 'margin board-model))
	 (side (gethash 'side board-model)))
    (+ (* x side) margin)
    ))

(defun alter-queen(queen canvas)
  (itemconfigure canvas queen "fill" "red")
  )

(draw-chessboard 8)

(get-board-settings 4)


(defparameter *c* (make-instance 'queen-model2 :i 1 :j 3))

(slot-value *c* 'i)

(parse-queens '(2 4))




(defparameter *account*
  (make-instance 'bank-account :customer-name "John Doe" :balance 1000))

(slot-value *account* 'customer-name)
