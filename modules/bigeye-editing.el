;; Configuration for basic editing

;; Enable conversion to uppercase/lowercase in region
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq c-basic-offset 2
      indent-tabs-mode nil
      make-backup-files nil
      menu-bar-mode nil
      tool-bar-mode nil)

(menu-bar-mode -1)
(tool-bar-mode -1)

(if (eq system-type 'darwin)
  (progn
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil))
  )

(defun prelude-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.

Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.

If ARG is not nil or 1, move forward ARG - 1 lines first. If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))

  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))

  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(global-set-key (kbd "C-a") 'prelude-move-beginning-of-line)

(provide 'bigeye-editing)
