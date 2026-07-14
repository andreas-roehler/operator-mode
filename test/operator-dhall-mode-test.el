;;; operator-dhall-mode-test.el --- dhall-mode tests  -*- lexical-binding: t; -*-

;; Copyright (C) 2019-2026  Andreas Röhler

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
  (straight-use-package 'dhall-mode))

(require 'dhall-mode)

(ert-deftest operator-dhall-test-WG0LXr ()
  ""
  (operator-test
      "List { home:"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?:))
    (should (char-equal (char-before (- (point) 2)) 32))))

(ert-deftest operator-dhall-test-Z6KsXh ()
  (operator-test
      "in [ user : \"Foo\","
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?,))
    (should (char-equal (char-before (- (point) 2)) ?\"))))

(ert-deftest operator-dhall-test-xvhXWw ()
  "True || False "
  (operator-test
      "True |"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?|))
    (should (char-equal (char-before (- (point) 2)) 32))))

(ert-deftest operator-dhall-test-D0nvQn ()
  "True || False "
  (operator-test
      "True ||"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?|))
    (should (char-equal (char-before (- (point) 2)) ?|))
    (should (char-equal (char-before (- (point) 3)) 32))
    ))

(ert-deftest operator-dhall-test-eNGnNP ()
  "True && False "
  (operator-test
      "True &"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?&))
    (should (char-equal (char-before (- (point) 2)) 32))))

(ert-deftest operator-dhall-test-4NP4cE ()
  "True && False "
  (operator-test
      "True &&"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?&))
    (should (char-equal (char-before (- (point) 2)) ?&))
    (should (char-equal (char-before (- (point) 3)) 32))
    ))

(ert-deftest operator-dhall-test-OyBW0v ()
  "True == False "
  (operator-test
      "True =="
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) ?=))
    (should (char-equal (char-before (- (point) 3)) 32))
    ))

(ert-deftest operator-dhall-test-L9e7CF ()
  "True == False "
  (operator-test
      "True ="
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-dhall-test-IOUkAD ()
  "2 + 3 "
  (operator-test
      "2 +"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?+))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-dhall-test-mbrxVr ()
  "2 * 3 "
  (operator-test
      "2 *"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?*))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-dhall-test-hAp6Qs ()
  "\"Hello\" ++ \" world\" "
  (operator-test
      "\"Hello\" +"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?+))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-dhall-test-hi9mlS ()
  "\"Hello\" ++ \" world\" "
  (operator-test
      "\"Hello\" ++"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?+))
    (should (char-equal (char-before (- (point) 2)) ?+))
    (should (char-equal (char-before (- (point) 3)) 32))
    ))

(ert-deftest operator-dhall-test-igCnA1 ()
  "[1, 2] # [3, 4] "
  (operator-test
      "[1,"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?,))
    (should (char-equal (char-before (- (point) 2)) ?1))
    ))

(ert-deftest operator-dhall-test-B1Luob ()
  "[1, 2] # [3, 4] "
  (operator-test
      "[1, 2] # [3,"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?,))
    (should (char-equal (char-before (- (point) 2)) ?1))
    ))

(ert-deftest operator-dhall-test-t1hRrk ()
  "[1, 2] # [3, 4] "
  (operator-test
      "[1, 2] #"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?#))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-dhall-test-O6qeJ7 ()
  "{ foo = 1 } ∧ { bar = 2 }"
  (operator-test
      "{ foo = 1 } ∧"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?∧))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-dhall-test-66mXRj ()
  "{ foo = 1 } ∧ { bar = 2 }"
  (operator-test
      "{ foo = 1 } ∧ { bar ="
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-dhall-test-mBhxmq ()
  "{ foo = 1, bar = True } ⫽ { foo = 2 } "
  (operator-test
      "{ foo = 1, bar = True } ⫽"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?⫽))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-dhall-test-63RzFk ()
  "assert : 2 + 2 === 4"
  (operator-test
      "assert :"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?:))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-dhall-test-K0kfM4 ()
  "assert : 2 + 2 === 4"
  (operator-test
      "assert : 2 + 2 ="
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-dhall-test-ea7xLp ()
  "assert : 2 + 2 === 4"
  (operator-test
      "assert : 2 + 2 =="
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) ?=))
    (should (char-equal (char-before (- (point) 3)) 32))
    ))


(ert-deftest operator-dhall-test-UPQaMW ()
  "assert : 2 + 2 === 4"
  (operator-test
      "assert : 2 + 2 =="
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) ?=))
    (should (char-equal (char-before (- (point) 3)) 32))
    ))

(ert-deftest operator-dhall-test-NQWJwD ()
  "assert : 2 + 2 === 4"
  (operator-test
      "assert : 2 + 2 =="
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) ?=))
    (should (char-equal (char-before (- (point) 3)) ?=))
    (should (char-equal (char-before (- (point) 4)) 32))
    ))


(ert-deftest operator-dhall-test-vamQZV ()
  "assert : 2 + 2 ≡ 4"
  (operator-test
      "assert : 2 + 2 ≡"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?≡))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-dhall-test-EDoxWO ()
  "record.{ x, y }"
  (operator-test
      "record."
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) ?.))
    (should (char-equal (char-before (- (point) 1)) ?d))
    ))

(ert-deftest operator-dhall-test-0nLiX8 ()
   "record.({ x : Natural })"
  (operator-test
      "record.("
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) ?\())
    (should (char-equal (char-before (- (point) 1)) ?.))
    ))

(ert-deftest operator-dhall-test-PVgYYN ()
   "record.({ x : Natural })"
  (operator-test
      "record.("
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) ?\())
    (should (char-equal (char-before (- (point) 1)) ?.))
    ))

(ert-deftest operator-dhall-test-cjyBuA ()
  "record.({ x : Natural })"
  (operator-test
      "record.({"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) ?{))
    (should (char-equal (char-before (- (point) 1)) ?\())
    ))

(ert-deftest operator-dhall-test-DWvbaB ()
  "record.({ x : Natural })"
  (operator-test
      "record.({ x : Natural }"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) ?}))
    (should (char-equal (char-before (- (point) 1)) 32))
    (should (char-equal (char-before (- (point) 2)) ?l))
    ))

(ert-deftest operator-dhall-test-aUnVV5 ()
  "record.({ x : Natural })"
  (operator-test
      "record.({ x : Natural })"
    'dhall-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) ?\)))
    (should (char-equal (char-before (- (point) 1)) ?}))
    ))

;; "record.({ x : Natural })"



(provide 'operator-dhall-mode-test)
;;; operator-dhall-mode-test.el ends here
