(require 'server)
(if (server-running-p)
	(kill-emacs)
  (server-start))

;; Make emacs look nice while loading
(load-theme 'misterioso)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

(set-frame-parameter nil 'fullscreen 'maximized)

;; Starting Up

;; This sets up the load path so that we can override it
(package-initialize)
(setq package-enable-at-startup nil)

(add-to-list 'load-path "~/.emacs.d/setup/")

;; Custom load paths
(setq custom-file "~/.emacs.d/setup/custom.el")
(load custom-file t)

(setq user-full-name "Elaina Martineau"
	  user-mail-address "elainamartineau@gmail.com")

(setq package-archives '(("org" . "http://orgmode.org/elpa/")
						 ("melpa-stable" . "http://stable.melpa.org/packages/")
						 ("melpa" . "http://melpa.org/packages/")
						 ("gnu" . "http://elpa.gnu.org/packages/")))

(setq package-archive-priorities '(("melpa-stable" . 4)
								   ("melpa" . 3)
								   ("org" . 2)
								   ("gnu" . 1)))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package auto-compile
  :ensure t
  :config (setq auto-compile-display-buffer nil)
  :config (progn (auto-compile-on-load-mode)))

(setq use-package-always-ensure t)

;; Load relevant .el files
(let ((elfiles '("packages" "config")))
  (mapc 'load elfiles))
