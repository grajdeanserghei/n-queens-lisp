(asdf:load-system :ltk)

(use-package :ltk)

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
     (draw-queen 1 1 c)
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

(defun draw-queen(x y canvas)
  (let* ((queen-coords )
	 (queen (create-polygon canvas '(10 70 70 70 60 60 70 45 75 12 60 40 58 6 47 40 40 2 32 40 21 6 17 40 3 12 5 40 18 60 10 70)))
	 (c (canvas canvas))
;;	 (image-path (merge-pathnames "images/queen.png" *load-truename*))
	 (image-path "C:/work/n-queens/src/images/queen.png")
;;	 (image-path "images/queen.png")
	 (img (make-image)))    
;;    (image-load img image-path)
;;    (create-image c x y :image img)
;;    (itemconfigure c img "width" 30)
;;    (configure c :borderwidth 2 :relief :sunken)
;;    (pack c )
#||
    (let* ((queen-img (create-image c x y :image image)))
	   (itemconfigure c image "width" 30)
	   )
||#
;;	 (configure c :borderwidth 2 :relief :sunken)
;;	 (scale c 0.25)
    queen)
  )

(defun get-queen-image()
  (let* ((image (make-image)))
  (image-load image "C:/work/n-queens/src/images/queen.png"))
  )

(get-queen-image)
    
(draw-chessboard 8)

(get-board-settings 4)

*load-pathname*
*buffer-file-name*


(ltktest)

