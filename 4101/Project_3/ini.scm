;; John Anny
;; Alexandra Willis
;; 
;; Project 3


;;; The comparison operations eqv? and equal?;
;; eqv?
(define eqv?
	(lambda (x y)
		(if(and (number? x) (number? y))
			(= x y)
			(eq? x y))))

;; equal?
(define (equal? a b)
	(cond ((eqv? a b)
		#t)
	((and (pair? a)
		(pair? b)
		(equal? (car a) (car b))
		(equal? (cdr a) (cdr b)))
	#t)
	(else
		#f)))



;;; The n-ary integer comparison operations =, <, >, <=, >=;
;; Less than (<)
(define (<<< . 1)
	if(null? 1)
	(b<)
	(b> (car 1)
		(cond
			((if (null? (cdr 1)) car 1))
			((apply <<< (cdr 1))) cdr 1))))




;;; The test predicates zero?, positive?, negative?, odd?, even?;
;; zero?
(define zero?
  (lambda (x)
    (if (= x 0)
	   #t
	   #f)))
			

;; positive?
(define positive?
  (lambda (x)
    (if (> x 0)
      #t
      #f)))


;; negative?
(define negative?
  (lambda (x)
    (if (< x 0)
      #t
      #f)))


;; odd?
(define odd?
  (lambda (x)
    (cond 
      ((= x 0) #f)
      ((= x 1) #t)
      ((positive? x) (odd? (- x 2)))
      ((negative? x) (odd? (+ x 2))))))


;; even?
(define even?
  (lambda (x)
    (cond
      ((= x 0) #t)
      ((= x 1) #f)
      ((positive? x) (even? (- x 2)))
      ((negative? x) (even? (+ x 2))))))

