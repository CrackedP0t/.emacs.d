(require 'use-package) ;; Redundant, but needed for editing with Flycheck

(use-package s)

(use-package dash)

(use-package all-the-icons)

(use-package all-the-icons-dired
  :hook dired-mode all-the-icons-dired-mode)

(defmacro use-defer-multi (&rest packages)
  "Run use-package with the arguments in \
each element of PACKAGES and `:defer t`."
  `(progn ,@(--map (append
                    (list 'use-package)
                    it
                    (list :defer t))
                   packages)))

(use-defer-multi
 ;; (ample-theme)
 ;; (clues-theme)
 ;; (color-theme-sanityinc-tomorrow)
 ;; (distinguished-theme)
 ;; (dracula-theme)
 ;; (gotham-theme)
 ;; (grandshell-theme)
 ;; (moe-theme :config (moe-dark))
 (nord-theme)
 ;; (cyberpunk-theme)
 )
;; (load-theme 'gotham t)
(load-theme 'nord t)

(use-package browse-kill-ring
  :commands browse-kill-ring)

(use-package nlinum
  :hook ((prog-mode conf-mode) . nlinum-mode))

(use-package hl-line
  :init (add-hook 'prog-mode-hook 'hl-line-mode))

(use-package restart-emacs
  :commands restart-emacs)

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

;; (use-package switch-window
;;   :bind ("C-x o" . switch-window))

(use-package flycheck
  :config (setq flycheck-completing-read-function 'ivy-completing-read
                flycheck-mode-line nil
                flycheck-display-errors-delay 0
                flycheck-idle-change-delay 0
                flycheck-display-errors-function nil
                flycheck-display-errors-delay 0
                flycheck-idle-change-delay 0)
  ;; :config (progn (global-flycheck-mode 1))
  )

;; (use-package powerline
;;   :disabled t
;;   :config (progn
;;             (powerline-default-theme)))

;; (use-package telephone-line
;;   :disabled t
;;   :config (progn
;;             (telephone-line-mode 1)))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

(use-package macrostep
  :commands macrostep-expand)

(use-package lua-mode
  :mode ("\\.lua$" . lua-mode)
  :interpreter ("lua" . lua-mode)
  :custom (lua-indent-level 4))

(use-package projectile
  :demand t
  :init (add-hook 'prog-mode-hook #'(lambda ()
                                      (when (projectile-project-p)
                                        (projectile-mode))))
  :bind (("C-c C-f" . projectile-find-file))
  :config (setq projectile-mode-line
                '(:eval
                  (format " %s "
                          (projectile-project-name)))
                projectile-completion-system 'ivy))

(use-package org
  :bind (("C-c a" . org-agenda)
         ("C-c c" . org-capture))
  :config
  (setq org-startup-folded 'showeverything
        org-agenda-files '("~/Documents/Agenda")
        org-blank-before-new-entry '((heading) (plain-list-item))
        org-indent-mode-turns-on-hiding-stars nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-startup-indented t
        org-startup-truncated nil
        org-capture-templates '(("r" "Random" entry (file "~/Documents/Agenda/random.org")
                                 "* TODO %?"))))

;; (use-package anaconda-mode
;;   :disabled t
;;   :defer t
;;   :init
;;   (add-hook 'python-mode-hook 'anaconda-mode)
;;   (add-hook 'anaconda-mode-hook 'anaconda-eldoc-mode))

(use-package rainbow-delimiters
  :custom-face (rainbow-delimiters-unmatched-face ((t (:foreground "#091f2e" :background "#c23127"))))
  :hook prog-mode-hook rainbow-delimiters-mode)

(use-package bm
  :bind ("<mouse-3>" . bm-toggle-mouse)
  ("C-c SPC" . bm-toggle)
  ("M-n" . bm-next)
  ("M-p" . bm-prev))

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

;; (use-package company-quickhelp
;;   :disabled t
;;   :defer t
;;   :init (add-hook 'company-mode-hook 'company-quickhelp-mode)
;;   :config (setq
;;            company-quickhelp-color-background "thistle4"
;;            company-quickhelp-color-foreground "dark gray"
;;            company-quickhelp-delay 0
;;            company-quickhelp-use-propertized-text t))

(use-package company-statistics
  :config (company-statistics-mode))

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

;; (use-backend company-anaconda 'anaconda-mode-hook)
(add-backend company-elisp 'emacs-lisp-mode-hook)
(use-backend company-lua 'lua-mode-hook)
(use-backend company-web 'web-mode-hook)
(use-backend company-shell 'sh-mode-hook)

;; (use-package racer
;; :init (progn
;; (add-hook 'rust-mode-hook #'racer-mode)
;; (add-hook 'racer-mode-hook #'eldoc-mode)))

;; (use-package irony
;;   :disabled t
;;   :init (progn
;;           (add-hook 'c++-mode-hook 'irony-mode)
;;           (add-hook 'c-mode-hook 'irony-mode)
;;           (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options))
;;   :config (progn
;;             (use-backend company-irony 'irony-mode-hook)
;;             (use-package flycheck-irony
;;               :init (add-hook 'flycheck-mode-hook 'flycheck-irony-setup))))

(use-package golden-ratio
  :diminish golden-ratio-mode
  :config (setq
           frame-resize-pixelwise t
           golden-ratio-auto-scale t
           golden-ratio-exclude-buffer-names nil
           golden-ratio-exclude-modes '("message-buffer-mode"
                                        "debugger-mode"
                                        "help-mode"
                                        "custom-mode"
                                        "inferior-emacs-lisp-mode"))

  :config (golden-ratio-mode))

(use-package web-mode
  :mode ("\\.js[xm]?$" "\\.html$" "\\.css$")
  :custom (web-mode-enable-auto-quoting nil)
  :config (setq
           web-mode-content-types-alist '(("jsx" . "\\.js[x]?$")
                                          ("javascript" . "\\.rules$")
                                          ("javascript" . "\\.ts[x]?$")
                                          ("javascript" . "\\.jsm"))))

(use-package eldoc
  :diminish eldoc-mode
  :hook
  ((emacs-lisp-mode lisp-interaction-mode ielm-mode) . turn-on-eldoc-mode))

(use-package undo-tree
  :diminish undo-tree-mode
  :config (progn
            (global-undo-tree-mode 1))
  :config (setq
           undo-tree-visualizer-timestamps t
           undo-tree-visualizer-diff t))

(use-package ibuffer
  :commands ibuffer
  :bind (("C-x C-b" . ibuffer)))

(use-package gitignore-mode
  :mode ".gitignore")

(use-package markdown-mode
  :mode "\\.md")

(use-package which-key
  :diminish which-key-mode
  :config (setq
           which-key-idle-delay 0.5)
  :config (progn
            (which-key-mode 1)))

(use-package autorevert
  :diminish auto-revert-mode)

(use-package system-packages
  :defer t)

(use-package ripgrep)

(use-package projectile-ripgrep)

(use-package try
  :defer t)

(use-package visual-regexp-steroids
  :bind (("C-c r" . vr/replace)
         ("C-c R" . vr/query-replace))
  :config (progn
            ;; (advice-add 'vr/replace :around (lambda (oldfun &rest arguments)
            ;;                                   (save-excursion
            ;;                                     (goto-char (point-min))
            ;;                                     (apply oldfun arguments))))
            ))

;; (use-package multiple-cursors
;;   :defer t
;;   :bind (("<C-down-mouse-2>" . mc/add-cursor-on-click)
;;          ("<C-mouse-2>" . nil)))

;; (use-package persp-mode
;;   :disabled t
;;   :config (setq
;;            persp-interactive-completion-system 'ivy-completing-read)
;;   :config (progn
;;             (persp-mode 1)))

;; (use-package persp-mode-projectile-bridge
;;   :disabled t
;;   :config (progn
;;             (add-hook
;;              'after-init-hook
;;              'persp-mode-projectile-bridge-mode)
;;             (add-hook
;;              'persp-mode-projectile-bridge-mode-hook
;;              (lambda ()
;;                (if persp-mode-projectile-bridge-mode
;;                    (persp-mode-projectile-bridge-find-perspectives-for-all-buffers)
;;                  (persp-mode-projectile-bridge-kill-perspectives))))))

;; (use-package hydra
;;   :config (setq
;;            hydra-verbose t))

(use-package flx)

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
           ivy-re-builders-alist '((t . ivy--regex-fuzzy))
           ;; ivy-sort-functions-alist '((t . string-lessp))
           )
  :config (progn
            (ivy-mode)
            (counsel-mode)))

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

;; (use-package flx
;;   :defer t)

;; (use-package lispy
;;   :disabled t
;;   :defer t
;;   :config (progn
;;             (add-hook 'emacs-lisp-mode-hook
;;                       'lispy-mode)))

;; (use-package smex
;;   :defer t
;;   :config (progn
;;             (smex-initialize)))

(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit-status)
  :config (setq
           magit-completing-read-function 'ivy-completing-read))

;; (use-package smart-tabs-mode
;;   :disabled t
;;   :config (progn
;;             (smart-tabs-insinuate 'c 'c++ 'java 'javascript
;;                                   'cperl 'python 'ruby 'nxml)))

;; (use-package dumb-jump
;;   :defer t)

;; (use-package dired-single
;;   :defer t
;;   :bind (:map dired-mode-map
;;               ("<return>" . dired-single-buffer)
;;               ("<mouse-1>" . dired-single-buffer-mouse))
;;   (bind-key "^"
;;             #'(lambda nil
;;                 (interactive)
;;                 (dired-single-buffer ".."))
;;             dired-mode-map))

;; (use-package whitespace
;;   :defer t
;;   :init (add-hook 'before-save-hook 'whitespace-cleanup)
;;   :init (add-hook 'prog-mode-hook 'whitespace-mode)
;;   :config (setq
;;            whitespace-line-column 80
;;            whitespace-style '(face trailing
;;                                    ;;tabs
;;                                    lines-tail
;;                                    empty
;;                                    ;;indentation::space
;;                                    )))

(use-package compile
  :config (progn
            (defun compile-shell-adv (old-compile command &optional comint)
              (funcall old-compile command t))
            (advice-add 'compile :around #'compile-shell-adv)))

(use-package kotlin-mode
  :mode ("\\.kt$" . kotlin-mode))

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package yaml-mode
  :mode ("\\.yaml$" "\\.yml$"))

;; (use-package elpy
;;   :config
;;   (elpy-enable))

(use-package lsp-mode
  :commands lsp
  :custom (lsp-prefer-flymake . nil))

(use-package lsp-ui
  :commands lsp-ui-mode
  :custom (lsp-ui-sideline-show-hover . nil))
(use-package company-lsp
  :commands company-lsp
  :init
  (push 'company-lsp company-backends))

(use-package rust-mode
  :mode ("\\.rs$" . rust-mode)
  :bind ("C-c <tab>" . rust-format-buffer)
  :hook (rust-mode . lsp)
  ;; :config (setq
  ;; rust-format-on-save t))
  )

(use-package blacken
  :commands blacken-buffer)

;; (use-package flycheck-rust
;;   :defer t
;;   :init (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

(use-package glsl-mode)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

(use-package pyenv-mode
  :config (pyenv-mode))
