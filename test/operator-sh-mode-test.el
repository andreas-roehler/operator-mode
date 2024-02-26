;;; operator-sh-mode-test.el --- operator org-mode tests  -*- lexical-binding: t; -*-

;; Copyright (C) 2019-2023  Andreas Röhler

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

(ert-deftest operator-sh-mode-test-yRrfqN ()
  (operator-test
      "grep asf\\|"
    'sh-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?\"))
    (should (char-equal (char-before (- (point) 1)) 92))
    ))

(ert-deftest operator-sh-mode-test-u5zIat ()
  (operator-test
      "lspci -k|"
    'sh-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?|))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-sh-mode-test-wezizY ()
  (operator-test
      "alias foo="
    'sh-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?=))
    (should (char-equal (char-before (1- (point))) ?o))
    (should (char-equal (char-before (- (point) 2)) ?o))
    ))

(ert-deftest operator-sh-mode-test-lHpEJP ()
  (operator-test
      "ssh root@"
    'sh-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?@))
    (should (char-equal (char-before (1- (point))) ?t))
    (should (char-equal (char-before (- (point) 2)) ?o))
    ))

(ert-deftest operator-sh-mode-test-3vMQfq ()
  (operator-test
      "foo;"
    'sh-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?\;))
    (should (char-equal (char-before (1- (point))) ?o))
    ))

(ert-deftest operator-sh-mode-test-CGL6M7 ()
  (operator-test
      "echo \"Foo: $i\"&"
    'sh-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?&))
    ))

(ert-deftest operator-sh-mode-test-1a6XP1 ()
  (operator-test
      "echo \"Foo: $i\" &&"
    'sh-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?&))
    ))

(ert-deftest operator-sh-mode-test-Ymohwg ()
  (operator-test
      "echo \"Foo: $i\" & &"
    'sh-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?&))
    (should (char-equal (char-before (- (point) 2)) ?&))
    ))

(ert-deftest operator-sh-mode-test-B1GHrS ()
  (operator-test
      "FOO={"
    'sh-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?{))
    (should (char-equal (char-before (1- (point))) ?=))
    ))


(provide 'operator-sh-mode-test)
;;; operator-sh-mode-test.el ends here
