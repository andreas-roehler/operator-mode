;;; operator-scala-mode-test.el --- scala-mode tests  -*- lexical-binding: t; -*-

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

;; (straight-use-package 'scala-mode nil nil)
;; (require 'scala-mode)

(ert-deftest operator-scala-test-QxYnli ()
  (operator-test
      ;; map { y => (x, y) -> x * y })
      "map { y = >"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 2)) ?=))
))

(ert-deftest operator-scala-test-esLbyl ()
  (operator-test
      ;; map { y => (x, y) -> x * y })
      "map { y => (x,"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 2)) ?x))
))

(ert-deftest operator-scala-test-DtQE9A ()
  (operator-test
      ;; map { y => (x, y) -> x * y })
      "map { y => (x, y)"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 2)) ?y))
))

(ert-deftest operator-scala-test-QQXqal ()
  (operator-test
      ;; map { y => (x, y) -> x * y })
      "map { y => (x, y) -"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "-")
    (forward-char 1)
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 2)) 32))
))

(ert-deftest operator-scala-test-4eRSsr ()
  (operator-test
      ;; map { y => (x, y) -> x * y })
      "map { y => (x, y) ->"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 2)) ?-))
))

(ert-deftest operator-scala-test-WG0LXr ()
  (operator-test
      ;; map { y => (x, y) -> x * y })
      "map { y => (x, y) -> x*y })"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "y")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 2)) 32))
))

(ert-deftest operator-scala-test-rC3gMh ()
  (operator-test
      "def summ(list:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward ":")
    (forward-char 1)
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 2)) ?t))))

(ert-deftest operator-scala-test-AodEpd ()
  (operator-test
      ;; "if (list.isEmpty)"
      "if (list."
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    ;; (search-backward "i")
    (operator-do)
    (should (char-equal (char-before) ?.))
    (should (char-equal (char-after) ?i))))

(ert-deftest operator-scala-test-9mRanL ()
  (operator-test
      " { case list."
    'scala-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) ?.))
    (should (char-equal (char-after) ?t))))

(ert-deftest operator-scala-test-lnfWry ()
  (operator-test
      "if (!args.isEmpty)"
    'scala-mode
    operator-mode-debug
    (operator-do)
    (should (char-equal (char-before) 41))
    (should (char-equal (char-before (1- (point))) ?y))))

(ert-deftest operator-scala-test-YkkZEa ()
  "ThisBuild / version := \"0.1.0-SNAPSHOT\"
ThisBuild / scalaVersion := \"2.13.10\"
lazy val root = (project in file(\".\"))
  .settings(name := \"\"\"muster4\"\"\")
"
  (operator-test
"lazy val root = (project in file(\".\"))
  .settings(name:
"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward ":")
    (forward-char 1)
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
))

(ert-deftest operator-scala-test-716twd ()
  (operator-test
      "import org.scalatest.{BeforeAndAfterAll,"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward ",")
    (forward-char 1)
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?,))
    (should (char-equal (char-before (- (point) 2)) ?l))
))

(ert-deftest operator-scala-test-0FgiaA ()
  (operator-test
      "object HelloWorld {
  def main(args: Array[String]): Unit =
}
"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "=")
    (forward-char 1)
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    (should (char-equal (char-before (- (point) 3)) ?t))
    ))

(ert-deftest operator-scala-test-DWfHzU ()
  (operator-test
      "try {
  val f = new FileReader(\"input.txt\")
  // Use and close file
} catch {
  case ex: FileNotFoundException => // Handle missing file
  case ex: IOException => // Handle other I/O error
}
"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward ":")
    (forward-char 1)
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) ?x))
    ))

(ert-deftest operator-scala-test-J3TTm1 ()
  (operator-test
      "val firstArg = if (args.length > 0) args(0) else \"\"
firstArg match {
  case \"salt\" => println(\"pepper\")
  case \"chips\" => println(\"salsa\")
  case \"eggs\" => println(\"bacon\")
  case _ =
}
"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "=")
    (forward-char 1)

    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-YhKxhc ()
  (operator-test
      "foo.asdf(10, 10);"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (operator-do)
    (should (char-equal (char-before) ?\;))
    (should (char-equal (char-before (1- (point))) ?\)))))

(ert-deftest operator-scala-test-aleBTE ()
  (operator-test
      "println(file)\;"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (operator-do)
    (should (char-equal (char-before) ?\;))
    (should (char-equal (char-before (1- (point))) ?\)))
    ))

(ert-deftest operator-scala-test-v4ANY8 ()
  (operator-test
      "b.map{ case i="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-Mrj6Fc ()
  (operator-test
"case class Foo(bar: Int, baz: Int):
    val foo = bar*"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?*))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-G9ioqN ()
  (operator-test
      "def reorder[A](p: Seq[A], q: Seq[Int]): Seq[A] = ??"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ??))
    (should (char-equal (char-before (- (point) 2)) ??))
    ))

