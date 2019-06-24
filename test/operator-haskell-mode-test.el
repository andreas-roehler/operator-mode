;;; operator-haskell-mode-test.el --- haskell-mode tests  -*- lexical-binding: t; -*-

;; Copyright (C) 2019  Andreas Röhler

;; Author: Andreas Röhler <andreas.roehler@easy-emacs.de>
;; Keywords: convenience

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'ert-x)
(require 'operator-mode)

(ert-deftest operator-haskell-test-WG0LXr ()
  (operator-test
      ;; args <- getArgs
      "args <-"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (looking-back "args <- " (line-beginning-position)))))

(ert-deftest operator-haskell-test-zEgH9T ()
  (operator-test
      "args<"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-haskell-test-tdazYl ()
  (operator-test
      ;; evens n = map f [1..n]
      "evens n = map f [1."
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) ?.))))

(ert-deftest operator-haskell-test-Im4yth ()
  (operator-test
      ;; evens n = map f [1..n]
      "evens n = map f [1.."
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) ?.))))

(ert-deftest operator-haskell-test-2c6LQO ()
  (operator-test
      ;; "f . g = \x -> g (f x)"
      "f."
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))
    (should (looking-back "f \. " (line-beginning-position)))))

(ert-deftest operator-haskell-test-uqZdXW ()
  (operator-test
      ;; "(>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c"
      "(>"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should-not (eq (char-before) 32))
    (should (looking-back "(>" (line-beginning-position)))))

(ert-deftest operator-haskell-test-Vg8syM ()
  (operator-test
      ;; "(>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c"
      "(>=>) ::"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should-not (char-equal (char-before (- (point) 2)) 32))
    (should (eq (char-before) 32))))

(ert-deftest operator-haskell-test-TeUTY8 ()
  (operator-test
      ;; "Monad m =>"
      "Monad m =>"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-haskell-test-vlLlrH ()
  (operator-test
      ;; "(>=>) :: Monad m => (a -> m b) -> (b -> m c) -> a -> m c"
      "(>=>) :: Monad m => (a ->"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-haskell-test-VXpDst ()
  (operator-test
      ;; "pure (."
      "pure (."
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) ?.))))

(ert-deftest operator-haskell-test-TQ7boQ ()
  (operator-test
      ;; "pure ($ y) <*> u"
      "pure ($"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-haskell-test-qQJe8A ()
  (operator-test
      ;; "even <$> (2,2)"
      "even <$> (2,"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) ?,))))

(ert-deftest operator-haskell-test-VbyRmN ()
  (operator-test
      ;; "undefined :: forall (r :: RuntimeRep). forall (a :: TYPE r). "
      "undefined :: forall (r :: RuntimeRep)."
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should-not (char-equal (char-before (- (point) 2)) 32))
    (should (char-equal (char-before) 32))))

(ert-deftest operator-haskell-test-0M8tGE ()
  (operator-test
   ;; "(september <|> oktober)"
   "(september<"
   'haskell-mode
   operator-mode-debug
   (operator-do)
   (should (looking-back "(september < " (line-beginning-position)))
   (should (char-equal (char-before) 32))))

(ert-deftest operator-haskell-test-AzSYl6 ()
  (operator-test
   ;; "(september <|> oktober)"
   "(september <|"
   'haskell-mode
   operator-mode-debug
   (operator-do)
   (should (looking-back "(september <| " (line-beginning-position)))
   (should (char-equal (char-before) 32))))

(ert-deftest operator-haskell-test-O0DZ72 ()
  (operator-test
   "2+"
   'haskell-mode
   operator-mode-debug
   (operator-do)
   (should (looking-back "2 \\+ " (line-beginning-position)))
   (should (char-equal (char-before) 32))))

(ert-deftest operator-haskell-test-d34J2x ()
  (operator-test
      "[2,3] + +"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "[2,3] \\+\\+"))))

(ert-deftest operator-haskell-test-y0Tbwj ()
  (operator-test
      "[2,3] ++["
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back " \\["))
    (should (eq (char-before) ?\[))))

(ert-deftest operator-haskell-test-7mv2Dp ()
  (operator-test
   ;; "(september <|> oktober)"
   "(september <|>"
   'haskell-mode
   operator-mode-debug
   (operator-do)
   (should (looking-back "(september <|> " (line-beginning-position)))
   (should (char-equal (char-before) 32))))

(ert-deftest operator-haskell-test-Mi4QXD ()
  (operator-test
      "maior (x:"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "maior (x"))))

(ert-deftest operator-haskell-test-tBhN5B ()
  (operator-test
      "maior (x:xs) | (x > maior xs) =  x
             |"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (eq (current-column) 15))))

(ert-deftest operator-haskell-in-list-test-tBhN5B ()
  (operator-test
      "[x, y | x<"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "x < " (line-beginning-position)))))

(ert-deftest operator-haskell-in-list-test-QEM7xA ()
  (operator-test
      "[x, y | x <-"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "x <- " (line-beginning-position)))))

(ert-deftest operator-haskell-in-list-test-aym0Go ()
  (operator-test
      ": ["
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back ": \\[" (line-beginning-position)))
    (should (eq (char-before) ?\[))))

(ert-deftest operator-haskell-in-list-test-eAH8dR ()
  (operator-test
      "foo (x:xs)="
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "foo (x:xs) = " (line-beginning-position)))
    (should (eq (char-before) ?\s))))

(ert-deftest operator-haskell-in-list-test-hgtjt1 ()
  (operator-test
      "foo (x:xs) ="
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "foo (x:xs) = " (line-beginning-position)))
    (should (eq (char-before) ?\s))))

(ert-deftest operator-haskell-in-braced-data-test-lZ3VAf ()
  (operator-test
      "data Contact = Contact { name:" 'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "data Contact = Contact { name : " (line-beginning-position)))))

(ert-deftest operator-haskell-in-braced-data-test-6xRxtO ()
  (operator-test
      "data Contact = Contact { name : :" 'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "data Contact = Contact { name :: " (line-beginning-position)))))

(ert-deftest operator-haskell-in-braced-data-test-byuHkX ()
  (operator-test
      "data Contact =  Contact { name :: String
                        ,"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "^ \\{24\\}, +" (line-beginning-position)))))

(ert-deftest operator-haskell-after-minus-test-byuHkX ()
  (operator-test
      "foo :: [[char]] ->"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back " -> " (line-beginning-position)))))

(ert-deftest operator-haskell-after-plus-test-byuHkX ()
  (operator-test
      "foo :: [[char]] ->"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back " -> " (line-beginning-position)))))

(ert-deftest operator-haskell-after-plus-test-IAAa4J ()
  (operator-test
      " foo x ++ \", \" ++"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back " ++ " (line-beginning-position)))))

(ert-deftest operator-haskell-after-comment-first-char-test-IAAa4J ()
  (operator-test
      "-"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "-" (line-beginning-position)))))

(ert-deftest operator-haskell-comma-in-record-test-IAAa4J ()
  (operator-test
      "data Record = MRecord {
  name :: String,}"
    'haskell-mode
    operator-mode-debug
    (backward-char) 
    (operator-do)
    (should (looking-back "String," (line-beginning-position)))
    (should-not (eq (char-before) ?\s))
))

(ert-deftest operator-haskell-colon-in-record-test-IAAa4J ()
  (operator-test
      "data Record = MRecord {
  name : :}"
    'haskell-mode
    operator-mode-debug
    (backward-char) 
    (operator-do)
    (should (looking-back " :: " (line-beginning-position)))))

(provide 'operator-haskell-mode-test)
;;; operator-haskell-mode-test.el ends here
