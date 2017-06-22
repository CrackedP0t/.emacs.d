(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(apu--last-update-day-filename "~/.emacs.d/.last-package-update-day")
 '(auto-package-update-delete-old-versions t)
 '(auto-package-update-interval 2)
 '(auto-save-file-name-transforms (quote ((".*" "~/.auto-save/" t))))
 '(backup-directory-alist (quote (("." . "~/.backups"))))
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
 '(frame-resize-pixelwise t)
 '(help-window-select t)
 '(history-delete-duplicates t)
 '(history-length t)
 '(inhibit-startup-screen t)
 '(jdee-db-active-breakpoint-face-colors ("#1B2229" . "#51afef"))
 '(jdee-db-requested-breakpoint-face-colors ("#1B2229" . "#98be65"))
 '(jdee-db-spec-breakpoint-face-colors ("#1B2229" . "#3B3F46"))
 '(package-selected-packages
   (quote
	(dumb-jump smart-tabs-mode smarttabs smart-tabs flx lispy ace-window ace-link counsel ivy flycheck-irony ripgrep company bm anaconda-mode lua-mode projectile all-the-icons company-irony irony avy persp-mode-projectile-bridge persp-mode which-key web-mode visual-regexp virtualenvwrapper use-package undo-tree try system-packages switch-window spu smex restart-emacs rainbow-mode rainbow-delimiters projectile-ripgrep powerline paradox nlinum multiple-cursors moe-theme markdown-mode magit macrostep ido-ubiquitous grandshell-theme gotham-theme golden-ratio gitignore-mode flycheck flx-ido dracula-theme distinguished-theme company-web company-statistics company-quickhelp company-lua company-anaconda color-theme-sanityinc-tomorrow clues-theme browse-kill-ring auto-compile all-the-icons-dired)))
 '(persp-keymap-prefix "x")
 '(powerline-gui-use-vcs-glyph t)
 '(ring-bell-function (quote ignore))
 '(safe-local-variable-values
   (quote
	((company-clang-arguments "-I/home/elaina/Development/Projects/Browse3DS/include/" "-I/opt/devkitpro/devkitARM/include/" "-I/opt/devkitpro/libctru/include/")
	 (eval progn
		   (irony-mode 0)
		   (abbrev-mode 0))
	 (eval
	  (quote
	   (irony-mode 0)))
	 (eval
	  (irony-mode 0))
	 (company-clang-arguments "-Iinclude/" "-I/opt/devkitpro/devkitARM/include/" "-I/opt/devkitpro/libctru/include/")
	 (flycheck-gcc-include-path
	  ("/opt/devkitpro/devkitARM/include/" "/opt/devkitpro/libctru/include/" "../include/"))
	 (flycheck-gcc-warnings . "all")
	 (flycheck-c/c++-gcc-executable . "/opt/devkitpro/devkitARM/bin/arm-none-eabi-gcc"))))
 '(savehist-file "~/.emacs.d/savehist")
 '(savehist-mode t)
 '(sentence-end-double-space nil)
 '(show-paren-delay 0)
 '(tab-always-indent (quote complete))
 '(tab-width 4)
 '(tooltip-delay 0.2)
 '(tooltip-mode nil)
 '(tooltip-use-echo-area nil)
 '(whitespace-action (quote (auto-cleanup)))
 '(widget-choice-toggle t)
 '(x-gtk-use-system-tooltips t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#2d2d2d" :foreground "#cccccc" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 113 :width normal :foundry "PfEd" :family "AnonymousasdikjsagdasgdsgdaigsadiPro")))))
