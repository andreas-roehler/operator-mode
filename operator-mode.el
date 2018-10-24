;;; operator-mode.el --- simple electric operator  -*- lexical-binding: t; -*-

;; Copyright (C) 2018  Andreas Röhler

;; Author: Andreas Röhler <andreas.roehler@online.de>
;; Keywords: convenience

;; Version: 0.0.1
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

;;; Commentary: This is a still naive prototype

;;

;;; Code:

(defvar operator-debug t
  "Debugging mode")

(defvar-local operator-known-operators-spaced-maybe (list ?| ?~ ?^ ?@ ?- ?+ ?* ?: ?. ?, ?! ?$ ?% ?& ?/ ?= ?< ?> ?\;)
  "Known chars used as operators.")
;; (setq operator-known-operators-spaced-maybe (list ?| ?~ ?^ ?@ ?- ?+ ?* ?: ?. ?, ?! ?$ ?% ?& ?/ ?= ?< ?> ?\;))

;; cl-map might not be available
;; (defvar-local operator-known-operators-spaced-maybe-strg (cl-map 'string 'identity operator-known-operators-spaced-maybe)
;;   "Used to skip over operators at point.")

(defun operator-setup-strg (opes)
  (let (erg)
    (dolist (ele opes)
      (setq erg (concat (format "%s" (char-to-string ele)) erg)))
    erg))

(defvar-local operator-known-operators-spaced-maybe-strg (operator-setup-strg operator-known-operators-spaced-maybe)
  "Used to skip over operators at point.")

;; (setq operator-known-operators-spaced-maybe-strg (operator-setup-strg operator-known-operators-spaced-maybe))

(defun operator--beginning-of-op ()
  "Jump to the beginning of an operator at point.

Return position."
  (save-excursion
    ;; at least on operator
    (forward-char -1)
    (skip-chars-backward operator-known-operators-spaced-maybe-strg)
    (cons (point) (char-before))))
;; (when (char-equal 32 (char-before)) (delete-char -1)))

