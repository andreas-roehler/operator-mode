;;; operator-other-test.el --- other tests  -*- lexical-binding: t; -*-

;; Copyright (C) 2019-2020  Andreas Röhler

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

(ert-deftest operator-sql-test-WG0LXr ()
  (operator-test
      "on region_id ="
    'sql-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (looking-back "on region_id = " (line-beginning-position)))))

(ert-deftest operator-java-test-WG0LXr ()
  (operator-test
      "class HelloWorld {
    public static void main(String[] args) {
	String greeting=

    }
}"
    'java-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "=")
    (forward-char 1) 
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (looking-back "String greeting = " (line-beginning-position)))))


;; Org
(ert-deftest operator-orgmode-test-WG0LXr ()
  (operator-test
      ;; Seitenzahl
      "S."
    'org-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))))

;; Shell
;; (ert-deftest operator-shell-mode-test-WG0LXr ()
;;   (operator-test
;;       ;; Seitenzahl
;;       "$"
;;     'shell-mode
;;     operator-mode-debug
;;     (operator-do)
;;     (should (char-equal (char-before) ?$))))
     

(provide 'operator-other-test)
;;; operator-other-test.el ends here
