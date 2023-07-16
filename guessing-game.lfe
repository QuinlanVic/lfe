;; Copyright (c) 2013-2020 Duncan McGreggor <oubiwann@gmail.com>
;;
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;;
;;     http://www.apache.org/licenses/LICENSE-2.0
;;
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.

;; File    : guessing-game.lfe
;; Author  : Duncan McGreggor
;; Purpose : Demonstrating a random-number guessing game (classic BASIC-era
;;           demo)

;; This file contains a simple demo for guessing a random number, chosen by
;; "the computer". To use, do the following:
;;
;; $ ./bin/lfe
;;
;; > (slurp "guessing-game.lfe")
;; #(ok guessing-game)
;; > (main)
;; Guess the number I have chosen, between 1 and 10.
;; Guess number: 10
;; Your guess is too high.
;; Guess number: 1
;; Your guess is too low.
;; Guess number: 5
;; Your guess is too low.
;; Guess number: 7
;; Well-guessed!!
;; game-over
;; >
;; Quinlan's version :)
(defmodule guessing-game
  (export
    (main 0)))

(defun get-player-guess ()
  (let (((tuple 'ok (list guessed)) (io:fread "Guess number: " "~d")))
    guessed))
  
(defun checkvalid (maxvalue guess)
  (if (or (< guess 1) (> guess maxvalue)) 
    (let () (io:format "Please enter a guess that is within 1 and ~p~n" `(,maxvalue)) 'false) 
    'true))

(defun check-guess (answer guessed maxval numGuess)
    (cond
      ((== (checkvalid maxval guessed) 'false)
        (check-guess answer (get-player-guess) maxval numGuess))
      ((== answer guessed)
        (io:format "Well-guessed!! ~nIt took you ~p valid guesses :)~n" `(,(+ numGuess 1)))
        'game-over)
      ((/= answer guessed)
        (if (> answer guessed) (io:format "Your guess is too low.~n"))
        (if (< answer guessed) (io:format "Your guess is too high.~n"))
        (check-guess answer (get-player-guess) maxval (+ numGuess 1))
    )))
  
  (defun checkMax (maxval)
    (if (or (< maxval 1) (== maxval 1)) (progn (io:format "Please enter a valid number greater than 1~n") (getmax) )
      maxval))

  (defun getmax ()
  (let (((tuple 'ok (list n)) (io:fread "Give me an upper bound number: " "~d")))
    (checkMax n)))
  
  (defun log2 (x)
    (/ (math:log x) (math:log 2)))

  (defun log2func (max-value)
    (if (== max-value 2) '2 ; special case
    (let ((log-value (log2 max-value)))
      (math:ceil log-value))))
  
  (defun optimal (max-value)
    (let ((optimalguesses (log2func max-value)))
    (io:format "By guessing the midpoint of the min and max numbers of the possible interval after each guess you should have a maximum of ~p guesses before arriving at the answer~n" `(,optimalguesses)) 
    ))

(defun main ()
  (let ((maxval (getmax)))
    (io:format "Guess the number I have chosen, between (inclusive) 1 and ~p~n" `(,maxval)) ;Old = `(,(getmax))
    (optimal maxval)
    (check-guess
      (random:uniform maxval) ;;Very tricky to get maxval to get printed and passed in as a normal number, all about let scope
      (get-player-guess)
      maxval
      0)))
    
