(use-package spu
  :init (defvar spu-log-path "/dev/null")
  :config
  (spu-package-upgrade-daily))

(use-package rainbow-mode
  :diminish rainbow-mode
  :config (rainbow-mode 1))

(use-package dash)

(use-package all-the-icons)

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
  :config (moe-dark))

(use-package browse-kill-ring
  :defer t)

(use-package nlinum
  :defer t
  :init
  (add-hook 'prog-mode-hook 'nlinum-mode))

(use-package hl-line
  :defer t
  :init
  (add-hook 'prog-mode-hook 'hl-line-mode))

(use-package paradox
  :defer t
  :config
  (paradox-enable)
  (setq paradox-github-token "02321f0cc89a90e4154e6d463632497aeb0767ea"))

(use-package restart-emacs)

(use-package ido
  :config
  (setq ido-create-new-buffer 'always)
  (ido-mode 1)
  (ido-everywhere 1))

(use-package ido-ubiquitous
  :config
  (ido-ubiquitous-mode 1))

(use-package smex
  :config (smex-initialize)
  :bind (("M-x" . smex)
		 ("<menu>" . smex)
		 ("M-X" . smex-major-mode-commands)))

(use-package flx-ido
  :config
  (flx-ido-mode t)
  (setq ido-enable-flex-matching t)
  (setq ido-use-faces nil))

(use-package switch-window
  :bind ("C-x o" . switch-window))

(use-package flycheck
  :init (global-flycheck-mode)
  :config (setq flycheck-completing-read-function (quote ido-completing-read)
				flycheck-display-errors-delay 0
				flycheck-idle-change-delay 0
				flycheck-display-errors-function nil))

(use-package magit
  :config (setq magit-completing-read-function 'magit-ido-completing-read))

(use-package powerline
  :config (powerline-default-theme))

(use-package macrostep)

(use-package projectile
  :demand t
  :bind ("C-c C-f" . projectile-find-file)
  :config (projectile-global-mode))

(use-package lua-mode
  :mode ("\\.lua$" . lua-mode)
  :interpreter ("lua" . lua-mode))

(use-package org)

(use-package anaconda-mode
  :init
  (add-hook 'python-mode-hook 'anaconda-mode)
  (add-hook 'anaconda-mode-hook 'anaconda-eldoc-mode))

(use-package rainbow-delimiters
  :init
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

(use-package irony
  :disabled t
  :defer t
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  :config
  (add-hook
   'irony-mode-hook
   (lambda ()
	 (define-key irony-mode-map [remap completion-at-point]
	   'irony-completion-at-point-async)
	 (define-key irony-mode-map [remap complete-symbol]
	   'irony-completion-at-point-async)))
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))

(use-package company
  :diminish company-mode
  :defer t
  :init (add-hook 'prog-mode-hook 'company-mode)
  :config
  (company-quickhelp-mode 1)
  (company-statistics-mode 1)
  (setq company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
							company-preview-common-frontend)
		company-idle-delay 0.1
		company-minimum-prefix-length 3
		company-show-numbers t
		company-tooltip-limit 10
		company-backends '(company-capf
						   company-keywords))
  :bind ("<tab>" . company-indent-or-complete-common))

(use-package company-quickhelp
  :defer t)

(use-package company-statistics
  :defer t)

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

(use-package golden-ratio
  :diminish golden-ratio-mode
  :config
  (golden-ratio-mode 1))

(use-package web-mode)

(use-package eldoc
  :diminish eldoc-mode
  :init
  (progn
	(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
	(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
	(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)))

(use-package undo-tree
  :diminish undo-tree-mode
  :config
  (progn
	(global-undo-tree-mode)
	(setq undo-tree-visualizer-timestamps t)
	(setq undo-tree-visualizer-diff t)))

(use-package ibuffer
  :bind
  ("C-x C-b" . ibuffer))

(use-package gitignore-mode)

(use-package markdown-mode)

(use-package which-key
  :diminish which-key-mode
  :config
  (which-key-mode 1))

(use-package autorevert
  :disabled
  :diminish auto-revert-mode)

(use-package system-packages
  :defer t)

(use-package perspective
  :config (persp-mode))

(use-package ripgrep)

(use-package projectile-ripgrep)

(use-package persp-projectile)

(use-package try)

(use-package mu4e
  :ensure nil
  :load-path "/usr/share/emacs/site-lisp/mu4e"
  :config
  (setq mu4e-contexts
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

;; sending mail -- replace USERNAME with your gmail username
;; also, make sure the gnutls command line utils are installed
;; package 'gnutls-bin' in Debian/Ubuntu

(use-package smtpmail
  :defer t
  :ensure nil
  ;; alternatively, for emacs-24 you can use:
  :config
  (setq message-send-mail-function 'smtpmail-send-it
		smtpmail-stream-type 'starttls
		smtpmail-default-smtp-server "smtp.gmail.com"
		smtpmail-smtp-server "smtp.gmail.com"
		smtpmail-smtp-service 587)

  ;; don't keep message buffers around
  (setq message-kill-buffer-on-exit t))

(defun draw-mc-vertical (event-type pos-1 pos-2)
  "Depending on EVENT-TYPE, draws a vertical line of cursors starting at POS-1 and ending at POS-1's column but POS-2's row."


  )

(use-package multiple-cursors
  :bind (("<mouse-2>" . mc/add-cursor-on-click)
		 ("<drag-mouse-2>" . draw-mc-vertical)))


(use-package virtualenvwrapper)
