;;; operator-python-mode-test.el --- operator python-mode tests  -*- lexical-binding: t; -*-

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

(ert-deftest operator-python-test-JSKBng ()
  (operator-test
      "a*"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 32))
    ))

(ert-deftest operator-python-test-Ye2u2d ()
  (operator-test
      ;; "{a:1}"
      ;; "{a: 1}"
      "{a:"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "{a: " (line-beginning-position)))))

(ert-deftest operator-python-test-qk54K8 ()
  (operator-test
      "a = itertools.starmap(lambda x,y:"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "a = itertools.starmap(lambda x,y: " (line-beginning-position)))))

(ert-deftest operator-python-test-b7WSVI ()
  (operator-test
      "def f(x, y):"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "def f(x, y):" (line-beginning-position)))))

(ert-deftest operator-python-test-wMe1nG ()
  (operator-test
      "def f(x"
    'python-mode
    operator-mode-debug
    (insert ",")
    (operator-do)
    (should (looking-back "def f(x, " (line-beginning-position)))))

(ert-deftest operator-python-test-IWe5uE ()
  (operator-test
      "def f(x): return 2*"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) ?*)))) 

(ert-deftest operator-python-test-sFlZBF ()
  (operator-test
      "map(x.__add__,"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "map(x.__add__, " (line-beginning-position)))))

(ert-deftest operator-python-test-zbLLBK ()
  (operator-test
      "def foo(x):
    if x >="
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "if x >= " (line-beginning-position)))))

(ert-deftest operator-python-test-5P8YxK ()
  (operator-test
      "def foo(x):
    if x>"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "if x > " (line-beginning-position)))))

(ert-deftest operator-python-test-r0usNr ()
  (operator-test
      ;; a[2:-1]
      "a[2:-"
    'python-mode
    operator-mode-debug
    (operator-do)
    ;; (should (looking-back "a\[-2:-"))
    (should (eq (char-before) ?-))
    (should (eq (point) 6))))

(ert-deftest operator-python-test-lWxlOq ()
  (operator-test
      ;; def munge() -> AnyStr:
      "def munge()-"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "def munge() -" (line-beginning-position)))))

(ert-deftest operator-python-test-j935xv ()
  (operator-test
      ;; def munge() -> AnyStr:
      "def munge() ->"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "def munge() -> " (line-beginning-position)))))

(ert-deftest operator-python-test-3jUN8a ()
  (operator-test
      "foo = long_function_name(var_one,"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "foo = long_function_name(var_one, " (line-beginning-position)))))

(ert-deftest operator-python-test-KEKwec ()
  (operator-test
      "my_list = [
    1,"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-qJcBTq ()
  (operator-test
      "result = some_function_that_takes_arguments(
    'a',"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-a7WdXi ()
  (operator-test
      "with open('/path/to/some/file/you/want/to/read') as file_1,"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (point) 61))
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-bKwOMr ()
  (operator-test
      "open('/path/to/some/file', 'w') as file_2:"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should-not (char-equal (char-before (- (point) 2)) 32)) 
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-xo23nI ()
  (operator-test
   ;; "return self.first_name, self.last_name"
      "return self.first_name,"
      'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-2hONlD ()
  (operator-test
      ;; if x == 4: print (x, y); x, y = y, x
      "if x =="
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-2uqMP5 ()
  (operator-test
      ;; if x == 4: print (x, y); x, y = y, x
      "if x == 4:"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-f7dTlN ()
  (operator-test
      ;; if x == 4: print (x, y); x, y = y, x
      "if x == 4: print(x,"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-KT9scw ()
  (operator-test
      ;; if x == 4: print (x, y); x, y = y, x
      "if x == 4: print (x, y);"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should-not (eq (char-before (- (point) 2)) 32))
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-VHbUyU ()
  (operator-test
      ;; if x == 4: print (x, y); x, y = y, x
      "if x == 4: print (x, y); x,"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-E5nIoH ()
  (operator-test
      ;; if x == 4: print (x, y); x, y = y, x
      "if x == 4: print (x, y); x, y ="
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-5FYYEH ()
  (operator-test
      ;; if x == 4: print (x, y); x, y = y, x
      "if x == 4: print (x, y); x, y = y,"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-qxKIGs ()
  (operator-test
   ;; def __getattribute__(*args):
      "def __getattribute__(*"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) ?*))))

(ert-deftest operator-python-test-6QxMus ()
  (operator-test
      ;; if sys.version_info < (3, 5, 2):
      "if sys."
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (point) 8))
    (should (eq (char-before) ?.))))

(ert-deftest operator-python-test-htZat5 ()
  (operator-test
      ;; if sys.version_info < (3, 5, 2):
      "if sys.version_info<"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "if sys.version_info < " (line-beginning-position)))))

(ert-deftest operator-python-test-lbGFpL ()
  (operator-test
      ;; if sys.version_info < (3, 5, 2):
      "if sys.version_info < (3,"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-NowbCJ ()
  (operator-test
      ;; 2 + ~3
      "2 + ~"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) ?~)))) 

(ert-deftest operator-python-test-cgHjuh ()
  (operator-test
      ;; 2 ** 4
      "2 **"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-7VGT6K ()
  (operator-test
   ;; print('%(language)s has %(number)03d quote types.' %
   ;;     {'language': "Python", "number": 2})
      "print('%"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) ?%))))

(ert-deftest operator-python-test-mxZ2mS ()
  (operator-test
   ;; print('%(language)s has %(number)03d quote types.' %
   ;;     {'language': "Python", "number": 2})
      "print('%(language)s has %(number)03d quote types.'%"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "print('%(language)s has %(number)03d quote types.' % " (line-beginning-position)))))

(ert-deftest operator-python-test-iJlXlE ()
  (operator-test
   ;; print('%(language)s has %(number)03d quote types.' %
   ;;     {'language': "Python", "number": 2})
      "print('%(language)s has %(number)03d quote types.' %
       {'language':"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should-not (char-equal (char-before (- (point) 2)) 32))
    (should (char-equal (char-before) 32))))

(ert-deftest operator-python-test-glTH9g ()
  (operator-test
   ;; print('%(language)s has %(number)03d quote types.' %
   ;;     {'language': "Python", "number": 2})
      "print('%(language)s has %(number)03d quote types.' %
       {'language': \"Python\","
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) 32))))

(ert-deftest operator-python-test-Ke7xUy ()
  (operator-test
      ;; echo(**kargs)
      "echo(**"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (eq (char-before) ?*))))

(ert-deftest operator-python-test-9knueD ()
  (operator-test
      ;; for i in c:
      "for i in c:"
    'python-mode
    operator-mode-debug
    (operator-do)
    (should (looking-back "for i in c: " (line-beginning-position)))))

(ert-deftest operator-python-test-bhxLZC ()
  (operator-test
      ;; for i in c:
      "foo -="
    'python-mode
    operator-mode-debug
    (forward-char -1) 
    (operator-do)
    (should (looking-back "for i in c: " (line-beginning-position)))))


(provide 'operator-python-mode-test)
;;; operator-python-mode-test.el ends here

