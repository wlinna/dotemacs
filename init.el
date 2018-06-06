;; TODO: Separate different tasks to different files

;; (setenv "PATH" (concat "/home/william/software/tern/bin:" (getenv "PATH")))

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; (package-initialize)

(add-to-list 'load-path (concat user-emacs-directory "lisp"))

;; Read following link for tern installation instructions
;; http://ternjs.net/doc/manual.html#emacs
;; (add-to-list 'load-path "~/software/tern/emacs")
;; (autoload 'tern-mode "tern.el" nil t)

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

(require 'setup-package)

(exec-path-from-shell-copy-env "PATH")

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; Sane defaults

;;; Ido
(require 'ido)
(ido-mode 1)
(ido-everywhere 1)

(require 'ido-completing-read+)
(ido-ubiquitous-mode 1)


(require 'uniquify)
(toggle-uniquify-buffer-names 1)

;; Auto complete
(require 'auto-complete-config)
(ac-config-default)

;;;  UI-stuff
(tool-bar-mode 0)
(scroll-bar-mode 0)
(setq inhibit-startup-message t)

(load-theme 'sanityinc-tomorrow-eighties)

(require 'setup-powerline)

(require 'expand-region)

(require 'yasnippet)
(yas-global-mode 1)

(ido-ubiquitous-mode 1)

(column-number-mode 1)
(pending-delete-mode t)
(wrap-region-global-mode 1)
(electric-pair-mode 1)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

(require 'undo-tree)
(global-undo-tree-mode)

(require 'paren)
(show-paren-mode +1)

(require 'rainbow-delimiters)

(define-globalized-minor-mode global-rainbow-delimiters-mode rainbow-delimiters-mode
  rainbow-delimiters-mode)

(global-rainbow-delimiters-mode 1)

;; Basic keybindings

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "jj" 'ace-jump-mode)

(global-set-key (kbd "C-S-z") 'undo-tree-visualize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-=") 'er/expand-region)

(global-set-key (kbd "<home>") 'back-to-indentation)
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "<end>") 'end-of-line)
(global-set-key (kbd "C-e") 'end-of-line)
(global-set-key (kbd "RET") 'newline-and-indent)

(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z s") 'yas-insert-snippet)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-z i") 'helm-imenu)

(defun newline-and-go ()
  (interactive)
  (end-of-line)
  (newline-and-indent))

(global-set-key (kbd "C-j") 'newline-and-go)

(eval-after-load 'sgml-mode
  '(progn
     (define-key sgml-mode-map (kbd "C-c /") 'sgml-close-tag)
     (define-key sgml-mode-map (kbd "C-c m") 'mc/mark-sgml-tag-pair)
     (define-key html-mode-map (kbd "C-z e") 'zencoding-expand-yas)))

(eval-after-load 'nxml-mode
  '(progn
     (define-key nxml-mode-map (kbd "C-c m") 'mc/mark-sgml-tag-pair)))



;; Mode-settings

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; UTF-8

(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top

;; hooks

(defun lisp-config ()
  (paredit-mode +1)
  )

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (lisp-config)
            ))

(add-hook 'clojure-mode-hook
          (lambda ()
            (cider-mode 1)
            (paredit-mode 1)))

(add-hook 'cider-mode-hook
          (lambda ()
            (auto-complete-mode 0)
            (company-mode 1)
            (eldoc-mode 1)))

(add-hook 'cider-repl-mode-hook #'company-mode)

(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "RET") 'org-return)
            (local-set-key (kbd "C-c SPC") 'ace-jump-mode)
            (set-fill-column 79)
            (auto-fill-mode 1)

            ))

(add-hook 'html-mode-hook
          (lambda  ()
            (zencoding-mode 1)
            (set-fill-column 100)
            ))

(add-hook 'nxml-mode-hook
          (lambda ()
            (set-fill-column 100)
            ))

(add-hook 'js2-mode-hook
          (lambda ()
            (set-fill-column 100)
            (semantic-mode 1)
            (tern-mode t)
            ))

(add-hook 'python-mode-hook
          (lambda ()
            (set-fill-column 79)
            (jedi:setup)
            (jedi:ac-setup)
            (subword-mode +1)
            (electric-indent-mode -1)
            (setq tab-width 4)
            (setq python-indent 4)
            ;; (es-auto-auto-indent-mode 0)
            ))

;; Write backup files to own directory
(setq backup-directory-alist
      `(("." . ,(expand-file-name
                 (concat user-emacs-directory "backups")))))

(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Disable interlocking because it creates .#-symlink files
(setq create-lockfiles nil)

;; Make backups of files, even when they're in version control
(setq vc-make-backup-files t)

(put 'dired-find-alternate-file 'disabled nil)
