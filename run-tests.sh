#!/bin/sh

# Author: Andreas Roehler <andreas.roehler@online.de>

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
# Commentary:

# This script tests functions from ar-mode.el.

# Code:


if [ $1 == e25 ]; then
    export EMACS=$(echo $(alias $1) | sed "s,alias [^~]*.\([^ ]*\).*,$HOME\1,g")
elif
    [ $1 == e26 ];then
    export EMACS=$(echo $(alias $1) | sed "s,alias [^~]*.\([^ ]*\).*,$HOME\1,g")
elif
    [ $1 == e27 ];then
    export EMACS=$(echo $(alias $1) | sed "s,alias [^~]*.\([^ ]*\).*,$HOME\1,g")
elif
    [ $1 == e28 ];then
    export EMACS=$(echo $(alias $1) | sed "s,alias [^~]*.\([^ ]*\).*,$HOME\1,g")
elif
    [ $1 == e29 ];then
    export EMACS=$(echo $(alias $1) | sed "s,alias [^~]*.\([^ ]*\).*,$HOME\1,g")
elif
    [ $1 == e30 ];then
    export EMACS=$(echo $(alias $1) | sed "s,alias [^~]*.\([^ ]*\).*,$HOME\1,g")
else
    EMACS=emacs
fi

echo "before shift \$EMACS: $EMACS"
shift

echo "\$*: $*"
PDIR=$PWD
echo "\$PWD: $PWD"

# WERKSTATT set in .bashrc, thus unset remotly
WERKSTATT=${WERKSTATT:=1}
echo "\$WERKSTATT: $WERKSTATT"

TESTDIR=$PDIR/test
export TESTDIR
echo "\$TESTDIR: $TESTDIR"

echo "\$SCALAMODE: $SCALAMODE"


IFLOCAL=${IFLOCAL:=1}

SETUP=${TESTDIR}/operator-setup-tests.el

FILE1=operator-mode.el

TEST1=${TESTDIR}/operator-python-mode-test.el
TEST2=${TESTDIR}/operator-elisp-mode-test.el
TEST3=${TESTDIR}/operator-sh-mode-test.el
TEST4=${TESTDIR}/operator-other-test.el
TEST5=${TESTDIR}/operator-org-mode-test.el
TEST6=${TESTDIR}/operator-shell-mode-test.el
TEST7=${TESTDIR}/operator-java-mode-test.el
TEST8=${TESTDIR}/operator-scala-mode-test.el
TEST9=${TESTDIR}/operator-haskell-mode-test.el

echo "\$TEST1: $TEST1"

#  EU27Q="$HOME/arbeit/emacs/emacs-UA/src/emacs-27.0.50.1"

echo "\$EMACS: $EMACS"

