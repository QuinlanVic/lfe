; Quinlan's version :)
(defmodule binary-string
    (export 
        (to-decimal 1))) ;export function

;function to check if the string inputted is invalid or not
(defun invalid (stringval)
    (if (== stringval "") 'true ;;if it's an empty string then it's invalid
    ; (lists:nth 5 "helloaaa") = 111 (STARTS FROM 1) ;returns ascii value not actual char
    ; (lists:map (lambda (x) (+ 1 x)) "hello") = "ifmmp"
        ; or (== charval '0) (== charval "1")
    ; lfe> (lists:map (lambda (charval) (== charval "1")) "1")
    ; (false)
    ; lfe> (lists:map (lambda (charval) (== charval #\1)) "1")
    ; (true)
        ; we filter through the list and if it is not a 0 or 1 don't add it to the new one, if the new list is not the same length (i.e., some values are not 1 or 0) then it's invalid
        (if (== (length (lists:filter (lambda (charval) (or (== charval #\0) (== charval #\1))) stringval)) (length stringval))
            'false
            'true
        )
    )
)
;function to set 2 to the relevant power and calculate its result
(defun twopowers (answer index)
    (if (/= index 0) 
        (twopowers (* answer 2) (- index 1))
        answer))
    
;  (if (== "" "") 'true 'hello) = true
; string:sub_string stringval 1 (- (length stringval) 1)
; string:sub_string stringval index index to get char as I can't seem to find a solid one
; convert the binary number to its decimal equivalent
(defun convert (stringval index finalanswer len) 
    ; keep recursive calling until we reach the end of the number
    (if (/= index len) 
        (let (( data (string:to_integer (string:sub_string stringval (- len index) (- len index))) )) ;get the character at the correct index using a hack with substring lol
        ; do recursion to get the sum of each digit in the number multiplied by 2 to the relevant power (lots of hacks)
        (+ finalanswer (convert (string:sub_string stringval 1 (- (- len 1) index)) (+ index 1) (* (element 1 data) (twopowers 1 index)) len))) 
        finalanswer ; return the finalanswer when we are done recursive calling
    )
)
;window to the program and calls to other functions with relevant starting parameters
(defun to-decimal (input) 
    (if (invalid input) 
        0
        (convert input 0 0 (length input)) 
    )
)