(defmodule guess2pointO
    (export (main 0)))



; input function that takes in a number from the user
(defun input ()
    (let (((tuple 'ok (list guessednum)) (io:fread "What is your guess: " "~d")))
        guessednum))

(defun checkguess (answer guess)
    (cond 
    ((== answer guess)
        (io:format "Well done :)"))
    ((/= answer guess)
        (if (> answer guess) (io:format "The guess is too low.~n"))
        (if (< answer guess) (io:format "The guess is too high.~n"))
        (checkguess answer (input)))
    )
)




(defun main () 
    (io:format "This is a guessing game ~nGuess a number between 1 and 10~n")
    (checkguess
    (random:uniform 10) 
    (input))
)
