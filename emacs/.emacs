;;; Package --- Initial loading for emacs configuration

;;; Commentary:
;;; Pretty neat code if I do say so myself ;)

;;; Code:

(require 'server)
(if (server-running-p)
    (kill-emacs)
  (server-start))

;; Make emacs look nice while loading
(advice-add 'load-theme :after (lambda (&rest arguments)
                                 (set-face-attribute 'default nil
                                                     :family "Hack"
                                                     :height 100)) (list :name 'font))

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(load-theme 'misterioso)
(set-frame-parameter nil 'fullscreen 'maximized)

(package-initialize)
(setq package-enable-at-startup nil)

(defvar conf-path "~/.emacsconf/"
  "The path to the conf files.")

(defvar custom-file (concat conf-path "/custom.el")
  "The custom file.")

(add-to-list 'load-path conf-path)

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

(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-compile
  :config (setq
           auto-compile-display-buffer nil
           auto-compile-mode-line-counter t)
  :config (progn
            (auto-compile-on-load-mode)))

(setq auto-save-file-name-transforms (list (list ".*" (concat
                                                       user-emacs-directory
                                                       "/auto-save/")
                                                 t))
      backup-directory-alist (list (cons "." (concat
                                              user-emacs-directory
                                              "/backups/"))))

(mapc (lambda (dir)
        (make-directory (concat user-emacs-directory "/" dir) t))
      (list "autosaves/" "backups/"))

;; Load relevant .el files
(let ((elfiles (directory-files conf-path
                                nil
                                ".*\\.el$")))
  (mapc #'load elfiles))

(provide '.emacs)
;;; .emacs ends here
