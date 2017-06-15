(use-package spu
  :init (defvar spu-log-path "/dev/null")
  :config (progn (spu-package-upgrade-daily)))

(use-package rainbow-mode
  :diminish rainbow-mode
  :config (progn (rainbow-mode 1)))

(use-package dash)

(use-package all-the-icons
  :defer t)

(use-package all-the-icons-dired
  :defer t
  :init (add-hook 'dired-mode-hook 'all-the-icons-dired-mode))

(use-package clues-theme
  :defer t)

(use-package color-theme-sanityinc-tomorrow
  :defer t)

(use-package distinguished-theme
  :defer t)

(use-package dracula-theme
  :defer t)

(use-package gotham-theme
  :defer t)

(use-package grandshell-theme
  :defer t)

(use-package moe-theme
  :no-require t
  :defer t
  :config (progn (moe-dark)))

(use-package browse-kill-ring
  :defer t)

(use-package nlinum
  :defer t
  :init (add-hook 'prog-mode-hook 'nlinum-mode))

(use-package hl-line
  :defer t
  :init (add-hook 'prog-mode-hook 'hl-line-mode))

(use-package paradox
  :init (add-hook 'package-menu-mode-hook 'paradox-enable)
  :commands package-list-packages
  :config (setq paradox-github-token "02321f0cc89a90e4154e6d463632497aeb0767ea"
				paradox-async-display-buffer-function nil
				paradox-automatically-star t
				paradox-column-width-package 32
				paradox-execute-asynchronously t
				paradox-homepage-button-string "page"
				paradox-spinner-type (quote random)))

(use-package restart-emacs
  :defer t)

;; (use-package ido
;;   :config (setq ido-create-new-buffer 'always)
;;   :config (progn (ido-mode 1)
;;				 (ido-everywhere 1)))

;; (use-package ido-ubiquitous
;;   :config
;;   (ido-ubiquitous-mode 1))

;; (use-package smex
;;   :config (smex-initialize)
;;   :bind (("M-x" . smex)
;;		 ("<menu>" . smex)
;;		 ("M-X" . smex-major-mode-commands)))

;; (use-package flx-ido
;;   :config (setq ido-enable-flex-matching t
;;				ido-use-faces nil)
;;   :config (flx-ido-mode t))

;; (use-package switch-window
;;   :bind ("C-x o" . switch-window))

(use-package flycheck
  :config (setq ;; flycheck-completing-read-function (quote ido-completing-read)
				flycheck-display-errors-delay 0
				flycheck-idle-change-delay 0
				flycheck-display-errors-function nil
				flycheck-display-errors-delay 0
				flycheck-idle-change-delay 0)
  :config (progn (global-flycheck-mode 1)))

(use-package flycheck-irony
  :defer t
  :init (add-hook 'flycheck-mode-hook 'flycheck-irony-setup))

(use-package magit
  :defer t
  :config (setq ;;magit-completing-read-function 'magit-ido-completing-read
		   ))

(use-package powerline
  :config (progn (powerline-default-theme)))

(use-package macrostep
  :defer t)

(use-package projectile
  :demand t
  :bind ("C-c C-f" . projectile-find-file)
  :config (setq projectile-mode-line
				'(:eval
				  (format " %s "
						  (projectile-project-name))))
  :config (progn (projectile-global-mode)))

(use-package lua-mode
  :mode ("\\.lua$" . lua-mode)
  :interpreter ("lua" . lua-mode))

(use-package org)

(use-package anaconda-mode
  :defer t
  :init
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'anaconda-mode-hook 'anaconda-eldoc-mode))

