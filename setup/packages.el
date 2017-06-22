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


(use-package irony
  :init (progn (add-hook 'c++-mode-hook 'irony-mode)
			   (add-hook 'c-mode-hook 'irony-mode)
			   (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)))

(use-package flycheck
  :config (setq flycheck-completing-read-function 'ivy-completing-read
				flycheck-display-errors-delay 0
				flycheck-idle-change-delay 0
				flycheck-display-errors-function nil
				flycheck-display-errors-delay 0
				flycheck-idle-change-delay 0)
  :config (progn (global-flycheck-mode 1)))

(use-package flycheck-irony
  :init (add-hook 'flycheck-mode-hook 'flycheck-irony-setup))

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
						  (projectile-project-name)))
				projectile-completion-system 'ivy)
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

(use-package company
  :bind (:map company-active-map
			  ("C-n" . company-select-next)
			  ("C-p" . company-select-previous)
			  ("M-n" . nil)
			  ("M-p" . nil))
  :bind (:map company-mode-map
			  ("<tab>" . company-indent-or-complete-common))
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
	 :init
	 (add-backend ',backend ,hook)))

(use-backend company-anaconda 'anaconda-mode-hook)
(add-backend 'company-elisp 'emacs-lisp-mode-hook)
(use-backend company-lua 'lua-mode-hook)
(use-backend company-web 'web-mode-hook)
(use-backend company-irony 'irony-mode-hook)

(setq conf/golden-ratio-main (current-buffer))
(defun conf/golden-ratio-main-inhibit ()

  )

(use-package golden-ratio
  :diminish golden-ratio-mode
  :config (setq frame-resize-pixelwise t
				golden-ratio-auto-scale t
				golden-ratio-exclude-buffer-names nil
				golden-ratio-exclude-modes
				(quote
				 ("message-buffer-mode" "debugger-mode" "help-mode" "custom-mode")))

  :config (progn (add-hook 'prog-mode-hook (lambda ()
											 (when (projectile-project-p)
											   (projectile-mode))))

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
  :config (setq which-key-idle-delay 0.5)
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

(use-package visual-regexp
  :defer t
  :bind (("C-c r" . vr/replace)
		 ("C-c R" . vr/query-replace)))

(use-package multiple-cursors
  :defer t
  :bind (("<mouse-2>" . mc/add-cursor-on-click)))

(use-package persp-mode
  :disabled t
  :config (setq persp-interactive-completion-system 'ivy-completing-read)
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
  :bind (:map ivy-minibuffer-map ("<tab>" . ivy-partial)
			  ("<return>" . ivy-alt-done)
			  ("C-j" . ivy-immediate-done))
  :bind (("C-s" . swiper)
		 ("M-x" . counsel-M-x)
		 ("<menu>" . counsel-M-x)
		 ("C-x C-f" . counsel-find-file)
		 ("C-h f" . counsel-describe-function)
		 ("C-h v" . counsel-describe-variable))
  :config (setq ivy-use-virtual-buffers t
				ivy-count-format "(%d/%d) "
				ivy-re-builders-alist '((t . ivy--regex))
				ivy-sort-functions-alist '((t . string-lessp)))
  :config (progn (ivy-mode 1)))

(use-package avy
  :bind ("C-c a" . avy-goto-char)
  :config (setq avy-all-windows nil
				avy-all-windows-alt t))

(use-package ace-link
  :config (progn (ace-link-setup-default)))

(use-package ace-window
  :bind ("C-x o" . ace-window))

(use-package flx
  :defer t)

(use-package lispy
  :disabled t
  :defer t
  :config (progn (add-hook 'emacs-lisp-mode-hook 'lispy-mode)))

(use-package smex
  :defer t
  :config (progn (smex-initialize)))


(use-package magit
  :defer t
  :config (setq magit-completing-read-function 'ivy-completing-read))

(use-package smart-tabs-mode
  :config (progn (smart-tabs-insinuate 'c)))

(use-package dumb-jump
  :defer t)
