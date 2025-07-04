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

(ert-deftest operator-scala-test-SbMIhh ()
  (operator-test
      "[+"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) ?+))
    (should (char-equal (char-before (- (point) 1)) ?\[))
    ))

(ert-deftest operator-scala-test-DzrtJ3 ()
  (operator-test
      "case _ ="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    ))

(ert-deftest operator-scala-test-LwiUI5 ()
  (operator-test
      "def foo(bar: Bar):"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?:))
    (should (char-equal (char-before (- (point) 2)) 41))
    ))

(ert-deftest operator-scala-test-4Bbofh ()
  (operator-test
      "b.foreach(x = >"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?>))
    (should (char-equal (char-before (- (point) 2)) ?=))
    ))

(ert-deftest operator-scala-test-5uuUAl ()
  (operator-test
      "b.filter(x => x="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-6sgxTY ()
  (operator-test
      "val a = (_:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-3eynKB ()
  (operator-test
      "b.foreach(println_"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) ?_))
    (should (char-equal (char-before (- (point) 1)) 32))
    (should (char-equal (char-before (- (point) 2)) ?n))
    ))

(ert-deftest operator-scala-test-Z7OFnT ()
  (operator-test
      "foo(0)+"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?+))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-hEkj5y ()
  (operator-test
      "if (x = ="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) ?=))
    ))

(ert-deftest operator-scala-test-qqcKf6 ()
  (operator-test
      "def foo()="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-wcVoit ()
  (operator-test
      "val foo="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-0FgyR2 ()
  (operator-test
      "def foo(abc:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?:))
    (should (char-equal (char-before (- (point) 2)) ?c))
    ))

(ert-deftest operator-scala-test-Fb7XNE ()
  (operator-test
      "def byFoo[A](xs: Seq[A], maxF: Double="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-J218My ()
  (operator-test
"def foo(xs: List[Int], m: Double = 5): List[Int] = {
  privat zff Double="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-wFtHxI ()
  (operator-test
"def ein(xs: List[Int], maxW: Double = 5): List[Int] = {
  foo:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?:))
    (should (char-equal (char-before (- (point) 2)) ?o))
    ))

(ert-deftest operator-scala-test-RY8dL5 ()
  (operator-test
      "case Fixed,"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?,))
    (should (char-equal (char-before (- (point) 2)) ?d))
    ))

(ert-deftest operator-scala-test-QYcfr1 ()
  (operator-test
      "def foo(e: E):"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?:))
    (should (char-equal (char-before (- (point) 2)) 41))
    ))

(ert-deftest operator-scala-test-CgoATO ()
  (operator-test
      "foo(hQuyAM) // Double="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-wk9Rfr ()
  (operator-test
      "def fipFoo[A](xs: Seq[A]): Seq[(A, Int)] = {
  type Acc = (Int, Seq[A])
  val i : Acc = (0, Seq())
  val u: (Acc, A) => Acc = {
    case (pac, x) =>  bar._}
  xs.foldLeft(i)(u)
}
"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "_")
    (forward-char 1)
    (operator-do)
    (should (char-equal (char-before (point)) ?_))
    (should (char-equal (char-before (- (point) 1)) ?.))
    (should (char-equal (char-before (- (point) 2)) ?r))
    ))

(ert-deftest operator-scala-test-jKJbFa ()
  (operator-test
      "def falten[A,"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?,))
    (should (char-equal (char-before (- (point) 2)) ?A))
    ))

(ert-deftest operator-scala-test-50n35X ()
  (operator-test
      "b +:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before (point)) 32))
    (should (char-equal (char-before (- (point) 1)) ?:))
    (should (char-equal (char-before (- (point) 2)) ?+))
    ))

(ert-deftest operator-scala-test-wMG9fK ()
  (operator-test
      "a.reduce(_"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?_))
    (should (char-equal (char-before (- (point) 1)) 40))
    (should (char-equal (char-before (- (point) 2)) ?e))
    ))

(ert-deftest operator-scala-test-RhAkT2 ()
  (operator-test
      "def init: Acc = Map(xs.head._1 ->"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?>))
    (should (char-equal (char-before (- (point) 2)) ?-))
    ))

(ert-deftest operator-scala-test-sOrTO1 ()
  (operator-test
      "if (i != 0)"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "=")
    (operator-do)
    (should (char-equal (char-before) ?!))
    (should (char-equal (char-before (- (point) 1)) 32))
    (should (char-equal (char-before (- (point) 2)) ?i))
    ))

(ert-deftest operator-scala-test-EYUyNi ()
  (operator-test
      "e.map{ x =}"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "}")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-W8ndJW ()
  (operator-test
      "def foo[A, K](xs: Seq[A])(by: A => K): Map[K, Seq[A]] ={"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "{")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?{))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-RP1M7R ()
  (operator-test
      "a.foldLeft(0)(_-"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "{")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?-))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-aE6LvI ()
  (operator-test
      "val q =  (2 to n-"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (search-backward "{")
    (operator-do)
    (should (char-equal (char-before) ?-))
    (should (char-equal (char-before (- (point) 1)) ?n))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-idivQe ()
  (operator-test
      "def foo(bar:"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?:))
    (should (char-equal (char-before (- (point) 2)) ?r))
    ))

(ert-deftest operator-scala-test-UJGIku ()
  (operator-test
      "def foo(a: Long=,"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (search-backward ",")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-Er8CUv ()
  (operator-test
      "def foo(xs: Seq[Int], a: Int): Int =?"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ??))
    (should (char-equal (char-before (- (point) 2)) 32))))

(ert-deftest operator-scala-test-VM1sN5 ()
  (operator-test
      "def foo(xs: Seq[Int], a: Int): Int = ??"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ??))
    (should (char-equal (char-before (- (point) 2)) ??))))

(ert-deftest operator-scala-test-6VtEIS ()
  (operator-test
      "def foo(xs: Seq[Int], a: Int): Int = ???"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ??))
    (should (char-equal (char-before (- (point) 2)) ??))))

(ert-deftest operator-scala-test-h4AKTY ()
  (operator-test
      "new_"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?_))
    (should (char-equal (char-before (- (point) 1)) ?w))
    ))

(ert-deftest operator-scala-test-fNBkPK ()
  (operator-test
      "/ / keep"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (search-backward " ")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?/))
    ))

(ert-deftest operator-scala-test-2BVc9I ()
  (operator-test
      "// keep"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (search-backward " ")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?/))
    ))

(ert-deftest operator-scala-test-QJL4Ci ()
  (operator-test
      "// asdf?"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ??))
    (should (char-equal (char-before (- (point) 2)) ?f))
    ))

(ert-deftest operator-scala-test-wuU2Rr ()
  (operator-test
      "(current.sum<"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?<))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-2lV956 ()
  (operator-test
      "current."
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) ?.))
    (should (char-equal (char-before (- (point) 1)) ?t))
    ))

(ert-deftest operator-scala-test-9rVBu1 ()
  (operator-test
      "else {"
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?{))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-yS24WK ()
  (operator-test
      "{resFoo ="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) 32))
    ))

(ert-deftest operator-scala-test-Wl5NH3 ()
  (operator-test
      "assert(result = ="
    'scala-mode
    operator-mode-debug
    (goto-char (point-max))
    (skip-chars-backward " \t\r\n\f")
    (operator-do)
    (should (char-equal (char-before) 32))
    (should (char-equal (char-before (- (point) 1)) ?=))
    (should (char-equal (char-before (- (point) 2)) ?=))
    ))



(provide 'operator-scala-mode-test)
;;; operator-scala-mode-test.el ends here
