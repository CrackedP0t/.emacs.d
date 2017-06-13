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

(disable-theme 'misterioso)
