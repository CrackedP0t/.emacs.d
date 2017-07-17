(require 'server)
(if (server-running-p)
    (kill-emacs)
  (server-start))

;; Make emacs look nice while loading
(set-frame-font "Hack 12" nil t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(load-theme 'misterioso)

(set-frame-parameter nil 'fullscreen 'maximized)

(package-initialize)
(setq package-enable-at-startup nil)

(defvar setup-path "~/.emacsconf"
  "The path to the setup files")

(defvar custom-file (concat setup-path "/custom.el")
  "The custom file")

(add-to-list 'load-path setup-path)

(setq custom-file "~/.emacsconf/custom.el")
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
(let ((elfiles '("packages" "setup")))
  (mapc 'load elfiles))