(ert-deftest operator-scala-test-DeJuWP ()
  (operator-test
      "def add20 (List[List[Int]]): List[List[Int]] =?"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ??))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-2SB89W ()
  (operator-test
      "val b = a.map{ case x => x._1 + 4 * x._2*"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?*))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-3Nb3dt ()
  (operator-test
      "val result = d + +"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?+))
    (should (char-equal (char-before (- (point) 2)) ?+))
    (should (char-equal (char-before (- (point) 3)) 32))
    ))

(ert-deftest operator-scala-test-ahDbKJ ()
  (operator-test
      "List(((a.last), false))+"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?+))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-GekdAP ()
  (operator-test
      "def foo(a: Seq[Int]): Seq[(Int, Boolean)] = {
  ??
}"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "?")
    (forward-char 1)
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ??))
    (should (char-equal (char-before (- (point) 2)) ??))
    ))

(ert-deftest operator-scala-test-ocYQwh ()
  (operator-test
      "def foo(p: Seq[String], q: Seq[Int]): Map[Int, String] =?"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ??))
    (should (char-equal (char-before (- (point) 2)) 32))
    (should (char-equal (char-before (- (point) 3)) ?=))
    ))

(ert-deftest operator-scala-test-PiQs01 ()
  (operator-test
      "assert(result = ="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?=))
    (should (char-equal (char-before (- (point) 2)) ?=))
    (should (char-equal (char-before (- (point) 3)) 32))
    ))

(ert-deftest operator-scala-test-oxTDsE ()
  (operator-test
      "val q =  (2 to n-"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?-))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-GUw5xF ()
  (operator-test
      "def foo(p: Seq[String], q: Seq[Int]): Map[Int, String] = ?"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ??))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-2MEd2R ()
  (operator-test
      "() ="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-N9FXhY ()
  (operator-test
      "def foo(a: Seq[Int]):"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) ?\)))
    ))

(ert-deftest operator-scala-test-RaJJWJ ()
  (operator-test
      "done s ::"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) ?:))
    ))

(ert-deftest operator-scala-test-jYdv57 ()
  (operator-test
      "done s:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-1lsiJg ()
  (operator-test
      "{ (acc, x) => acc:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-yKqL97 ()
  (operator-test
      "(-15, false, 10) /"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?/))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-AvtVSh ()
  (operator-test
      "(-15, false, 10) //"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?/))
    (should (char-equal (char-before (- (point) 2)) ?/))
    ))

(ert-deftest operator-scala-test-Bupm51 ()
  (operator-test
      "val expected:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) ?d))))

(ert-deftest operator-scala-test-oZfYz8 ()
  (operator-test
      "(x: (A, A))._1"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?1))
    (should (char-equal (char-before (1- (point))) ?_))
    ;; (should (char-equal (char-before (- (point) 2)) ?d)))
  ))

(ert-deftest operator-scala-test-1IIr1Y ()
  "=> result :+ ((x, default))"
  (operator-test
      "=> result:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) 32))))

(ert-deftest operator-scala-test-QAo56H ()
  (operator-test
      "case ex:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) ?x))))

(ert-deftest operator-scala-test-06giAO ()
  (operator-test
      "{ case (x, y) => y : :"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) ?:))))

(ert-deftest operator-scala-test-0zaWjo ()
  (operator-test
      "val result:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) ?t))))

(ert-deftest operator-scala-test-AOW04t ()
  (operator-test
      "def doppel(x:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) ?x))))

(ert-deftest operator-scala-test-Ldcxsr ()
  (operator-test
      "xs.foldLeft(init){ (x, y) => x:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) 32))))

(ert-deftest operator-scala-test-sHdJ9L ()
  (operator-test
      "def toPairs_"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?_))
    (should (char-equal (char-before (1- (point))) ?s))
    ))

(ert-deftest operator-scala-test-jK7nXo ()
  (operator-test
      ".map{case k => k._"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?_))
    (should (char-equal (char-before (1- (point))) ?.))
    ))

(ert-deftest operator-scala-test-hCs5fn ()
  (operator-test
      "val a =  0 : :"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    ))

(ert-deftest operator-scala-test-QlueoL ()
  (operator-test
      "case class Foo(bar:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (1- (point))) ?:))
    (should (char-equal (char-before (- (point) 2)) ?r))
    ))



;; xs.foldLeft(init){ (x, y) => x :+ y._1 :+ y._2 }
(provide 'operator-scala-mode-test)
;;; operator-scala-mode-test.el ends here
