;;; operator-elisp-mode-test.el --- operator org-mode tests  -*- lexical-binding: t; -*-

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

(ert-deftest operator-elisp-mode-test-b28znx ()
  (operator-test
      "(should (char-equal (char-before (- (point) 2)) ?"
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ??))
    (should (eq (char-before (1- (point))) 32))
    ))

(ert-deftest operator-elisp-mode-test-bydPtv ()
  (operator-test
    "(should (eq (char-before) ?\\;"
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?\;))
    ))

(ert-deftest operator-elisp-mode-test-rDWa1W ()
  (operator-test
      "(char-equal (char-before (- (point) 1)) ?+"
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?+))))

(ert-deftest operator-elisp-mode-test-2ydgoR ()
  (operator-test
      "(let*"
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 32))
    (should (eq (char-before (1- (point))) ?*))
    (should (eq (char-before (- (point) 2)) ?t))
    ))

(ert-deftest operator-elisp-mode-test-4fbp9U ()
  (operator-test
      "(defun foo("
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) 40))
    (should (eq (char-before (1- (point))) ?o))
    ))

(ert-deftest operator-elisp-mode-test-RAo6SE ()
  (operator-test
      "(defun foo_"
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?_))
    (should (eq (char-before (1- (point))) ?o))
    ))

(ert-deftest operator-elisp-mode-test-WJGQDv ()
  (operator-test
      "(insert \":"
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?:))
    (should (eq (char-before (1- (point))) ?\"))
    (should (eq (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-elisp-mode-test-JDrLWE ()
  (operator-test
      "'"
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before) ?'))
    ))

(ert-deftest operator-elisp-mode-test-N9j3Xy ()
  (operator-test
      "'("
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before (1- (point))) ?\'))))

(ert-deftest operator-elisp-mode-test-I46Tsv ()
  (operator-test
      "(with-"
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before (- (point) 1)) ?-))
    (should (eq (char-before (- (point) 2)) ?h))
    ))

(ert-deftest operator-elisp-mode-test-Cwnl9z ()
  (operator-test
      ";;"
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before (point)) 32))
    (should (eq (char-before (- (point) 1)) ?\;))
    (should (eq (char-before (- (point) 2)) ?\;))
    ))

(ert-deftest operator-elisp-mode-test-DJD6Eg ()
  (operator-test
      "-* -"
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (eq (char-before (point)) 32))
    (should (eq (char-before (- (point) 1)) ?-))
    (should (eq (char-before (- (point) 2)) ?*))
    ))

(ert-deftest operator-elisp-mode-test-MIxbpo ()
  (operator-test
      "-*"
    'emacs-lisp-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should-not (eq (char-before (point)) 32))
    (should (eq (char-before (- (point) 1)) ?*))
    (should (eq (char-before (- (point) 2)) ?-))
    ))


(provide 'operator-elisp-mode-test)
;;; operator-elisp-mode-test.el ends here
