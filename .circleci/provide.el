;; lifted from https://github.com/abrochard/kubel

(require 'package)

(defconst provide-packages
  '(transient dash yaml-mode s haskell-mode))

(defun provide-init ()
  (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
  (package-initialize))

(defun provide-install-packages ()
  (provide-init)
  (package-refresh-contents)
  (package-install 'package-lint)
  (dolist (pkg provide-packages)
    (package-install pkg)))

(defun provide-ert ()
  (provide-init)
  (load "/operator-mode/operator-mode.el")
  (load "/operator-mode/test/operator-mode-test.el")
  (load "/operator-mode/test/operator-python-mode-test.el")
  
  (ert-run-tests-batch-and-exit))

(defun provide-compile ()
  (provide-init)
  (setq byte-compile-error-on-warn nil)
  (batch-byte-compile))

(defun provide-lint ()
  (provide-init)
  (require 'package-lint)
  (setq package-lint-batch-fail-on-warnings t)
  (package-lint-batch-and-exit))

(provide 'provide)
;;; provide.el ends here
