(defpackage :n-queens
  (:use :common-lisp
	:primitives
	:n-queens-solvers
	:ltk
	#+:sbcl :sb-ext
          )
  (:export
   #:hello-1))

(in-package :n-queens)

(defclass queen-model2()
  ((i :initarg :i)
   (j :initarg :j)))

(defun parse-queens(queens-list)
  (let* ((index -1))
    (loop for queen in queens-list
	 collect(make-instance 'queen-model2 :i (incf index) :j queen))
    ))
		
(defun get-square-coords(x board-model)
  (let* ((margin (gethash 'margin board-model))
	 (side (gethash 'side board-model)))
    (+ (* x side) margin)
    ))

(defun show-search-finished(board-model)
  (let* (
	 (label (make-instance 'label :text "Search finished")))
    (pack label :side :top)
    (setf (gethash 'search-finished-label board-model) label)
    ))

(defun search-finished(board-model)
  (setf (gethash 'timer board-model) 0)
  (clear-board board-model)
  (create-text (gethash 'canvas board-model) -10 -10 "Search finished" )
  (show-search-finished board-model)
  )
	
(defun update-solutions(board-model)
  (let* ((solutions (gethash 'solutions board-model)))
    (if (= 0 (length solutions))
	(search-finished board-model)
	(let* ((new-solutions (lazy-evaluator solutions)))
	     (setf (gethash 'solutions board-model) new-solutions)))
	 ))
	 
(defun auto-update-solution(board-model)
  (let* ((timer-interval (gethash 'timer-interval board-model)))
    (if (= 0 timer-interval)
	()
	(let ()
	  (after timer-interval #'(lambda()(auto-update-solution board-model)))
	  (update-solutions board-model)))))

	
(defun remove-queen(queen canvas)
  (itemdelete canvas queen)
  )

(defun alter-queen(queen canvas)
  (itemconfigure canvas queen "fill" "red")
  )
  
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

(defun show-solution(solution gui-model)
  (clear-board gui-model)
  (let* ((queens (parse-queens (translate-coords (reverse solution) -1 -1)))
	 )
    (format t "sow-solution ~a~% " solution)
    (draw-queens queens gui-model))
  )

(defun draw-queen(x y canvas board-model &optional (color "yellow"))
  (let* ((queen-coords '(10 70 70 70 60 60 70 45 75 12 60 40 58 6 47 40 40 2 32 40 21 6 17 40 3 12 5 40 18 60 10 70))
	 (scalled-coords (primitives:scale-coords queen-coords 0.5))
	 (translated-coords (primitives:translate-coords scalled-coords (get-square-coords x board-model) (get-square-coords y board-model)))
	 (queen (create-polygon canvas translated-coords)))
    (itemconfigure canvas queen "fill" color)
    queen)
  )
  
(defun draw-queens(queens board-model)
  (let* ((canvas (gethash 'canvas board-model))
	   (color (if (= (length queens) (gethash 'size board-model)) "green" "gold"))
	 )
    (let* (
    (q (loop for queen in queens
	  collect(let* ((i (slot-value queen 'i))
			 (j (slot-value queen 'j)))
		  (draw-queen i j canvas board-model color)))))
      (setf (gethash 'queens board-model) q)
      )
    )
  
  )

(defun get-board-settings(size)
  (let ((settings (make-hash-table)))
    (setf (gethash 'side settings) 40)
    (setf (gethash 'margin settings) 10)
    (setf (gethash 'size settings) size)
	 settings)
  )
  
(defun clear-board(gui-model)
  (let* ((solution (gethash 'queens gui-model '()))
	 (board-canvas (gethash 'canvas gui-model)))
    (loop for queen in solution
	 do(remove-queen queen board-canvas))
    )
  )

(defun draw-menu(board-model)
  (let* ((bar (make-instance 'frame))
	 (bstep  (make-instance 'button :master bar :text "Step"  :command (lambda()(update-solutions board-model))))
	 )
    (pack bar :side :bottom)
    
    (pack bstep :side :left)
    )
  )

(defun draw-chessboard(n)  
  (with-ltk ()
    (let* ((*debug-tk* nil)
	   (board-model (get-board-settings n))
	   (side (gethash 'side board-model))
	   (margin (gethash 'margin board-model))
	   (canvas-size (get-canvas-size n side margin))
	   (c (make-instance 'canvas :width (* side (1+ n)) :height (* side (1+  n))))
	   (squares (loop for i from 0 to (1- n)
		      nconc (loop for j from 0 to (1- n)
			       collect(draw-square i j c board-model))))
	   )
      (pack c :side :top)
     (setf (gethash 'squares board-model) squares)
     (setf (gethash 'canvas board-model) c)
     (setf (gethash 'canvas-size board-model) canvas-size)
     (draw-menu board-model)

     (let* ((solutions  (backtracking-lazy-factory n #'(lambda (sol)(show-solution sol board-model)))))
       (setf (gethash 'solutions board-model) solutions))
     (update-solutions board-model)

     board-model
     )))


(draw-chessboard 4)




