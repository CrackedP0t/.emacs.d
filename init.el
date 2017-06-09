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

(setq package-archives
	  '(("melpa-stable" . "http://stable.melpa.org/packages/")
		("melpa" . "http://melpa.org/packages/")
		("org" . "http://orgmode.org/elpa/")
		("gnu" . "http://elpa.gnu.org/packages/")))

(setq package-archive-priorities
	  '(("melpa-stable" . 4)
		("melpa" . 3)
		("org" . 2)
		("gnu" . 1)))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;;(use-package auto-compile
;;			 :config (auto-compile-on-load-mode))

;; Load relevant .el files
(let ((elfiles '("packages" "config")))
  (mapc 'load elfiles))
