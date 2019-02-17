;;; final.el --- miscellaneous configuration

;;; Commentary:

;;; Code:

(require 'use-package)

(make-directory "~/.emacs.d/autosaves/" t)

(setq vc-handled-backends nil)

(fset 'yes-or-no-p 'y-or-n-p)

(add-hook 'before-save-hook 'whitespace-cleanup)

(add-hook 'prog-mode-hook 'show-paren-mode)

(add-hook 'after-make-frame-functions
          (lambda (frame)
            (set-frame-parameter nil 'fullscreen 'maximized)))

(defun kill-emacs-if-only-frame ()
  "If there is only one frame, kill Emacs."
  (when (eq (length (frame-list)) 1)
    (print "Only frame; killing" 'external-debugging-output)
    (save-buffers-kill-emacs t)))

(add-hook 'delete-frame-functions 'kill-emacs-if-only-frame)

(prefer-coding-system 'utf-8)

(bind-key* "C-;" (lambda ()
                   (interactive)
                   (save-excursion (comment-line 1))))
(unbind-key "C-x C-;")

(bind-key* "<mouse-3>" 'mouse-major-mode-menu)
(unbind-key "<C-down-mouse-1>")

(bind-key* "<down-mouse-2>" 'mouse-yank-at-click)
(unbind-key "<mouse-2>")

(bind-key* "C-c f f" 'find-function)
(bind-key* "C-c f v" 'find-variable)

(bind-key* "C-c C-b" 'recompile)

(bind-key* "C-c k" 'kill-this-buffer)

(require 'comint)

(bind-key "C-^" 'comint-previous-input comint-mode-map)

;; (mapc (lambda (key) (unbind-key key)) '("<up>"
;;                                         "<down>"
;;                                         "<left>"
;;                                         "<right>"))

(setq-default indent-tabs-mode nil
              tab-width 4
              debugger-bury-or-kill 'kill
              backward-delete-char-untabify-method 'all
              require-final-newline t
              diary-file "~/Documents/diary.txt")

(when (member "DejaVu Sans Mono" (font-family-list))
  (set-face-attribute 'default nil :font "DejaVu Sans Mono"))

(defun clean-init ()
  "Kill Emacs, then clear out ~/.emacs.d."
  (interactive)
  (add-to-list
   'kill-emacs-hook
   (lambda ()
;;; I just think this git command is really cool
;;; cd ~/.emacs.d/ && git status --ignored --porcelain \
;;; | sed -nE \"s/\!! (.+)$/\\1/p\" | xargs rm -r &"))
     (delete-directory
      user-emacs-directory t))
   t)
  (save-buffers-kill-emacs))

(advice-add #'save-buffers-kill-emacs :around
            (lambda (oldfun &optional should-save)
              (funcall oldfun t)))

(defun stop-using-minibuffer ()
  "Kill the minibuffer."
  (when (and (>= (recursion-depth) 1) (active-minibuffer-window))
    (abort-recursive-edit)))

(add-hook 'mouse-leave-buffer-hook #'stop-using-minibuffer)

(defun column-number (&optional pos)
  "Return the column of POS or point."
  (save-excursion
    (when pos (goto-char pos))
    (current-column)))

(defun rect-top-left-pos (p1 p2)
  "Get the position of the top left corner of \
the rectangle specified by P1 and P2."
  (save-excursion
    (goto-char (min p1 p2))
    (beginning-of-line)
    (forward-char (min (column-number p1)
                       (column-number p2)))
    (point)))

(defun end-of-line-pos (&optional pos)
  "Get the position of the end of the line containing POS or point."
  (save-excursion
    (when pos (goto-char pos))
    (end-of-line)
    (point)))

(defun beginning-of-line-pos (&optional pos)
  "Get the position of the beginning of the line containing POS or point."
  (save-excursion
    (when p (goto-char p))
    (beginning-of-line)
    (point)))

(require 'picture)

(defun rect-forward (p1 p2 n)
  "Shift the rect specified by P1 and P2 forward by N."
  (interactive "r\np")
  (save-excursion
    (let* ((rect (extract-rectangle p1 p2)))

      (clear-rectangle p1 p2)

      (goto-char (rect-top-left-pos p1 p2))

      (picture-forward-column n)

      (picture-insert-rectangle rect))))

(defun rect-down (p1 p2 n)
  "Shift the rect specified by P1 and P2 down by N."
  (interactive "r\np")
  (save-excursion
    (let* ((rect (extract-rectangle p1 p2)))

      (clear-rectangle p1 p2)

      (goto-char (rect-top-left-pos p1 p2))

      (picture-move-down n)

      (picture-insert-rectangle rect))))

;; (bind-key* "<C-up>" (lambda ()
;;                       (interactive)
;;                       (save-excursion
;;                         (save-excursion
;;                           (end-of-line)
;;                           (insert ? ))
;;                         (rect-down (point) (1- (end-of-line-pos (point))) -1)
;;                         (end-of-line)
;;                         (delete-char -1))
;;                       (goto-char (+ (column-number)
;;                                     (save-excursion
;;                                       (forward-line -1)
;;                                       (point))))
;;                       (whitespace-cleanup)))

;; (bind-key* "<C-down>" (lambda ()
;;                         (interactive)
;;                         (save-excursion
;;                           (save-excursion
;;                             (end-of-line)
;;                             (insert ? ))
;;                           (rect-down (point) (1- (end-of-line-pos (point))) 1)
;;                           (end-of-line)
;;                           (delete-char -1))
;;                         (goto-char (+ (column-number)

;;                                       (save-excursion
;;                                         (forward-line 1)
;;                                         (point))))
;;                         (whitespace-cleanup)))

(defun what-face (pos)
  "Print the face at POS."
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face)
      (message "No face at %d" pos))))

(defun move-buffer (newname)
  "Move the current buffer's file to NEWNAME \
and make the buffer point to the new path."
  (interactive "FMove file to: ")
  (rename-file (buffer-file-name) newname)
  (set-visited-file-name newname nil t))

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(defun goto-char-forward (character)
  "Jump to the next CHARACTER provided."
  (interactive "cCharacter: ")
  (search-forward (char-to-string character) nil 't 1))

(defun goto-char-backward (character)
  "Jump to the previous CHARACTER provided."
  (interactive "cCharacter: ")
  (search-forward (char-to-string character) nil 't -1))

(bind-key* "C-c g" 'goto-char-forward)
(bind-key* "C-c v" 'goto-char-backward)

(provide 'final)
;;; final.el ends here
