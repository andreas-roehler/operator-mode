# operator mode

[![CircleCI operator-mode](https://circleci.com/gh/andreas-roehler/operator-mode.svg?style=svg)](https://app.circleci.com/pipelines/gh/andreas-roehler/operator-mode)

Auto-add spaces around operators if appropriate.

For example typing

    a=10*5+2

according to language might result in

    a = 10 * 5 + 2

Should work out of the box for most languages.
Currently the following languages have the own config:

Agda  \
Clojure

Coq

Emacs Lisp

Haskell

Idris

Java

Python

Scala

Shell

Sql

Text

Bug-reports are welcome.

## Setup

Put something like this in your init-file:

(add-to-list 'load-path "/MY-PATH-TO-OPERATOR")
(require 'operator)

Then just M-x `operator-mode` RET. To switch it off just call this
again - resp. with negative argument.

Or add the relevant mode hook.

For example for python-mode write:
    (add-hook 'python-mode-hook #'operator-mode)

## History

This is inspired by [electric-operator]
https://github.com/davidshepherd7/electric-operator.git

Whilst electric-operator is based on a heavily refactored version of
[simple-spacing](https://github.com/xwl/simple-spacing) by William Xu
with contributions from Nikolaj Schumacher. Electric-spacing is itself
based on [smart-operator](http://www.emacswiki.org/emacs/SmartOperator),
also by William Xu.