(defun py-in-dict-p (pps)
  "Return t if inside a dictionary."
  (save-excursion
    (and (nth 1 pps)
	 (goto-char (nth 1 pps))
	 (char-equal ?{ (char-after)))))

(defun operator--continue-p ()
  "Uses-cases:
"
  (when (member (char-before (- (point) 1)) operator-known-operators-spaced-maybe)
    'operator-continue))

(defun operator--in-list-continue-p (in-list list_start_c following_start_c)
  "Use-cases:
Haskell: (>=>) :: Monad"
  (and in-list (char-equal list_start_c ?\()
       (member following_start_c operator-known-operators-spaced-maybe)))

(defun operator--do-python-mode (char start charbef pps &optional notfirst notsecond unary)
  (setq operator-known-operators-spaced-maybe (remove ?. operator-known-operators-spaced-maybe))
  (let* ((in-list-p (nth 1 pps))
	 (index-p (when in-list-p (save-excursion (goto-char (nth 1 pps)) (and (eq (char-after) ?\[) (not (eq (char-before) 32))))))
	 (notfirst (or notfirst
		       ;; echo(**kargs)
		       (and (char-equal ?* char) in-list-p)
		       ;; print('%(language)s has %(number)03d quote types.' %
		       ;;     {'language': "Python", "number": 2})
		       ;; don't space ‘%’
		       (and (nth 1 pps) (nth 3 pps))
		       ;; with open('/path/to/some/file') as file_1,
		       (member char (list ?\; ?,))
		       ;; def f(x, y):
		       (and (char-equal char ?:) (char-equal (char-before (- (point) 1)) ?\)))
		       index-p
		       (py-in-dict-p pps)
		       (looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position))
		       ;; for i in c :
		       (looking-back "\\_<for\\_>+ +\\_<[^ ]+\\_> +in +\\_<[^ ]+:" (line-beginning-position))
		       (looking-back "\\_<as\\_>+ +\\_<[^ ]+:" (line-beginning-position))
		       (looking-back "return +[^ ]+" (line-beginning-position))))
	 ;; py-dict-re "'\\_<\\w+\\_>':")
	 ;; (looking-back "[<{]\\_<\\w+\\_>:")
	 (notsecond (or notsecond
			;; echo(**kargs)
			(and (char-equal ?* char) in-list-p)
			;; print('%(language)s has %(number)03d quote types.' %
			;;     {'language': "Python", "number": 2})
			;; don't space ‘%’
			(and (nth 1 pps) (nth 3 pps))
			(char-equal char ?~)
			(and (char-equal char ?:) (char-equal (char-before (- (point) 1)) ?\)))
			index-p
			;; Function type annotations
			(looking-back "[ \t]*\\_<\\(async def\\|class\\|def\\)\\_>[ \n\t]+\\([[:alnum:]_]+ *(.*)-\\)" (line-beginning-position) )
			(and
			  ;; return self.first_name, self.last_name
			  (not (char-equal char ?,))
			  (looking-back "return +[^ ]+.*" (line-beginning-position)))))
	 (unary (or unary
		    ;;  bitwise complement operator
		    (char-equal char ?~))))
    (operator--do char start notfirst notsecond unary)))

(defun operator--do-haskell-mode (char start charbef pps &optional notfirst notsecond)
  (let* ((in-list-p (nth 1 pps))
	 list_start_char
	 following_start_char
	 (index-p
	  (when in-list-p
	    (save-excursion
	      (goto-char (nth 1 pps))
	      (and
	       (setq list_start_char (char-after))
	       (setq following_start_char (char-after (1+ (point))))
	       (eq (char-after) ?\[)
	       ;; evens n = map f [1
	       ;; (not (eq (char-before) 32))
	       ))))
	 (notfirst (or notfirst
		       ;; (september <|> oktober)
		       (operator--continue-p)
		       ;; "(>=>) :: Monad
		       (operator--in-list-continue-p in-list-p list_start_char following_start_char)
		       (and (char-equal ?* char) in-list-p)
		       (and (nth 1 pps) (nth 3 pps))
		       (member char (list ?\; ?,))
		       (and (char-equal char ?:) (char-equal (char-before (- (point) 1)) ?\)))
		       index-p
		       (py-in-dict-p pps)
		       (looking-back "lambda +\\_<[^ ]+\\_>:" (line-beginning-position))
		       (looking-back "return +[^ ]+" (line-beginning-position))
		       (looking-back "forall +[^ ]+.*" (line-beginning-position))))
	 (notsecond (or notsecond
			;; "pure ($ y) <*> u"
			(and in-list-p (char-equal char ?,)
			     ;; operator spaced before?
			     (not (char-equal 32 charbef))
			     )
			;; "(>=>) :: Monad
			(and (operator--in-list-continue-p in-list-p list_start_char following_start_char) 
			     ;; "(september <|> oktober)"
			     (not (char-equal ?$ char)))
			(and (char-equal ?* char) in-list-p)
			(and (nth 1 pps) (nth 3 pps))
			(char-equal char ?~)
			(and (char-equal char ?:) (char-equal (char-before (- (point) 1)) ?\)))
			index-p
			(and
			 ;; "even <$> (2,2)"
			 (not (char-equal char ?,))
			 (looking-back "^return +[^ ]+.*" (line-beginning-position))))))
    (operator--do char start notfirst notsecond)))

(defun operator--do (char start &optional notfirst notsecond unary)
  (when (member char operator-known-operators-spaced-maybe)
    (let ((orig (copy-marker (point))))
      (unless unary (goto-char start))
      (unless notfirst (just-one-space))
      (goto-char orig)
      (unless notsecond (just-one-space)))))

(defun operator--do-intern (char)
  (let* ((pps (parse-partial-sexp (point-min) (point)))
	 (notfirst (and (nth 1 pps) (char-equal char ?,)))
	 ;; cons postition and char before operator
	 (first (operator--beginning-of-op))
	 (start (car first))
	 (charbef (cdr first))
	 notsecond)
    (pcase major-mode
      (`python-mode
       (operator--do-python-mode char start charbef pps notfirst notsecond))
      (`py-python-shell-mode
       (operator--do-python-mode char start charbef pps notfirst notsecond))
      (`py-ipython-shell-mode
       (operator--do-python-mode char start charbef pps notfirst notsecond))
      ;; (`emacs-lisp-mode
      ;;  (operator--do-emacs-lisp-mode char start charbef pps notfirst notsecond))
      (`haskell-mode
       (operator--do-haskell-mode char start charbef pps notfirst notsecond))
      (`haskell-interactive-mode
       (operator--do-haskell-mode char start charbef pps notfirst notsecond))
      (`inferior-haskell-mode
       (operator--do-haskell-mode char start charbef pps notfirst notsecond))
      (_ (operator--do char start notfirst notsecond)))))

(defun operator-do ()
  ""
  (interactive "*")
  (when (member (char-before) operator-known-operators-spaced-maybe)
    (operator--do-intern (char-before))))

(define-minor-mode operator-mode
  "Toggle automatic insertion of spaces around operators if appropriate.

With a prefix argument ARG, enable Electric Spacing mode if ARG is
positive, and disable it otherwise. If called from Lisp, enable
the mode if ARG is omitted or nil.

This is a local minor mode.  When enabled, typing an operator automatically
inserts surrounding spaces, e.g., `=' might become ` = ',`+=' becomes ` += '."
  :global nil
  :group 'electricity
  :lighter " _∧_ "

  ;; body
  (if operator-mode
      (progn ;; (operator-setup)
	     (add-hook 'post-self-insert-hook
                       ;; #'operator-post-self-insert-function nil t)
		       #'operator-do nil t))
    (remove-hook 'post-self-insert-hook
		 ;; #'operator-post-self-insert-function t)))
		 #'operator-do t)))

(provide 'operator-mode)
;;; operator-mode.el ends here
