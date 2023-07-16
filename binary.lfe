; Quinlan's version :)
(defmodule binary-string
    (export 
        (to-decimal 1))) 

(defun invalid (stringval)
    (if (== stringval "") 'true
    ; (lists:nth 5 "helloaaa") = 111 (STARTS FROM 1) ;returns ascii value not actual char
    ; (lists:map (lambda (x) (+ 1 x)) "hello") = "ifmmp"
        ; or (== charval '0) (== charval "1")
    ; lfe> (lists:map (lambda (charval) (== charval "1")) "1")
    ; (false)
    ; lfe> (lists:map (lambda (charval) (== charval #\1)) "1")
    ; (true)
        (if (== (length (lists:filter (lambda (charval) (or (== charval #\0) (== charval #\1))) stringval)) (length stringval))
            'false
            'true
        )
    )
)

(defun twopowers (answer index)
    (if (/= index 0) 
        (twopowers (* answer 2) (- index 1))
        answer))
    
;  (if (== "" "") 'true 'hello) = true
; string:sub_string stringval 1 (- (length stringval) 1)
; string:sub_string stringval index index to get char as I can't seem to find a solid one
(defun convert (stringval index finalanswer len) 
    (if (/= index len) 
        (let (( data (string:to_integer (string:sub_string stringval (- len index) (- len index))) ))
        (+ finalanswer (convert (string:sub_string stringval 1 (- (- len 1) index)) (+ index 1) (* (element 1 data) (twopowers 1 index)) len)))
        finalanswer 
    )
)

(defun to-decimal (input) 
    (if (invalid input) 
        0
        (convert input 0 0 (length input)) ;convert to string for exercism tests 
    )
)