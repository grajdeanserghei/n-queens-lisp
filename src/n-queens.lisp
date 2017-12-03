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
	   (c (make-instance 'canvas :width 400 :height 300))
	   (board-settings (get-board-settings n))
	   (squares (loop for i from 1 to n
		      nconc (loop for j from 1 to n
			       collect(draw-square i j c board-settings))))
	   (board-model (make-hash-table)))
     (pack c :expand 1 :fill :both)
     (scrollregion c 0 0 800 800)
     (setf (gethash 'squares board-model) squares)
     (setf (gethash 'canvas board-model) c)
     (draw-queen 1 1 c board-settings)
     (draw-queen 1 2 c board-settings)
     (draw-queen 8 8 c board-settings)
     board-model
     )))

(defun draw-square(x y canvas board-settings)
  (let* ((side (gethash 'side board-settings))
	 (x-origin 10)
	 (y-origin 10)
	 (x1 (+ x-origin (* x side)))
	 (y1 (+ y-origin (* y side)))
	 (x2 (+ x1 side))
	 (y2 (+ y1 side))
	 (square (create-rectangle canvas x1 y1 x2 y2))
	 (color (if (oddp (+ x y)) "black" "white"))
	 )
    (itemconfigure canvas square "fill" color)
    square
    ))

(defun draw-queen(x y canvas board-model)
  (let* ((queen-coords '(10 70 70 70 60 60 70 45 75 12 60 40 58 6 47 40 40 2 32 40 21 6 17 40 3 12 5 40 18 60 10 70))
	 ;;	 (c (make-instance 'canvas :master canvas :width 400 :height 300))
	 (scalled-coords (primitives:scale-coords queen-coords 0.5))
	 (translated-coords (primitives:translate-coords scalled-coords (get-square-coords x board-model) (get-square-coords y board-model)))
	 (queen (create-polygon canvas translated-coords)))
	 
;;	 (image-path (merge-pathnames "images/queen.png" *load-truename*))
;;	 (image-path "C:/work/n-queens/src/images/queen.png")
;;	 (image-path "images/queen.png")
;;	 (img (make-image))
;;    (image-load img image-path))
;;    (create-image canvas x y :image img)
;;    (itemconfigure c img "width" 30)
;;    (configure c :borderwidth 2 :relief :sunken)

#||
    (let* ((queen-img (create-image c x y :image image)))
	   (itemconfigure c image "width" 30)
	   )
||#
;;	 (configure c :borderwidth 2 :relief :sunken)
;;	 (scale queen 0.25)
    ;;    (configure c :borderwidth 2 :relief :sunken)
    (itemconfigure canvas queen "fill" "gold")
    queen)
  )

(defun get-square-coords(x board-model)
  (let* ((margin (gethash 'margin board-model))
	 (side (gethash 'side board-model)))
    (+ (* x side) margin)
    ))

(defun get-queen-image()
  (let* ((image (make-image)))
  (image-load image "images/queen.png"))
  )

(scale_vect '(1 2 3) 0.2)

(get-queen-image)
    
(draw-chessboard 8)

(translate_vect '(1 2 3 4) 1 2)

(get-board-settings 4)

*load-pathname*
*buffer-file-name*



