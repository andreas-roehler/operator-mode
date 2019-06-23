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

# This var is set in my bashrc to 0
ORT=${ORT:-1}

echo "\$ORT: $ORT"

TESTDIR=test/
export TESTDIR


FILE1=operator-mode.el
#  FILE2=.cask/24.4/elpa/haskell-mode-20180917.923
#  thingatpt-utils-core-setup-tests.el
TEST1=${TESTDIR}operator-mode-test.el
TEST2=${TESTDIR}operator-haskell-mode-test.el
TEST3=${TESTDIR}operator-python-mode-test.el
TEST4=${TESTDIR}operator-ruby-mode-test.el
echo "\$TEST1: $TEST1"

EU27Q="$HOME/arbeit/emacs/emacs-UA/src/emacs-27.0.50.1"

echo "\$TESTDIR: $TESTDIR"
#  echo \$EU27Q: $EU27Q

if [ -s $EU27Q ]; then
    EMACS=$EU27Q
elif [ -s emacs24 ]; then
    EMACS=emacs24
else
    EMACS=emacs
fi

echo "\$EMACS: $EMACS"

hier () {
    $EMACS -Q --batch \
--eval "(message (emacs-version))" \
--eval "(setq operator-mode-debug nil)" \
--eval "(setq python-indent-offset 4)" \
--eval "(setq python-indent-guess-indent-offset nil)" \
--eval "(setq python-indent-guess-indent-offset-verbose nil)" \
--eval "(add-to-list 'load-path \".cask/25.2/elpa/haskell-mode-20190417.309\")" \
--eval "(require 'haskell-mode)" \
-load $FILE1 \
\
-load $TEST1 \
-load $TEST2 \
-load $TEST3 \
-load $TEST4 \
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
-f ert-run-tests-batch-and-exit
}

if [ $ORT -eq 0 ]; then
    hier
    echo "Lade testumgebung \"$HOSTNAME\""
else
    echo "entfernt"
    echo "Lade testumgebung \"ENTFERNT\""
    entfernt
fi

# -load $FILE3 \