(use-package rainbow-delimiters
  :defer t
  :init (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

(use-package bm
  :bind (("M-n" . bm-next)
		 ("M-p" . bm-prev)))

(use-package irony
  :defer t
  :init (progn (add-hook 'c++-mode-hook 'irony-mode)
			   (add-hook 'c-mode-hook 'irony-mode)
			   (add-hook 'objc-mode-hook 'irony-mode)
			   (add-hook 'irony-mode-hook (lambda ()
											(define-key irony-mode-map [remap completion-at-point]
											  'irony-completion-at-point-async)
											(define-key irony-mode-map [remap complete-symbol]
											  'irony-completion-at-point-async)))
			   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)))

(use-package company
  :diminish company-mode
  :defer t
  :init (add-hook 'prog-mode-hook 'company-mode)
  :config (setq company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
									company-preview-common-frontend)
				company-idle-delay 0.1
				company-minimum-prefix-length 3
				company-show-numbers t
				company-tooltip-limit 10
				company-backends '(company-capf
								   company-keywords)
				company-require-match nil))

(use-package company-quickhelp
  :defer t
  :init (add-hook 'company-mode-hook 'company-quickhelp-mode)
  :config (setq
		   company-quickhelp-color-background "thistle4"
		   company-quickhelp-color-foreground "dark gray"
		   company-quickhelp-delay 0
		   company-quickhelp-use-propertized-text t))

(use-package company-statistics
  :defer t
  :init (add-hook 'company-mode-hook 'company-statistics-mode))

(defun add-backend (backend hook)
  "Add BACKEND to a local version of company-backends when HOOK is called."
  (add-hook
   hook
   `(lambda ()
	  (add-to-list (make-local-variable 'company-backends)
				   ',backend))))

(defmacro use-backend (backend hook)
  "Pass BACKEND and HOOK to add-backend on use-package's :config."
  `(use-package ,backend
	 :defer t
	 :config
	 (add-backend ',backend ,hook)))

(use-backend company-anaconda 'anaconda-mode-hook)
(add-backend 'company-elisp 'emacs-lisp-mode-hook)
(use-backend company-lua 'lua-mode-hook)
(use-backend company-web 'web-mode-hook)
(use-backend company-irony 'irony-mode-hook)

(use-package golden-ratio
  :diminish golden-ratio-mode
  :config (setq frame-resize-pixelwise t
				golden-ratio-auto-scale t
				golden-ratio-exclude-buffer-names nil
				golden-ratio-exclude-modes
				  (quote
				   ("message-buffer-mode" "debugger-mode" "help-mode" "custom-mode")))
  :config (progn (golden-ratio-mode 1)))

(use-package web-mode
  :defer t)

(use-package eldoc
  :diminish eldoc-mode
  :init (progn (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
			   (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
			   (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)))

(use-package undo-tree
  :diminish undo-tree-mode
  :config (progn (global-undo-tree-mode 1))
  :config (setq undo-tree-visualizer-timestamps t
				undo-tree-visualizer-diff t))

(use-package ibuffer
  :defer t
  :bind ("C-x C-b" . ibuffer))

(use-package gitignore-mode
  :defer t)

(use-package markdown-mode
  :defer t)

(use-package which-key
  :diminish which-key-mode
  :config (progn (which-key-mode 1)))

(use-package autorevert
  :disabled
  :diminish auto-revert-mode)

(use-package system-packages
  :defer t)

(use-package ripgrep)

(use-package projectile-ripgrep)

(use-package try
  :defer t)

(use-package mu4e
  :defer t
  :ensure nil
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :config (setq mu4e-contexts
				`(,(make-mu4e-context
					:name "EMGmail"
					:match-func (lambda (msg) (when msg
												(string-prefix-p "/EMGmail" (mu4e-message-field msg :maildir))))
					:vars '((mu4e-trash-folder . "/EMGmail/[Gmail].Trash")
							(mu4e-refile-folder . "/EMGmail/[Gmail].Archive")

							(mu4e-drafts-folder . "/[Gmail].Drafts")
							(mu4e-sent-folder .  "/[Gmail].Sent Mail")
							(mu4e-trash-folder . "/[Gmail].Trash")

							;; don't save message to Sent Messages, Gmail/IMAP takes care of this
							(mu4e-sent-messages-behavior . 'delete)

							;; (See the documentation for `mu4e-sent-messages-behavior' if you have
							;; additional non-Gmail addresses and want assign them different
							;; behavior.)

							;; setup some handy shortcuts
							;; you can quickly switch to your Inbox -- press ``ji''
							;; then, when you want archive some messages, move them to
							;; the 'All Mail' folder by pressing ``ma''.

							(mu4e-maildir-shortcuts . '( ("/INBOX"               . ?i)
														 ("/[Gmail].Sent Mail"   . ?s)
														 ("/[Gmail].Trash"       . ?t)
														 ("/[Gmail].All Mail"    . ?a)))

							;; allow for updating mail using 'U' in the main view:
							(mu4e-get-mail-command . "offlineimap")

							;; something about ourselves
							(user-mail-address . "elainamartineau@gmail.com")
							(user-full-name . "Elaina Martineau"))))))

(use-package visual-regexp
  :defer t)

(use-package multiple-cursors
  :defer t
  :bind (("<mouse-2>" . mc/add-cursor-on-click)))

(use-package persp-mode
  :config (progn (persp-mode 1)))

(use-package persp-mode-projectile-bridge
  :disabled t
  :config (progn (add-hook 'after-init-hook 'persp-mode-projectile-bridge-mode)
				 (add-hook 'persp-mode-projectile-bridge-mode-hook
						   (lambda ()
							 (if persp-mode-projectile-bridge-mode
								 (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
							   (persp-mode-projectile-bridge-kill-perspectives))))))

(use-package hydra
  :config (setq hydra-verbose t))

(use-package counsel
  :demand t
  :bind (("C-s" . swiper)
		 ("M-x" . counsel-M-x)
		 ("<menu>" . counsel-M-x)
		 ("C-x C-f" . counsel-find-file)
		 ("C-h f" . counsel-describe-function)
		 ("C-h v" . counsel-describe-variable)
		 ("<f2> i" . counsel-info-lookup-symbol)
		 ("<f2> u" . counsel-unicode-char))
  :config (setq ivy-use-virtual-buffers t
				ivy-count-format "(%d/%d) "
				ivy-re-builders-alist '((t . ivy--regex-fuzzy))
				ivy-sort-functions-alist '((t . string-lessp)))
  :config (progn (ivy-mode 1)))

(use-package avy
  :config (setq avy-all-windows nil
				avy-all-windows-alt t)
  :config (progn (avy-setup-default)))

(use-package ace-link
  :config (progn (ace-link-setup-default)))

(use-package ace-window
  :bind ("C-x o" . ace-window))

(use-package flx
  :defer t)

(use-package lispy
  :defer t
  :config (progn (add-hook 'emacs-lisp-mode-hook 'lispy-mode)))

(use-package smex
  :defer t
  :config (progn (smex-initialize)))
