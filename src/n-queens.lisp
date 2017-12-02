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
	  (table (loop for i from 1 to n
		      nconc (loop for j from 1 to n
			       collect(draw-square i j c board-settings))))
          )
     (pack c :expand 1 :fill :both)
     (scrollregion c 0 0 800 800)
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
    ))

(defun draw-queen(x y canvas)
  
  )
    
(draw-chessboard 8)

(get-board-settings 4)
