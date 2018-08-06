(load "util.ss")

; Helper: First letter from a string
(define (string-first-letter s)
  (substring s 0 1))

; Helper: Last letter from a string
(define (string-last-letter s)
  (substring s (- (string-length s) 1)
               (string-length s)))

; Helper: Trim the first and last letters
(define (string-trim-ends s)
  (substring s 1 (- (string-length s) 1)))

; Check if a string is a palindrome
(define (palindrome? s)
  (if (or (= (string-length s) 0)
          (= (string-length s) 1))
      #t
      (and (equal? (string-first-letter s)
                   (string-last-letter s))
           (palindrome? (string-trim-ends s)))))

; Check if an integer is a palindrome
(define (palindrome-int? i)
  (palindrome? (number->string i)))



; Make dotted pairs from an atom and every element
; of a list.
(define (dot-atom-list a l)
  (if (null? (cdr l))
      (list `(,a . ,(car l)))
      (append (list `(,a . ,(car l)))
            (dot-atom-list a (cdr l)))))

; Run the dotted pair function for two lists such
; that every pair between the two lists is made.
(define (every-dot l1 l2)
  (if (null? l1)
      '()
      (append (dot-atom-list (car l1) l2)
              (every-dot (cdr l1) l2))))



; List of every three digit number.
(define three-digits (reverse (ints-n-to-m 100 999)))

; Make all the pairs.
(define three-pairs (every-dot three-digits three-digits))



; Get all the palindrome numbers.
(define (all-palindromes l)
  (if (null? l)
      '()
      (let ((number (* (caar l) (cdar l))))
        (if (palindrome-int? number)
            (cons number (all-palindromes (cdr l)))
            (all-palindromes (cdr l))))))



; Solve the problem
(max-value (all-palindromes three-pairs))