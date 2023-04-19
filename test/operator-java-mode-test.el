;;; operator-java-mode-test.el --- java-mode tests  -*- lexical-binding: t; -*-

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

(require 'ert-x)
(require 'operator-mode)
(require 'operator-setup-tests)

;; (straight-use-package 'java-mode nil nil)
;; cc-mode provides java-mode
(require 'cc-mode)

(ert-deftest operator-java-test-QxYnli ()
  (operator-test
      "public class Foo {
    public state void main(String[] args){
        double perimeter = (length + width)*
"
    'java-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?*))
    (should (char-equal (char-before (- (point) 2)) 32))
))

(ert-deftest operator-java-test-8Nj43I ()
  (operator-test
      ;; for(int foo: bar) {
      "for(int foo:"
    'java-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?: ))
    (should (char-equal (char-before (- (point) 2)) ? ))
))

(ert-deftest operator-java-test-sSguB1 ()
  (operator-test
    "for(int i=0;"
    'java-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?\; ))
    (should (char-equal (char-before (- (point) 2)) ?0))
))

(ert-deftest operator-java-test-SG2qGq ()
  (operator-test
    "String readline ="
    'java-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?= ))
    (should (char-equal (char-before (- (point) 2)) 32))
))

(ert-deftest operator-java-test-XpGqcd ()
  (operator-test
    "while((line = br.readline()) !="
    'java-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?= ))
    (should (char-equal (char-before (- (point) 2)) ?!))
))

(ert-deftest operator-java-test-RW1j7w ()
  (operator-test
    "for(int i=100; i > 51; i = i - 5"
    'java-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?-))
    (should (char-equal (char-before (- (point) 2)) 32))
))

(ert-deftest operator-java-test-Vsjlj2 ()
  (operator-test
      "if (Character.isLetter(i)) {"
    'java-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?{))
    (should (char-equal (char-before (- (point) 2)) 32))
))

(ert-deftest operator-java-test-PAcSxW ()
  (operator-test
      "System.out.format(\"Foo: %"
    'java-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?%))
    (should (char-equal (char-before (- (point) 1)) 32))
    (should (char-equal (char-before (- (point) 2)) ?:))
))

(ert-deftest operator-java-test-yRrfqN ()
  (operator-test
      "return (length +"
    'java-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?+))
    (should (char-equal (char-before (- (point) 2)) 32))
))


(provide 'operator-java-mode-test)
;;; operator-java-mode-test.el ends here
