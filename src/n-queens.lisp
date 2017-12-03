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


(defun get-board-settings(size)
  (let ((settings (make-hash-table)))
    (setf (gethash 'side settings) 40)
    (setf (gethash 'margin settings) 10)
	 (setf (gethash 'size settings) size)
	 settings)
	 )
  

(defun draw-chessboard(n)
  (with-ltk ()
    (let* ((*debug-tk* nil)
	   (n (1- n))
	   (c (make-instance 'canvas :width 400 :height 300))
	   (board-settings (get-board-settings n))
	   (squares (loop for i from 0 to n
		      nconc (loop for j from 0 to n
			       collect(draw-square i j c board-settings))))
	   (board-model (make-hash-table)))
     (pack c :expand 1 :fill :both)
     (scrollregion c 0 0 800 800)
     (setf (gethash 'squares board-model) squares)
     (setf (gethash 'canvas board-model) c)
     (draw-queen 0 0 c board-settings)
     (draw-queen 1 2 c board-settings)
     (draw-queen 7 7 c board-settings)
     board-model
     )))

(defun draw-square(i j board-canvas board-settings)
  (let* ((side (gethash 'side board-settings))
	 (margin (gethash 'margin board-settings))
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

(defun draw-queen(x y canvas board-model)
  (let* ((queen-coords '(10 70 70 70 60 60 70 45 75 12 60 40 58 6 47 40 40 2 32 40 21 6 17 40 3 12 5 40 18 60 10 70))
	 (scalled-coords (primitives:scale-coords queen-coords 0.5))
	 (translated-coords (primitives:translate-coords scalled-coords (get-square-coords x board-model) (get-square-coords y board-model)))
	 (queen (create-polygon canvas translated-coords)))
    (itemconfigure canvas queen "fill" "gold")
    queen)
  )

(defun get-square-coords(x board-model)
  (let* ((margin (gethash 'margin board-model))
	 (side (gethash 'side board-model)))
    (+ (* x side) margin)
    ))

  
(draw-chessboard 8)

(translate_vect '(1 2 3 4) 1 2)

(get-board-settings 4)

*load-pathname*
*buffer-file-name*



