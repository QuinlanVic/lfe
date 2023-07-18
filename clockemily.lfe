(defmodule clock
    (export all))

;; Allow for clocks to be within (0 0) and (23 59), otherwise throw an exception error
(defun create (hour minute)
    (cond 
        ;; All exceptions
        ((< hour 0) (error 'function_clause))
        ((< minute 0) (error 'function_clause))
        ((> hour 23) (error 'function_clause))
        ((> minute 59) (error 'function_clause))
        ;; Create clock if correct user input
        ((> hour -1) `(,hour ,minute)) 
    )
)

;; Function that will concatenate hour string with :, and then that string with the minute string
(defun to-string (clock)
    (string:concat (string:concat (atom-to-string (car clock)) ":") (atom-to-string (lists:nth 2 clock)))
)

;; Function that will return the value in string form
(defun atom-to-string (hand)
    (cond
        ;; If there are already two digits, just return them in string from
        ((> hand 9) (integer_to_list hand))
        ;; If there is only one digit, add "0" to the front
        ((< hand 10) (string:concat "0" (integer_to_list hand)))
    )
)

;; Check if two clocks are equal
(defun equal? (clock1 clock2)
    (== clock1 clock2)
)

;; Function that adds minutes to the clock minutes
;; Passes current hours and minutes values to be checked
(defun minutes-add (clock minutes)
    (check-time (car clock) (+ minutes (lists:nth 2 clock)))
)

;; Function that deletes minutes from the clock minutes
;; Passes current hours and minutes values to be checked
(defun minutes-delete (clock minutes)
    (check-time (car clock) (- (lists:nth 2 clock) minutes))
)


;; Checking function - calling functions in correct order (first fix minutes, then hours)
(defun check-time (hours minutes)
    (check-hour (check-minute hours minutes))
)

;; Function that fixes minutes
(defun check-minute (hours minutes)
    (cond
        ;; If there are 60 minutes or more, add another hour and remove 60 minutes, and check again
        ((> minutes 59) (check-minute (+ hours 1) (- minutes 60)))
        ;; If there are less than 0 minutes, remove an hour and get 60 more minutes, and check again
        ((< minutes 0) (check-minute (- hours 1) (+ minutes 60)))
        ;; If there are less than 60 minutes, then just return the clock
        ((< minutes 60) `(,hours ,minutes))
    )
)

(defun check-hour (clock)
    (cond
        ;; If there 24 hours or more, remove 24 from the clock and check again
        ((> (car clock) 23) (check-hour `(,(- (car clock) 24) ,(lists:nth 2 clock))))
        ;; If there are negative hours, add 24 hours to the clock and check again
        ((< (car clock) 0) (check-hour `(,(+ (car clock) 24) ,(lists:nth 2 clock))))
        ;; If the number of hours is between 0 and 23, then return the clock
        ((< (car clock) 24) clock)
    )
)