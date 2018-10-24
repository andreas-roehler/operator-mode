EMACS=emacs
# EMACS=$HOME/arbeit/emacs/emacs-UA/src/emacs-27.0.50.1
CASK ?= cask

build :
	cask exec $(EMACS) -Q --batch --eval             \
	    "(progn                                \
	      (setq byte-compile-error-on-warn t)  \
	      (batch-byte-compile))" operator.el

clean :
	@rm -f *.elc

test: integration

unit: build
	${CASK} exec ert-runner 

integration:
	./run-travis-ci.sh

install:
	${CASK} install

.PHONY:	all test install clean build
