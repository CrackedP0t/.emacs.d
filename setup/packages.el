(use-package auto-package-update)

(use-package paradox
  :config
  (paradox-enable)
  (setq paradox-github-token "4779d9292f73bde080ce659d4c7b2db91d555bd2"))

(use-package dash)

(use-package ido
  :config
  (setq ido-create-new-buffer 'always)
  (ido-mode 1)
  (ido-everywhere 1))

(use-package ido-ubiquitous
  :config
  (ido-ubiquitous-mode 1))

(use-package smex
  :demand
  :config
  (smex-initialize)
  :bind (("M-x" . smex)
		 ("<menu>" . smex)
		 ("M-X" . smex-major-mode-commands)))

(use-package crm-custom
  :config
  (crm-custom-mode 1))

(use-package magit
  :config
  (setq magit-completing-read-function 'magit-ido-completing-read))

(use-package powerline
  :config
  (powerline-default-theme))

(use-package moe-theme
  :no-require t
  :demand
  :config
  (moe-dark))

(use-package org
  :pin org)

(use-package rainbow-delimiters
  :init
  (add-hook 'emacs-lisp-mode-hook 'rainbow-delimiters-mode))

(use-package company
  :config
  (add-hook 'prog-mode-hook 'company-mode))

(use-package company-lua
  :config
  (add-to-list 'company-backends 'company-lua))


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

(use-package desktop+
  :config)

(use-package lua-mode
  :mode ("\\.lua\\'" . lua-mode)
  :interpreter ("lua" . lua-mode))

(use-package gitignore-mode
  :mode ("\\.gitignore"))

(use-package markdown-mode
  :mode ("\\.md"))
