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
;;             (telephone-line-mode)))

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


(add-backend company-elisp 'emacs-lisp-mode-hook)
(use-backend company-lua 'lua-mode-hook)
(use-backend company-web 'web-mode-hook)
(use-backend company-shell 'sh-mode-hook)

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
            (global-undo-tree-mode))
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
            (which-key-mode)))

(use-package autorevert
  :diminish auto-revert-mode)

(use-package ripgrep)

(use-package projectile-ripgrep)

(use-package try
  :defer t)

(use-package visual-regexp-steroids
  :bind (("C-c r" . vr/replace)
         ("C-c R" . vr/query-replace)))

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

(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit-status)
  :config (setq
           magit-completing-read-function 'ivy-completing-read))

(use-package compile
  :config (progn
            (defun compile-shell-adv (old-compile command &optional comint)
              (funcall old-compile command t))
            (advice-add 'compile :around #'compile-shell-adv)))

(use-package kotlin-mode
  :mode ("\\.kt$" . kotlin-mode))

(use-package editorconfig
  :config
  (editorconfig-mode))

(use-package yaml-mode
  :mode ("\\.yaml$" "\\.yml$"))

(use-package pyvenv
  :init
  (defun pipenv-venv (&optional directory)
    "Find the virtualenv for DIRECTORY, or default-directory."
    (interactive "D")
    (with-temp-buffer
      (let ((default-directory (or directory default-directory)))
        (when (= (call-process "pipenv" nil (list (current-buffer) nil) nil "--venv") 0)
          (pyvenv-activate (substring (buffer-string) 0 -1))))))
  :config
  (pyvenv-mode)
  :hook (python-mode . (lambda () (pipenv-venv) (lsp))))

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
  :commands blacken-buffer
  :hook (python-mode .  blacken-mode))

(use-package py-isort
  :commands py-isort
  :hook (before-save . py-isort-before-save))

(use-package glsl-mode)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))
