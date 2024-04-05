;;; operator-shell-mode-test.el --- operator org-mode tests  -*- lexical-binding: t; -*-

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

(ert-deftest operator-shell-mode-test-C6eGR7 ()
  (operator-test
      "ssh root@"
    'shell-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?@))
    (should (char-equal (char-before (1- (point))) ?t))
    (should (char-equal (char-before (- (point) 2)) ?o))
    ))

(provide 'operator-shell-mode-test)
;;; operator-shell-mode-test.el ends here
