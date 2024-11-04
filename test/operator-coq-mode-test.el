;;; operator-coq-mode-test.el --- operator org-mode tests  -*- lexical-binding: t; -*-

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
(require 'operator-setup-tests)

;; "Definition negb (b:bool) : bool :="
(ert-deftest operator-coq-mode-test-Xou1xZ ()
  (operator-test
      "Definition negb (b:bool):"
    'coq-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (- (point) 1)) ?:))
    (should (eq (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-coq-mode-test-fexqIk ()
  (operator-test
      "Definition orb (b1:bool) (b2:bool) : bool:"
    'coq-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (- (point) 1)) ?:))
    (should (eq (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-coq-mode-test-8ZZj7d ()
  (operator-test
      "Definition my_list : list nat := [47;"
    'coq-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (- (point) 1)) ?\;))
    (should (eq (char-before (- (point) 2)) ?7))
    ))

(ert-deftest operator-coq-mode-test-VNLVki ()
  (operator-test
"Fixpoint foo (n m:nat) : nat :=
  match n, m with
  | O   , _    => O
  | S _ , O    => n
  | S n',"
    'coq-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (- (point) 1)) ?,))
    (should (eq (char-before (- (point) 2)) ?'))
    ))

(ert-deftest operator-coq-mode-test-hL49NR ()
  (operator-test
      "Check andb."
    'coq-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (- (point) 1)) ?.))
    (should (eq (char-before (- (point) 2)) ?b))
    ))



 

(provide 'operator-coq-mode-test)
;;; operator-coq-mode-test.el ends here
