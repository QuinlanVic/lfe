(defmodule binaryfile
    (export 
        to-decimal 1)) 

(defun check (stringval index torf)
    (let ((charval (element index stringval))))
    (if (and (or (== charval "0") (== charval "1")) (/= (- (string:len input) 1) index)) (check stringval (+ index 1) torf)
    (set torf 1))
    ((if (== torf 0) (true) false))
)

(defun convert (stringval) 
    ()
)

(defun to-decimal (input) 
    (if (check input 0 0) (0)
    (convert input))
)