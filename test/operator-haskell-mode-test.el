;;; operator-haskell-mode-test.el --- haskell-mode tests  -*- lexical-binding: t; -*-

;; Copyright (C) 2019-2024  Andreas Röhler

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
(require 'operator-setup-tests)

(unless
    ;;  check for remote environment
    (string= "0" (getenv "WERKSTATT"))
  (straight-use-package 'haskell-mode))

(require 'haskell)

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
    (should (eq (char-before (1- (point))) ?$))
    (should (eq (char-before) 32))
    ))

(ert-deftest operator-haskell-test-qQJe8A ()
  (operator-test
      ;; "even <$> (2,2)"
      "even <$> (2,"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should-not (char-equal (char-before) ?,))
    (should (char-equal (char-before (1- (point))) ?,))
    ))

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
   ;; (should (looking-back "(september <" (line-beginning-position)))
   (should (char-equal (char-before) ?<))
   (should (char-equal (char-before (1- (point))) 32))
   ))

(ert-deftest operator-haskell-test-AzSYl6 ()
  (operator-test
   ;; "(september <|> oktober)"
   "(september <|"
   'haskell-mode
   operator-mode-debug
   (operator-do)
   (should (looking-back "(september <|" (line-beginning-position)))
   (should (char-equal (char-before) ?|))))

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
    (should (eq (char-after 9) 32))
    (should (eq (char-after 8) ?+))
    (should (eq (char-after 7) ?+))
    (should (eq (char-after 6) 32))))

(ert-deftest operator-haskell-test-y0Tbwj ()
  (operator-test
      "[2,3] ++["
    'haskell-mode
    operator-mode-debug
    (backward-char)
    (operator-do)
    (forward-char 1)
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
    (should (looking-back "maior (x:"))))

(ert-deftest operator-haskell-test-tBhN5B ()
  (operator-test
      "maior (x:xs) | (x > maior xs) =  x
             |"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (eq (current-column) 15))))

(ert-deftest operator-haskell-in-bracket-list-test-tBhN5B ()
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
    (should (eq (char-after 10) 32))
    (should (eq (char-after 9) ?+))
    (should (eq (char-after 8) ?+))
    (should (eq (char-after 7) 32))
    ))

(ert-deftest operator-haskell-after-comment-first-char-test-IAAa4J ()
  (operator-test
      "-"
    'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "-" (line-beginning-position)))))

(ert-deftest operator-haskell-comma-in-record-test-IAAa4J ()
  (operator-test
      "data Record = MRecord
  { name :: String
  ,}"
    'haskell-mode
    operator-mode-debug
    (backward-char)
    (operator-do)
    (should (eq (char-before) 32))
))

(ert-deftest operator-haskell-colon-in-record-test-IAAa4J ()
  (operator-test
      "data Record = MRecord {
  name : : }"
    'haskell-mode
    operator-mode-debug
    (backward-char 2)
    (operator-do)
    (should (looking-back " :: " (line-beginning-position)))))

(ert-deftest operator-haskell-colon-in-list-test-IAAa4J ()
  (operator-test
      "maxhelper a (x:"
    'haskell-mode
    operator-mode-debug
    (backward-char)
    (operator-do)
    (forward-char 1)
    (should (looking-back "x:" (line-beginning-position)))))

(ert-deftest operator-haskell-semicolon-test-IAAa4J ()
  (operator-test
      "https://www.haskell.org/onlinereport/haskell2010/haskellch2.html#x7-210002.7
Figure 2.1: A sample program

module AStack( Stack, push, pop, top, size) where
{data Stack a = Empty
             | MkStack a (Stack a)

;push :: a -> Stack a -> Stack a
;push x s = MkStack x s

;size :: Stack a -> Int
;size s = length (stkToLst s) where
           {stkToLst Empty = []
           ;stkToLst (MkStack x s) = x:xs where {xs = stkToLst s

}};pop :: Stack a -> (a, Stack a)
;pop (MkStack x s)
  = (x, case s of {r -> i r where {i x = x}}) -- (pop Empty) is an error

;top :: Stack a -> a
;top (MkStack x s) = x -- (top Empty) is an error
}
"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward ";top")
    (forward-char 1)
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?\;))
    ))

