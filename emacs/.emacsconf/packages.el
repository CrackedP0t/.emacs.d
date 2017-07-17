(require 'use-package)
(use-package spu
  :init (defvar spu-log-path "/dev/null/")
  :config (progn (spu-package-upgrade-daily)))

(use-package s)

(use-package dash)

(use-package all-the-icons
  :defer t)

(use-package all-the-icons-dired
  :defer t
  :init (add-hook
         'dired-mode-hook
         'all-the-icons-dired-mode))

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
  :config (moe-dark))

(use-package browse-kill-ring
  :defer t)

(use-package nlinum
  :defer t
  :init (add-hook 'prog-mode-hook 'nlinum-mode))

(use-package hl-line
  :defer t
  :init (add-hook 'prog-mode-hook 'hl-line-mode))

(use-package paradox
  :commands package-list-packages
  :config (setq
           paradox-async-display-buffer-function nil
           paradox-automatically-star t
           paradox-column-width-package 32
           paradox-execute-asynchronously t
           paradox-homepage-button-string "page"
           paradox-spinner-type (quote random))
  :config (progn
            (paradox-enable)))

(use-package restart-emacs
  :defer t)

;; (use-package ido
;;   :config (setq ido-create-new-buffer 'always)
;;   :config (progn (ido-mode 1)
;;                  (ido-everywhere 1)))

;; (use-package ido-ubiquitous
;;   :config
;;   (ido-ubiquitous-mode 1))

;; (use-package smex
;;   :config (smex-initialize)
;;   :bind (("M-x" . smex)
;;          ("<menu>" . smex)
;;          ("M-X" . smex-major-mode-commands)))

;; (use-package flx-ido
;;   :config (setq ido-enable-flex-matching t
;;                 ido-use-faces nil)
;;   :config (flx-ido-mode t))

(use-package switch-window
  :bind ("C-x o" . switch-window))

(use-package flycheck
  :config (setq
           flycheck-completing-read-function 'ivy-completing-read
           flycheck-display-errors-delay 0
           flycheck-idle-change-delay 0
           flycheck-display-errors-function nil
           flycheck-display-errors-delay 0
           flycheck-idle-change-delay 0)
  :config (progn
            (global-flycheck-mode 1)))

(use-package powerline
  :config (progn
            (powerline-default-theme)))

(use-package macrostep
  :defer t)

(use-package lua-mode
  :mode ("\\.lua$" . lua-mode)
  :interpreter ("lua" . lua-mode))

(use-package rust-mode
  :mode ("\\.rs$" . rust-mode)
  :bind ("C-c <tab>" . rust-format-buffer)
  :config (setq
           rust-format-on-save t))

(use-package flycheck-rust
  :defer t
  :init (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))


(use-package projectile
  :demand t
  :init (progn (add-hook 'prog-mode-hook #'(lambda ()
                                             (when (projectile-project-p)
                                               (projectile-mode)))))
  :bind (("C-c C-f" . projectile-find-file))
  :config (setq projectile-mode-line
                '(:eval
                  (format " %s "
                          (projectile-project-name)))
                projectile-completion-system 'ivy))

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
  :diminish company-mode
  :bind (:map company-active-map
              ("C-n" . nil)
              ("C-p" . nil)
              ("M-n" . company-select-next)
              ("M-p" . company-select-previous)
              ("<up>" .  nil)
              ("<down>" . nil)
              ;;("<return>" . nil)
              )
  :bind (:map company-mode-map
              ("<tab>" . company-indent-or-complete-common))
  :init (add-hook 'prog-mode-hook 'company-mode)
  :config (setq
           company-frontends '(company-pseudo-tooltip-unless-just-one-frontend
                               company-preview-common-frontend)
           company-idle-delay 0.1
           company-minimum-prefix-length 3
           company-show-numbers t
           company-tooltip-limit 10
           company-backends '(company-capf
                              company-keywords
                              company-files)
           company-require-match nil
           company-continue-commands t
           company-begin-commands '(self-insert-command)))

(use-package company-quickhelp
  :disabled t
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

(defmacro add-backend (backend hook)
  "Add BACKEND to a local version of company-backends when HOOK is called."
  `(add-hook
    ,hook
    (lambda ()
      (add-to-list (make-local-variable 'company-backends)
                   ',backend))))

(defmacro use-backend (backend hook)
  "Pass BACKEND and HOOK to add-backend on use-package's :config."
  `(use-package ,backend
     :defer t
     :init
     (add-backend ,backend ,hook)))

(use-backend company-anaconda 'anaconda-mode-hook)
(add-backend company-elisp 'emacs-lisp-mode-hook)
(use-backend company-lua 'lua-mode-hook)
(use-backend company-web 'web-mode-hook)
(use-backend company-shell 'sh-mode-hook)

(use-package racer
  :init (progn
          (add-hook 'rust-mode-hook #'racer-mode)
          (add-hook 'racer-mode-hook #'eldoc-mode)))

(use-package irony
  :disabled t
  :init (progn
          (add-hook 'c++-mode-hook 'irony-mode)
          (add-hook 'c-mode-hook 'irony-mode)
          (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))
  :config (progn
            (use-backend company-irony 'irony-mode-hook)
            (use-package flycheck-irony
              :init (add-hook 'flycheck-mode-hook 'flycheck-irony-setup))))

(use-package golden-ratio
  :diminish golden-ratio-mode
  :config (setq frame-resize-pixelwise t
           golden-ratio-auto-scale t
           golden-ratio-exclude-buffer-names nil
           golden-ratio-exclude-modes '("message-buffer-mode"
                                        "debugger-mode"
                                        "help-mode"
                                        "custom-mode"
                                        "inferior-emacs-lisp-mode"))

  :config (golden-ratio-mode))

(use-package web-mode
  :mode ("\\.js[x]?$" "\\.html$" "\\.css")
  :config (setq
           web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'"))))

(use-package eldoc
  :diminish eldoc-mode
  :init (progn
          (add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
          (add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
          (add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)))

(use-package undo-tree
  :diminish undo-tree-mode
  :config (progn
            (global-undo-tree-mode 1))
  :config (setq
           undo-tree-visualizer-timestamps t
           undo-tree-visualizer-diff t))

(use-package ibuffer
  :defer t
  :bind (("C-x C-b" . ibuffer)))

(use-package gitignore-mode
  :defer t)

(use-package markdown-mode
  :defer t)

(use-package which-key
  :diminish which-key-mode
  :config (setq
           which-key-idle-delay 0.5)
  :config (progn
            (which-key-mode 1)))

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
  :bind (("C-c r" . vr/replace)
         ("C-c R" . vr/query-replace))
  :config (progn
            (defun adv-vr/replace-buffer (oldfun &rest arguments))

            (advice-add #'vr/replace :around (lambda ()
                                               (save-excursion
                                                 (goto-char (point-min))
                                                 (apply oldfun arguments))))))

(use-package multiple-cursors
  :defer t
  :bind (("<C-down-mouse-2>" . mc/add-cursor-on-click)
         ("<C-mouse-2>" . nil)))

(use-package persp-mode
  :disabled t
  :config (setq
           persp-interactive-completion-system 'ivy-completing-read)
  :config (progn
            (persp-mode 1)))

(use-package persp-mode-projectile-bridge
  :disabled t
  :config (progn
            (add-hook
             'after-init-hook
             'persp-mode-projectile-bridge-mode)
            (add-hook
             'persp-mode-projectile-bridge-mode-hook
             (lambda ()
               (if persp-mode-projectile-bridge-mode
                   (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
                 (persp-mode-projectile-bridge-kill-perspectives))))))

(use-package hydra
  :config (setq
           hydra-verbose t))

(use-package counsel
  :demand t
  :bind (:map ivy-minibuffer-map
              ("<tab>" . ivy-partial)
              ("<return>" . ivy-alt-done)
              ("C-j" . ivy-immediate-done))
  :bind (("C-s" . swiper)
         ("M-x" . counsel-M-x)
         ("<menu>" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         ("C-h f" . counsel-describe-function)
         ("C-h v" . counsel-describe-variable))
  :config (setq
           ivy-use-virtual-buffers t
           ivy-count-format "(%d/%d) "
           ivy-re-builders-alist '((t . ivy--regex))
           ivy-sort-functions-alist '((t . string-lessp)))
  :config (progn
            (ivy-mode 1)))

(use-package avy
  :bind ("C-." . avy-goto-char)
  :config (setq
           avy-all-windows nil
           avy-all-windows-alt t))

(use-package ace-link
  :config (progn
            (ace-link-setup-default)))

(use-package ace-window
  :bind (("C-x o" . ace-window)))

(use-package flx
  :defer t)

(use-package lispy
  :disabled t
  :defer t
  :config (progn
            (add-hook 'emacs-lisp-mode-hook
                      'lispy-mode)))

(use-package smex
  :defer t
  :config (progn
            (smex-initialize)))

(use-package magit
  :defer t
  :config (setq
           magit-completing-read-function 'ivy-completing-read))

(use-package smart-tabs-mode
  :config (progn
            (smart-tabs-insinuate 'c 'c++ 'java 'javascript
                                  'cperl 'python 'ruby 'nxml)))

(use-package dumb-jump
  :defer t)

(use-package dired-single
  :defer t
  :bind (:map dired-mode-map
              ("<return>" . dired-single-buffer)
              ("<mouse-1>" . dired-single-buffer-mouse))
  (bind-key "^"
            #'(lambda nil
                (interactive)
                (dired-single-buffer ".."))
            dired-mode-map))

(use-package whitespace
  :defer t
  :init (add-hook 'before-save-hook 'whitespace-cleanup)
  :init (add-hook 'prog-mode-hook 'whitespace-mode)
  :config (setq
           whitespace-line-column 80
           whitespace-style '(face trailing tabs lines-tail
                                   empty indentation::space)))

(use-package compile
  :config (progn
            (defun compile-shell-adv (old-compile command &optional comint)
              (funcall old-compile command t))
            (advice-add 'compile :around #'compile-shell-adv)))

(use-package kotlin-mode
  :mode ("\\.kt$" . kotlin-mode))
