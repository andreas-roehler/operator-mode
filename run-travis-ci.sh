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
    #  export EMACS="$HOME/emacs-20220306/src/emacs -Q"
    export EMACS=$(echo $(alias $1) | sed "s,alias [^~]*.\([^ ]*\).*,$HOME\1,g")
elif
    [ $1 == e28 ];then
    export EMACS=$(echo $(alias $1) | sed "s,alias [^~]*.\([^ ]*\).*,$HOME\1,g")
elif
    [ $1 == e29 ];then
    export EMACS=$(echo $(alias $1) | sed "s,alias [^~]*.\([^ ]*\).*,$HOME\1,g")
else
    EMACS=emacs
fi

# if [ $1 == e28 ]; then
#     export EMACS=$(echo $(alias e28) | sed 's,alias [^~]*.\([^ ]*\).*,/home/speck\1,g')
# elif
#     [ $1 == e29 ];then
#     export EMACS=$(echo $(alias e29) | sed 's,alias [^~]*.\([^ ]*\).*,/home/speck/\1,g')
# fi

echo "before shift \$EMACS: $EMACS"
shift

echo "\$*: $*"
PDIR=$PWD
echo "\$PWD: $PWD"
# WERKSTATT set in .bashrc, thus unset remotly
WERKSTATT=${WERKSTATT:=1}
echo "\$WERKSTATT: $WERKSTATT"

TESTDIR=$PDIR/test/
#  export TESTDIR
echo "\$TESTDIR: $TESTDIR"

FILE1=operator-mode.el
FILE2=${TESTDIR}operator-setup-tests.el
FILE3=$HOME/arbeit/emacs-lisp/haskell-mode/haskell.el
FILE4=$HOME/arbeit/emacs-lisp/haskell-mode/haskell-customize.el

TEST1=${TESTDIR}operator-python-mode-test.el
TEST2=${TESTDIR}operator-haskell-mode-test.el
TEST3=${TESTDIR}operator-elisp-mode-test.el
TEST4=${TESTDIR}operator-other-test.el
TEST5=${TESTDIR}operator-org-mode-test.el
TEST6=${TESTDIR}operator-scala-mode-test.el
echo "\$TEST1: $TEST1"

#  EU27Q="$HOME/arbeit/emacs/emacs-UA/src/emacs-27.0.50.1"

echo "\$EMACS: $EMACS"

h1 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(setq python-indent-offset 4)" \
--eval "(setq python-indent-guess-indent-offset nil)" \
--eval "(setq python-indent-guess-indent-offset-verbose nil)" \
--eval "(add-to-list 'load-path \"$HOME/arbeit/emacs-lisp/haskell-mode\")" \
-load $FILE1 \
-load $FILE2 \
-load $FILE3 \
\
-load $TEST1 \
-f ert-run-tests-batch-and-exit
}

h2 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(add-to-list 'load-path \"$HOME/arbeit/emacs-lisp/haskell-mode\")" \
-load $FILE1 \
-load $FILE2 \
-load $FILE4 \
-load $FILE3 \
\
-load $TEST2 \
-f ert-run-tests-batch-and-exit
}

h3 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(setq python-indent-offset 4)" \
--eval "(setq python-indent-guess-indent-offset nil)" \
--eval "(setq python-indent-guess-indent-offset-verbose nil)" \
--eval "(add-to-list 'load-path \"$HOME/arbeit/emacs-lisp/haskell-mode\")" \
-load $FILE1 \
-load $FILE2 \
-load $FILE3 \
--eval "(require 'haskell-mode)" \
\
-load $TEST3 \
-f ert-run-tests-batch-and-exit
}

h4 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(setq python-indent-offset 4)" \
--eval "(setq python-indent-guess-indent-offset nil)" \
--eval "(setq python-indent-guess-indent-offset-verbose nil)" \
--eval "(add-to-list 'load-path \"$HOME/arbeit/emacs-lisp/haskell-mode\")" \
-load $FILE1 \
-load $FILE2 \
-load $FILE3 \
--eval "(require 'haskell-mode)" \
\
-load $TEST4 \
-f ert-run-tests-batch-and-exit
}