(ert-deftest operator-haskell-semicolon-test-fxnPvk ()
  (operator-test
      "let foo s f = Command s (\\x -> do f x;return x)"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward ";")
    (forward-char 1)
    (operator-do)
    (should (looking-back "f x; " (line-beginning-position)))))

(ert-deftest operator-haskell-pattern-match-list-test-fxnPvk ()
  (operator-test
      "rvrs (x:"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (operator-do)
    (should (looking-back "rvrs (x:" (line-beginning-position)))))

(ert-deftest operator-haskell-unequal-test-fxnPvk ()
  (operator-test
      "x /="
        'haskell-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "x /= " (line-beginning-position)))))

(ert-deftest operator-haskell-parentized-function-test-fxnPvk ()
  (operator-test
      "(,)"
        'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (backward-char 2)
    (operator-do)
    (goto-char (point-max))
    (should (looking-back "(,)" (line-beginning-position)))))

(ert-deftest operator-haskell-parentized-function-test-h7s455 ()
  (operator-test
      "(->)"
        'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (operator-do)
    (goto-char (point-max))
    (should (looking-back "(->)" (line-beginning-position)))))

(ert-deftest operator-haskell-parentized-function-test-hrH9t0 ()
  (operator-test
      "(->)"
        'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (backward-char)
    (operator-do)
    (goto-char (point-max))
    (should (looking-back "(->)" (line-beginning-position)))))

(ert-deftest operator-haskell-parentized-function-test-uZAVSK ()
  (operator-test
      "(->)"
        'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (backward-char 2)
    (operator-do)
    (goto-char (point-max))
    (should (looking-back "(->)" (line-beginning-position)))))

(ert-deftest operator-haskell-parentized-function-test-iTVzcO ()
  (operator-test
      "(-)"
        'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (backward-char)
    (operator-do)
    (goto-char (point-max))
    (should (looking-back "(-)" (line-beginning-position)))))

(ert-deftest operator-haskell-deriving-list-test-iTVzcO ()
    (operator-test
	"deriving (Eq,Ord, Show)"
      'haskell-mode
      operator-mode-debug
      (goto-char (point-max))
      (search-backward "O")
      (operator-do)
      (should (eq (char-before) 32))
      (should (eq (char-before (1- (point))) ?,))
      ))

(ert-deftest operator-haskell-underscore-test-iTVzcO ()
    (operator-test
	"mylast (_:xs) = mylast xs"
      'haskell-mode
      operator-mode-debug
      (goto-char (point-max))
      (search-backward ":")
      (operator-do)
      (should (looking-back "mylast (_" (line-beginning-position)))))

(ert-deftest operator-haskell-backtick-test-iTVzcO ()
    (operator-test
	"N = a `div`"
      'haskell-mode
      operator-mode-debug
      (goto-char (point-max))
      (skip-chars-backward " \t\r\n\f")
      (operator-do)
      (should (eq (char-before) 32))
      (should (looking-back "`div` " (line-beginning-position)))))

(ert-deftest operator-haskell-semicolon-test-iTVzcO ()
    (operator-test
        "let foo :: Double -> Double;foo x = let { s = sin x;c = cos x } in 2 * s * c"
      'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward ";")
    (forward-char 1)
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?\;))
    (search-backward ";" nil nil 2)
    (forward-char 1)
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?\;))))

(ert-deftest operator-haskell-pipe-test-b28znx ()
  (operator-test
      "primes                     = filterPrime [2..]
  where filterPrime (p:xs) =
          p : filterPrime [x|"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?|))
    (should (eq (char-before (- (point) 2)) 32))))

(ert-deftest operator-haskell-test-yU8shG ()
  (operator-test
      "preplicate x a = a ++ preplicate (x-"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?-))
    (should (eq (char-before (1- (point))) ?x))
    (should (eq (char-before (- (point) 2)) 40))))

