(defmodule clock
    (export all)) 

(defun minutes-add (clock minsToAdd)
    (let ((hours (string:to_integer (string:sub_string clock 1 2))))
    (let ((minutes (string:to_integer (string:sub_string clock 4 6))))
    (let ((newhours (+ () ()))))
    )
    )
)

(defun minutes-delete (clock minsToDel)
    (let ((hours (string:to_integer (string:sub_string clock 1 2))))
    (let ((minutes (string:to_integer (string:sub_string clock 4 6))))
    )
    )
)

(defun makeclock (hours minutes)
    (if (and ((length hours) == 2) ((length minutes) == 2))
        (string:concat (string:concat (erlang:integer_to_list hours) ":") 
                       (erlang:integer_to_list minutes)
        )
     else if (and ((length hours) == 1) ((length minutes) == 1))
        (string:concat 
            (string:concat 
                (string:concat "0" (erlang:integer_to_list hours))
                ":"
            )
            (string:concat "0" (erlang:integer_to_list minutes))
        )
    else if (and ((length hours) == 2) ((length minutes) == 1))
        (string:concat (string:concat (erlang:integer_to_list hours) ":") 
                       (string:concat "0" (erlang:integer_to_list minutes))
        )
    else 
       (string:concat 
            (string:concat 
                (string:concat "0" (erlang:integer_to_list hours))
                ":"
            )
            (erlang:integer_to_list minutes)
        )
    )
)


(defun create (hour minutes)
    (if (or (or (< hour 0) (> hour 23)) (or (< minutes 0) (> minutes 59)))
        'error 
        (makeclock hour minutes)     
    )
)

; (erlang:integer_to_list 123)
; returns = "123"
; (string:concat (string:concat "I" "like") "cheese")
; returns = "Ilikecheese"