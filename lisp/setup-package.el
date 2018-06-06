;; Thanks for Batsov!
;; I learned all of this from Prelude's source code:
;; https://github.com/bbatsov/prelude/blob/master/core/prelude-packages.el

(require 'package)
(require 'cl)

(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(defvar my-packages
  '(ac-js2 ace-jump-mode auto-complete
           company cider color-theme-sanityinc-tomorrow
           dash
           epc exec-path-from-shell expand-region
           flycheck
           gitconfig-mode gitignore-mode
           helm
	   ido-completing-read+
           jedi js2-mode
           key-chord key-combo
           lua-mode
           magit markdown-mode markdown-mode+  multiple-cursors
           org
           paredit paredit-menu powerline
           rainbow-mode rainbow-delimiters
           skewer-mode smex
           undo-tree
           wgrep wrap-region
           yasnippet
           zenburn-theme zencoding-mode))

(defun my-packages-installed-p ()
  (every #'package-installed-p my-packages))

(unless (my-packages-installed-p)
  (package-refresh-contents)
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))

(provide 'setup-package)