(ert-deftest operator-haskell-test-SmctAo ()
  (operator-test
      "foo :: [a]-"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?-))
    (should (eq (char-before (1- (point))) 32))
    (should (eq (char-before (- (point) 2)) ?\]))))

(ert-deftest operator-haskell-test-YtdPFi ()
  (operator-test
      "(x:_"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?_))
    (should (eq (char-before (1- (point))) ?:))
    ))

(ert-deftest operator-haskell-test-skdGcK ()
  (operator-test
      "-- question?"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ??))
    ))

(ert-deftest operator-haskell-test-6ZeR28 ()
  (operator-test
      "(x<="
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?=))
    (should (eq (char-before (1- (point))) ?<))
    ))

(ert-deftest operator-haskell-test-o4OjZK ()
  (operator-test
      "foo (xs:"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?:))
    (should (eq (char-before (1- (point))) ?s))
    ))

(ert-deftest operator-haskell-test-P65Cvf ()
  (operator-test
      "<$>"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward ">")
    (operator-do)
    (should (eq (char-before) ?$))
    (should (eq (char-before (1- (point))) ?<))
    ))

(ert-deftest operator-haskell-test-TYfkgG ()
  (operator-test
      "listeAnhaengen (x:xs) (y:ys) = foldr (\\x (y:ys) -> [x] ++"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?+))
    ))

(ert-deftest operator-haskell-test-ji4kh0 ()
  (operator-test
      "[p x | x<"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?<))
    (should (eq (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-haskell-test-2wrUq6 ()
  (operator-test
      "[f x | x <-"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?-))
    (should (eq (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-haskell-test-XGGwU5 ()
  (operator-test
      "foo ::"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?:))
    (should (eq (char-before (- (point) 2)) ?:))
    ))

(ert-deftest operator-haskell-test-hVxxnw ()
  (operator-test
      "foo :: [a] ->"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?>))
    (should (eq (char-before (- (point) 2)) ?-))
    ))

(ert-deftest operator-haskell-test-uFsFXC ()
  (operator-test
      "foo n="
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?=))
    (should (eq (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-haskell-test-KWCsF5 ()
  (operator-test
      "foo (x:xs)="
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?=))
    (should (eq (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-haskell-test-OrOnpc ()
  (operator-test
      "foo m n = Just (_"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?_))
    (should (eq (char-before (- (point) 2)) 40))
    ))

(ert-deftest operator-haskell-test-zejtSC ()
  (operator-test
      "foo m n = Just (m `div` n)"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) 41))
    (should (eq (char-before (- (point) 2)) ?n))
    ))

(ert-deftest operator-haskell-test-WsP6WZ ()
  (operator-test
      ";; bar n m = baz (foo n+"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?+))
    (should (eq (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-haskell-test-6r3fVE ()
  (operator-test
      "elem 3 (1 : 3:"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?:))
    (should (eq (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-haskell-test-2TvOMX ()
  (operator-test
      "import Prelude hiding (|"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?|))
    (should (eq (char-before (1- (point))) 40))
    (should (eq (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-haskell-test-o50A26 ()
  (operator-test
      "sum' (x:"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?:))
    (should (eq (char-before (1- (point))) ?x))
    (should (eq (char-before (- (point) 2)) 40))
    ))

(ert-deftest operator-haskell-test-8ViBkM ()
  (operator-test
      "a = \"asd\" + +"
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?+))
    (should (eq (char-before (- (point) 2)) ?+))
    ))

(ert-deftest operator-haskell-test-1WqlzB ()
  (operator-test
      "a="
    'haskell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?=))
    (should (eq (char-before (- (point) 2)) 32))
    ))


"trennzeichen(tail xs,(xs !! 0) ++ \" : \" ++"

(provide 'operator-haskell-mode-test)
;;; operator-haskell-mode-test.el ends here
