(defmodule clock
    (export all)) 

(defun minutes-add (clock minsToAdd)
    (let ((hours       (string:to_integer (lists:filter (lambda (charval) (/= charval #\0)) (string:sub_string clock 1 2))) )) ;fix 0
        (let ((minutes (string:to_integer (lists:filter (lambda (charval) (/= charval #\0)) (string:sub_string clock 4 5))) )) ;fix 0
            (let ((totalminutes (+ (+ (* 60 (element 1 hours)) (element 1 minutes)) minsToAdd) ))
                (let ((newhours (rem (floor (/ totalminutes 60)) 24)))
                (let ((newmins (rem totalminutes 60)))
                ;convert to string before sending across
                (makeclock (erlang:integer_to_list newhours) (erlang:integer_to_list newmins)) 
                )
                )
            )
        )
    )
)

; (defun minutes-delete (clock minsToDel)
;     (let ((hours (string:to_integer (string:sub_string clock 1 2))))
;     (let ((minutes (string:to_integer (string:sub_string clock 4 6))))
;     )
;     )
; )

(defun makeclock (hours minutes)
    (if (and (== (length hours) 2) (== (length minutes) 2))
        (string:concat (string:concat hours ":") 
                       minutes
        )
        (if (and (== (length hours) 1) (== (length minutes) 1))
            (string:concat 
                (string:concat 
                    (string:concat "0" hours)
                    ":"
                )
                (string:concat "0" minutes)
            )
            (if (and (== (length hours) 2) (== (length minutes) 1))
                (string:concat (string:concat hours ":") 
                            (string:concat "0" minutes)
                )
                (string:concat 
                    (string:concat 
                        (string:concat "0" hours)
                        ":"
                    )
                    minutes
                )
            )
        )
    )
)


(defun create (hour minutes)
    (if (or (or (< hour 0) (> hour 23)) (or (< minutes 0) (> minutes 59)))
        'error 
        (makeclock (erlang:integer_to_list hour) (erlang:integer_to_list minutes)) ;convert to strings before sending
    )
)

; (erlang:integer_to_list 123)
; returns = "123"
; (string:concat (string:concat "I" "like") "cheese")
; returns = "Ilikecheese"