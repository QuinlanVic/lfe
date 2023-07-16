(defmodule anagram
    (export (find 2)))
; Quinlan's version :)

;; (defun sort-string-alphabetically (str)
;;   (let* ((char-list (string:characters str))
;;          (sorted-char-list (lists:sort char-list)))
;;     (string:join sorted-char-list)))

;; anagramqm function that checks if the current atom in the list is an anagram of the word
(defun anagramqm (word possanagram)
    (== (lists:sort (string:to_lower word)) (lists:sort (string:to_lower possanagram)))) 
;; Above = convert to lowercase then sort (case insensitive)

;; check if the each atom in the list is an anagram of the word and if it is then add it to a new list using filter
(defun checkana (word newlist) 
    (lists:filter (lambda (listvar) (anagramqm word listvar)) newlist))

;; equalqm function that checks if they are not equal as if they are not equal it will add it to a new list 
(defun equalqm (word possanagram)
    (/= (string:to_lower word) (string:to_lower possanagram)))

;; check if the proposed anagrams are not just the exact same as the word 
(defun checkeq (word anagramlist)
    (lists:filter (lambda (listvar) (equalqm word listvar)) anagramlist))

;; main function that pulls all the others together
(defun find (word anagramlist) (checkana word (checkeq word anagramlist)))

; (defun anagram-check (word word-list)
;   (let* ((lowercase-word (string:to_lower word))
;          (anagram-predicate (lambda (w)
;                               (and (not (== w word))
;                                    (== (lists:sort (string:to_lower w)) (lists:sort lowercase-word))))))

;     (lists:filter anagram-predicate word-list)))