h5 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(setq python-indent-offset 4)" \
--eval "(setq python-indent-guess-indent-offset nil)" \
--eval "(setq python-indent-guess-indent-offset-verbose nil)" \
--eval "(add-to-list 'load-path \"$HOME/arbeit/emacs-lisp/haskell-mode\")" \
-load $FILE1 \
-load $FILE2 \
-load $FILE3 \
--eval "(require 'haskell-mode)" \
\
-load $TEST5 \
-f ert-run-tests-batch-and-exit
}

h6 () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(setq python-indent-offset 4)" \
--eval "(setq python-indent-guess-indent-offset nil)" \
--eval "(setq python-indent-guess-indent-offset-verbose nil)" \
--eval "(add-to-list 'load-path \"$HOME/arbeit/emacs-lisp/haskell-mode\")" \
-load $FILE1 \
-load $FILE2 \
-load $FILE3 \
--eval "(require 'haskell-mode)" \
\
-load $TEST6 \
-f ert-run-tests-batch-and-exit
}

hier () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(setq python-indent-offset 4)" \
--eval "(setq python-indent-guess-indent-offset nil)" \
--eval "(setq python-indent-guess-indent-offset-verbose nil)" \
--eval "(add-to-list 'load-path \"$HOME/arbeit/emacs-lisp/haskell-mode\")" \
-load $FILE1 \
-load $FILE2 \
-load $FILE3 \
--eval "(require 'haskell-mode)" \
\
-load $TEST1 \
-load $TEST2 \
-load $TEST4 \
-load $TEST5 \
-load $TEST6 \
-f ert-run-tests-batch-and-exit
}

entfernt () {
    emacs -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(setq python-indent-offset 4)" \
--eval "(setq python-indent-guess-indent-offset nil)" \
--eval "(setq python-indent-guess-indent-offset-verbose nil)" \
-load $FILE1 \
\
-load $TEST1 \
-load $TEST3 \
-load $TEST4 \
-load $TEST5 \
-f ert-run-tests-batch-and-exit
}

# echo "cp -u $HOME/arbeit/emacs-lisp/python-modes/components-python-mode/test/py-setup-ert-tests.el $PWD"
# cp -u $HOME/arbeit/emacs-lisp/python-modes/components-python-mode/test/py-setup-ert-tests.el $PWD

if [ $WERKSTATT -eq 0 ]; then
    while getopts 123456789abcdefghijklmnopqrstuvwxyz option
    do
        case $option in
	    1) echo "h1: Lade \$TEST1: \"$TEST1\"";h1;;
	    2) echo "h2: Lade \$TEST2: \"$TEST2\"";h2;;
	    3) echo "h3: Lade \$TEST3: \"$TEST3\"";h3;;
	    4) echo "h4: Lade \$TEST4: \"$TEST4\"";h4;;
	    5) echo "h5: Lade \$TEST5: \"$TEST5\"";h5;;
	    6) echo "h6: Lade \$TEST6: \"$TEST6\"";h6;;
	    #  7) echo "h7: Lade \$TEST7: \"$TEST7\"";h7;;
	    #  8) echo "h8: Lade \$TEST8: \"$TEST8\"";h8;;
	    #  9) echo "h9: Lade \$TEST9: \"$TEST9\"";h9;;
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

    # hier1
    # echo "Lade testumgebung \"HIER1\""
    # hier2
    # echo "Lade testumgebung \"HIER1\""

else
    echo "entfernt"
    echo "\$WERKSTATT: $WERKSTATT"
    echo "Lade testumgebung \"ENTFERNT\""
    entfernt
fi

# if [ $ORT -eq 0 ]; then
#     hier
#     echo "Lade testumgebung \"$HOSTNAME\""
# else
#     echo "entfernt"
#     echo "Lade testumgebung \"ENTFERNT\""
#     entfernt
# fi

# -load $FILE3 \
