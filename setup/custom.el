(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#cccccc" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#515151"))
 '(apu--last-update-day-filename "~/.emacs.d/.last-package-update-day")
 '(auto-package-update-delete-old-versions t)
 '(auto-package-update-interval 2)
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/auto-save-list/" t))))
 '(backup-directory-alist (quote (("." . "~/.emacs.d/backups"))))
 '(blink-matching-delay 0)
 '(blink-matching-paren-dont-ignore-comments t)
 '(company-backends (quote (company-capf company-keywords)))
 '(company-quickhelp-color-background "thistle4")
 '(company-quickhelp-color-foreground "dark gray")
 '(company-quickhelp-delay 0)
 '(company-quickhelp-use-propertized-text t)
 '(confirm-nonexistent-file-or-buffer nil)
 '(custom-buffer-done-kill t)
 '(custom-buffer-style (quote links))
 '(custom-buffer-verbose-help nil)
 '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
 '(custom-magic-show-hidden (quote (group option face)))
 '(custom-safe-themes t)
 '(custom-theme-directory "~/.emacs.d/themes/")
 '(custom-unlispify-menu-entries nil)
 '(delete-old-versions (quote other))
 '(delete-selection-mode t)
 '(fci-rule-color "#515151")
 '(flycheck-completing-read-function (quote ido-completing-read))
 '(flycheck-display-errors-delay 0)
 '(flycheck-idle-change-delay 0)
 '(frame-resize-pixelwise t)
 '(help-window-select t)
 '(history-delete-duplicates t)
 '(history-length t)
 '(inhibit-startup-screen t)
 '(jdee-db-active-breakpoint-face-colors ("#1B2229" . "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors ("#1B2229" . "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors ("#1B2229" . "#3B3F46"))
 '(menu-bar-mode nil)
 '(org-ellipsis "  ")
 '(package-selected-packages
   (quote
	(browse-kill-ring visual-regexp visual-regexp-builder virtualenvwrapper smartparens projectile-ripgrep grandshell-theme ripgrep-projectile ripgrep pt try try_ company-quickhelp persp-projectile perspective perspective-mode company-anaconda anaconda-mode flx-ido rainbow-mode system-packages projectile company-elisp emacs-async clues-theme clues-them distinguished-theme all-the-icons-dired all-the-icons-dired-mode gotham-theme color-theme-sanityinc-tomorrow sanityinc-tomorrow-themes all-the-icons doom-theme dracula-theme markdown-mode macstep pos-tip which-key markdown-mode+ web-mode macrostep \(car\ backend\) irony flycheck switch-window nlinum restart-emacs gitignore-mode company-lua lua-mode auto-package-update desktop+ cleanup-whitespace powerline undo-tree company rainbow-delimiters smex ido-ubiquitous paradox auto-compile use-package-chords use-package magit)))
 '(paradox-async-display-buffer-function nil)
 '(paradox-automatically-star t)
 '(paradox-column-width-package 32)
 '(paradox-execute-asynchronously t)
 '(paradox-homepage-button-string "page")
 '(paradox-spinner-type (quote random))
 '(powerline-gui-use-vcs-glyph t)
 '(projectile-mode-line
   (quote
	(:eval
	 (if
		 (file-remote-p default-directory)
		 ""
	   (format "%s"
			   (projectile-project-name))))))
 '(ring-bell-function (quote ignore))
 '(savehist-file "~/.emacs.d/savehist")
 '(savehist-mode t)
 '(scroll-bar-mode nil)
 '(sentence-end-double-space nil)
 '(show-paren-delay 0)
 '(tab-always-indent (quote complete))
 '(tab-width 4)
 '(tooltip-delay 0.2)
 '(tooltip-mode nil)
 '(tooltip-use-echo-area nil)
 '(use-package-always-ensure t)
 '(vc-annotate-color-map
   (quote
	((20 . "#f2777a")
	 (40 . "#f99157")
	 (60 . "#ffcc66")
	 (80 . "#99cc99")
	 (100 . "#66cccc")
	 (120 . "#6699cc")
	 (140 . "#cc99cc")
	 (160 . "#f2777a")
	 (180 . "#f99157")
	 (200 . "#ffcc66")
	 (220 . "#99cc99")
	 (240 . "#66cccc")
	 (260 . "#6699cc")
	 (280 . "#cc99cc")
	 (300 . "#f2777a")
	 (320 . "#f99157")
	 (340 . "#ffcc66")
	 (360 . "#99cc99"))))
 '(whitespace-action (quote (auto-cleanup)))
 '(widget-choice-toggle t)
 '(x-gtk-use-system-tooltips t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
