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


(provide 'operator-dhall-mode-test)
;;; operator-dhall-mode-test.el ends here
