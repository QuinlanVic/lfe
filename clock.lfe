(defmodule clock
    (export all)) 

(defun getridoffirst0 (hrsormins) 
    (if (== "0" (string:sub_string hrsormins 1)) ;get rid of first 0 if applicable i.e. 01
            (string:to_integer (string:sub_string hrsormins 2 2))
            (string:to_integer hrsormins)
        )
)

(defun minutes-add (clock minsToAdd)
    (let ((newClock (listToString clock)))
    (let ((hours (string:sub_string newClock 1 2) ))
        (let ((newHours (getridoffirst0 hours) ))
        (let ((minutes (string:sub_string newClock 4 5) )) 
            (let ((newMinutes (getridoffirst0 minutes) ))
            (let ((totalminutes (+ (+ (* 60 (element 1 newHours)) (element 1 newMinutes)) minsToAdd) )) 
                (let ((finalHours (rem (floor (/ totalminutes 60)) 24) ))
                (let ((finalMins (rem totalminutes 60) ))
                ;convert to string before sending across
                `(,finalHours ,finalMins)
                )
                )
            )
            )
        )
        )
    )
    )
)

(defun checkneg (totalmins) 
    (if (< totalmins 0) (* totalmins -1) totalmins)
)

(defun minushrs (hrs)
    (if (< hrs 0) (+ 24 hrs) hrs)
)

(defun minusmins (mins)
    (if (< mins 0) (+ 60 mins) mins)
)

(defun minutes-delete (clock minsToDel)
    (let ((newClock (listToString clock)))
    (let ((hours (string:sub_string newClock 1 2) ))
        (let ((newHours (getridoffirst0 hours) ))
        (let ((minutes (string:sub_string newClock 4 5) )) 
            (let ((newMinutes (getridoffirst0 minutes) ))
            (let ((totalminutes (- (+ (* 60 (element 1 newHours)) (element 1 newMinutes)) minsToDel) )) 
                (let ((finalHours (minushrs (rem (floor (/ totalminutes 60)) 24)) ))
                (let ((finalMins (minusmins (rem totalminutes 60)) )) 
                ;convert to string before sending across
                `(,finalHours ,finalMins)
                )
                )
            )
            )
        )
        )
    )
    )
)

; (defun listToString (listtochange)
;   (let ((stringlist
;          (lists:map
;           (lambda (x)
;             (let ((str (erlang:integer_to_list x)))
;               (if (< x 10)
;                   (string:concat "0" str)
;                   str)))
;           listtochange)))
;     (string:join stringlist ":")))

(defun listToString (listtochange)
    (let ((stringlist 
        (lists:map 
                (lambda (x) (if (== (length (erlang:integer_to_list x)) 1) 
                (string:concat "0" (erlang:integer_to_list x)) (erlang:integer_to_list x))) 
                listtochange)
        ))
        (string:join stringlist ":")
    )
)

(defun to-string (twonums) 
    ;convert to strings before sending
    (listToString twonums)
)
;     (let ((hrsstr (string:sub_string twonumsStr 1 2) ))
;     (let ((minsstr (string:sub_string twonumsStr 4 5) ))
;         (if (and (== (length hrsstr) 2) (== (length minsstr) 2))
;             (string:concat (string:concat hrsstr ":") 
;                         minsstr
;             )
;             (if (and (== (length hrsstr) 1) (== (length minsstr) 1))
;                 (string:concat 
;                     (string:concat 
;                         (string:concat "0" hrsstr)
;                         ":"
;                     )
;                     (string:concat "0" minsstr)
;                 )
;                 (if (and (== (length hrsstr) 2) (== (length minsstr) 1))
;                     (string:concat (string:concat hrsstr ":") 
;                                 (string:concat "0" minsstr)
;                     )
;                     (string:concat 
;                         (string:concat 
;                             (string:concat "0" hrsstr)
;                             ":"
;                         )
;                         minsstr
;                     )
;                 )
;             )
;         )
;     )
;     )
;     )
; )

(defun equal? (clock1 clock2)
    (== clock1 clock2)    
)


(defun create (hour minutes)
    (if (or (or (< hour 0) (> hour 23)) (or (< minutes 0) (> minutes 59)))
        (error 'function_clause "Cannot set clock with those values")
        (list hour minutes)
    ) 
)


; (erlang:integer_to_list 123)
; returns = "123"
; (string:concat (string:concat "I" "like") "cheese")
; returns = "Ilikecheese"