h1 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(require 'operator-mode)" \
--eval "(add-to-list 'load-path (concat (getenv \"PWD\") \"/test\"))" \
--eval "(require 'operator-setup-tests)" \
--eval "(require 'operator-python-mode-test)" \
--eval "(setq operator-mode-debug nil)" \
--eval "(setq python-indent-offset 4)" \
--eval "(setq python-indent-guess-indent-offset nil)" \
--eval "(setq python-indent-guess-indent-offset-verbose nil)" \
-f ert-run-tests-batch-and-exit
}

h2 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(require 'operator-mode)" \
--eval "(add-to-list 'load-path (concat (getenv \"PWD\") \"/test\"))" \
--eval "(require 'operator-setup-tests)" \
\
-load $TEST2 \
-f ert-run-tests-batch-and-exit
}

h3 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(require 'operator-mode)" \
--eval "(add-to-list 'load-path (concat (getenv \"PWD\") \"/test\"))" \
--eval "(require 'operator-setup-tests)" \
\
-load $TEST3 \
-f ert-run-tests-batch-and-exit
}

h4 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(require 'operator-mode)" \
--eval "(add-to-list 'load-path (concat (getenv \"PWD\") \"/test\"))" \
--eval "(require 'operator-setup-tests)" \
--eval "(require 'haskell-mode)" \
\
-load $TEST4 \
-f ert-run-tests-batch-and-exit
}

h5 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(require 'operator-mode)" \
--eval "(add-to-list 'load-path (concat (getenv \"PWD\") \"/test\"))" \
--eval "(require 'operator-setup-tests)" \
\
-load $TEST5 \
-f ert-run-tests-batch-and-exit
}

h6 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(require 'operator-mode)" \
--eval "(add-to-list 'load-path (concat (getenv \"PWD\") \"/test\"))" \
--eval "(require 'operator-setup-tests)" \
\
-load $TEST6 \
-f ert-run-tests-batch-and-exit
}

# cc-mode provides java-mode
h7 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(require 'operator-mode)" \
--eval "(add-to-list 'load-path (concat (getenv \"PWD\") \"/test\"))" \
--eval "(require 'operator-setup-tests)" \
--eval "(cc-require 'cc-mode)" \
\
-load $TEST7 \
-f ert-run-tests-batch-and-exit
}

h8 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(add-to-list 'load-path (getenv \"SCALAMODE\"))" \
--eval "(require 'scala-mode)" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(require 'operator-mode)" \
--eval "(add-to-list 'load-path (concat (getenv \"PWD\") \"/test\"))" \
--eval "(require 'operator-setup-tests)" \
\
-load $TEST8 \
-f ert-run-tests-batch-and-exit
}

h9 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(add-to-list 'load-path (getenv \"HASKELLMODE\"))" \
--eval "(require 'haskell-mode)" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(require 'operator-mode)" \
--eval "(add-to-list 'load-path (concat (getenv \"PWD\") \"/test\"))" \
--eval "(require 'operator-setup-tests)" \
\
-load $TEST9 \
-f ert-run-tests-batch-and-exit
}

hier () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(require 'operator-mode)" \
--eval "(add-to-list 'load-path (concat (getenv \"PWD\") \"/test\"))" \
--eval "(require 'operator-setup-tests)" \
--eval "(add-to-list 'load-path (getenv \"SCALAMODE\"))" \
--eval "(require 'scala-mode)" \
--eval "(add-to-list 'load-path (getenv \"HASKELLMODE\"))" \
--eval "(require 'haskell-mode)" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(setq python-indent-offset 4)" \
--eval "(setq python-indent-guess-indent-offset nil)" \
--eval "(setq python-indent-guess-indent-offset-verbose nil)" \
\
-load $TEST1 \
-load $TEST2 \
-load $TEST3 \
-load $TEST4 \
-load $TEST5 \
-load $TEST6 \
-load $TEST7 \
-load $TEST8 \
-load $TEST9 \
-f ert-run-tests-batch-and-exit
}

entfernt () {
    emacs -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(setq python-indent-offset 4)" \
--eval "(setq python-indent-guess-indent-offset nil)" \
--eval "(setq python-indent-guess-indent-offset-verbose nil)" \
--eval "(add-to-list 'load-path (getenv \"PWD\"))" \
--eval "(require 'operator-mode)" \
--eval "(add-to-list 'load-path (concat (getenv \"PWD\") \"/test\"))" \
--eval "(require 'operator-setup-tests)" \
\
-load $TEST1 \
-load $TEST3 \
-load $TEST4 \
-load $TEST5 \
-load $TEST6 \
-f ert-run-tests-batch-and-exit
}

if [ $IFLOCAL != 1 ]; then
    while getopts 123456789abcdefghijklmnopqrstuvwxyz option
    do
        case $option in
	    1) echo "h1: Lade \$TEST1: \"$TEST1\"";h1;;
	    2) echo "h2: Lade \$TEST2: \"$TEST2\"";h2;;
	    3) echo "h3: Lade \$TEST3: \"$TEST3\"";h3;;
	    4) echo "h4: Lade \$TEST4: \"$TEST4\"";h4;;
	    5) echo "h5: Lade \$TEST5: \"$TEST5\"";h5;;
	    6) echo "h6: Lade \$TEST6: \"$TEST6\"";h6;;
	    7) echo "h7: Lade \$TEST7: \"$TEST7\"";h7;;
	    8) echo "h8: Lade \$TEST8: \"$TEST8\"";h8;;
	    9) echo "h9: Lade \$TEST9: \"$TEST9\"";h9;;
	    #  a) echo "h10: Lade \$TEST10: \"$TEST10\"";h10;;
	    #  b) echo "h11: Lade \$TEST11: \"$TEST11\"";h11;;
	    #  c) echo "h12: Lade \$TEST12: \"$TEST12\"";h12;;
	    #  d) echo "h13: Lade \$TEST13: \"$TEST13\"";h13;;
	    #  e) echo "h14: Lade \$TEST14: \"$TEST14\"";h14;;
	    #  f) echo "h15: Lade \$TEST15: \"$TEST15\"";h15;;
	    #  g) echo "h16: Lade \$TEST16: \"$TEST16\"";h16;;
            #  h) echo "h17: Running python-tests.el";h17;;
	    #  i) ;;
	    #  j) echo "h19: Lade \$TEST19: \"$TEST19\"";h19;;
	    #  k) echo "h20: Lade \$TEST20: \"$TEST20\"";h20;;
	    #  l) echo "hier: Lade Testumgebung ‘hier’";hier;;
	    #  m) echo "h20: Lade \$TEST20: \"$TEST20\"";h20;;
	    n) echo "hier: Lade Testumgebung ‘hier’";hier;;
            
	esac
	#  shift
	echo "\$*: $*"
	EMACS=$1
	
    done

else
    echo "entfernt"
    echo "\$WERKSTATT: $WERKSTATT"
    echo "Lade testumgebung \"ENTFERNT\""
    entfernt
fi

