(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'before-save-hook 'whitespace-cleanup)

(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

(server-start)
