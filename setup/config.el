(setq vc-handled-backends nil)

(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'before-save-hook 'whitespace-cleanup)

(add-hook 'prog-mode-hook 'show-paren-mode)

(add-hook 'after-make-frame-functions (lambda (frame)
										(set-frame-parameter nil 'fullscreen 'maximized)))

(defun kill-emacs-if-only-frame (frame)
  "If FRAME is the only frame, kill emacs."
  (when (eq (length (frame-list))
			(print "Only frame; killing" 'external-debugging-output)
			(save-buffers-kill-emacs t))))

(add-hook 'delete-frame-functions 'kill-emacs-if-only-frame)

(prefer-coding-system 'utf-8)

(bind-key* "C-;" (lambda ()
				   (interactive)
				   (save-excursion (comment-line 1))))
(unbind-key "C-x C-;")

(bind-key "<mouse-3>" 'mouse-major-mode-menu)
(unbind-key "<C-down-mouse-1>")

(setq-default indent-tabs-mode t)
(setq-default tab-width 4)

(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

(defun clean-init ()
  "Kills emacs, then clears out ~/.emacs.d"
  (interactive)
  (add-to-list 'kill-emacs-hook (lambda ()
								  (call-process-shell-command "cd ~/.emacs.d/ && git status --ignored --porcelain | sed -nE \"s/\!! (.+)$/\1/p\" | xargs rm -r"))
			   t)
  (save-buffers-kill-emacs))
