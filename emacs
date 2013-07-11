; Add my package directory to the load list
(add-to-list 'load-path "~/.emacs.d/packages")

; Detect which OS Emacs is running on
(defvar mswindows-p (string-match "windows-nt" (symbol-name system-type)))
(defvar macosx-p (string-match "darwin" (symbol-name system-type)))

;; ***** Custom Packages *****
; Common Lisp (required for JS2)
(require 'cl)

(require 'maxframe)

;; ***** Additional Modules *****

;; ***** Settings *****
; Stop emacs from arbitrarily adding lines to the end of a file when
; the cursor is moved past the end of it
(setq next-line-add-newlines nil)

; Always scroll compile output
(setq compilation-scroll-output t)

; Don't create backup files
(setq make-backup-files nil)

; Set tab width to 4
(setq default-tab-width 4)
(setq-default c-basic-offset 4)

;; ***** UI Customizations *****
; Minimalist UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

; Maximize on startup
(add-hook 'window-setup-hook 'maximize-frame t)

; Format the title bar to be the buffer name
(setq frame-title-format "%b")

; Always show the column number
(column-number-mode 1)

; Highlight matching parenthesis
(show-paren-mode t)

; Transient mark mode (highlight current selection)
(setq transient-mark-mode t)

; Use y or n for a "yes or no" response
(fset 'yes-or-no-p 'y-or-n-p)

; Turn off the beep in most common occurrances
(setq ring-bell-function
      (lambda ()
	(unless (memq this-command
		      '(isearch-abort abort-recursive-edit exit-minibuffer keyboard-quit))
	  (ding))))
	  
; Set Font
(if mswindows-p
	(set-face-attribute 'default nil :font "Consolas-10")
	(if macosx-p
		(set-face-attribute 'default nil :font "Monaco-12")))

; Use Meta+<arrow key> to switch between windows
(windmove-default-keybindings 'meta)

;; ***** Keybindings *****
(global-set-key "\C-x\C-g" 'goto-line) ; can also use M-g M-g
(global-set-key "\M-1" 'shell-command)
; use C-x C-m (or C-c C-m) for Meta-x
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
; i-search w/ regexp
(global-set-key "\M-r" 'isearch-forward-regexp)
(global-set-key "\M-s" 'isearch-backward-regexp)
; playback last keyboard macro
(global-set-key [f5] 'call-last-kbd-macro)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

;; ***** Custom Modes *****
; JS2 mode
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

; JS2 Highlight Variables
(require 'js2-highlight-vars)
(defun my-js2-mode-hook ()
	(if (featurep 'js2-highlight-vars)
		(js2-highlight-vars-mode)))
(add-hook 'js2-mode-hook 'my-js2-mode-hook)

; nXML mode
; should change this to autoload - what are its parameters?
(load "nxml-mode/rng-auto.el")
(add-to-list 'auto-mode-alist '("\\.xml" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.xsl" . nxml-mode))
(add-to-list 'auto-mode-alist '("\\.plist" . nxml-mode))

; Org-mode
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; ***** Functions *****
(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(defun show-file-name ()
  "Show the full path file name in the minibuffer."
  (interactive)
  (message (buffer-file-name))
  (kill-new (file-truename buffer-file-name))
)

;; ***** Custom Options *****
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(cua-mode nil nil (cua-base))
 '(global-font-lock-mode t nil (font-core))
 '(inhibit-default-init t)
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(js2-cleanup-whitespace t)
 '(js2-enter-indents-newline t)
 '(js2-include-gears-externs nil)
 '(js2-include-rhino-externs nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(font-lock-builtin-face ((nil (:background "light" :foreground "Blue1"))))
 '(font-lock-comment-face ((nil (:background "light" :foreground "#008000"))))
 '(font-lock-function-name-face ((nil (:background "light" nil))))
 '(font-lock-keyword-face ((nil (:background "light" :foreground "Blue1"))))
 '(font-lock-string-face ((nil (:background "light" :foreground "Red1"))))
 '(font-lock-type-face ((nil (:background "light" :foreground "#2B91AF"))))
 '(font-lock-variable-name-face ((nil (:background "light" nil)))))

