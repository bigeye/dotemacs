(defun other-window-backward (&optional n)
  "Select Nth previous window."
  (interactive "P")
  (other-window (- (prefix-numeric-value n))))

(defun point-to-top ()
  "Put point on top line of window."
  (interactive)
  (move-to-window-line 0))

(defun point-to-bottom ()
  "Put point on bottom line of window."
  (interactive)
  (move-to-window-line -1))

(defvar unscroll-point (make-marker)
  "Cursor position for next call to `unscroll'.")

(defvar unscroll-window-start (make-marker)
  "Window start for next call to `unscroll'.")

(defvar unscroll-hscroll nil
  "Hscroll for next call to `unscroll'.")

(put 'scroll-up-command 'unscrollable t)
(put 'scroll-down-command 'unscrollable t)
(put 'scroll-left 'unscrollable t)
(put 'scroll-right 'unscrollable t)
(put 'mwheel-scroll 'unscrollable t)

(defun unscroll-maybe-remember ()
  (if (not (get last-command 'unscrollable))
      (progn
        (print "not ")
        (set-marker unscroll-point (point))
        (set-marker unscroll-window-start (window-start))
        (setq unscroll-hscroll (window-hscroll)))))

(defadvice scroll-up-command (before remember-for-unscroll
                             activate compile)
  "Remember where we started from, for `unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-down-command (before remember-for-unscroll
                               activate compile)
  "Remember where we started from, for `unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-left (before remember-for-unscroll
                               activate compile)
  "Remember where we started from, for `unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-right (before remember-for-unscroll
                                activate compile)
  "Remember where we started from, for `unscroll'."
  (unscroll-maybe-remember))

(defadvice mwheel-scroll (before remember-for-unscroll
                                 activate compile)
  "Remember where we started from, for `unscroll'."
  (unscroll-maybe-remember))

(defun unscroll ()
  "Jump to location specified by `unscroll-point' and `unscroll-window-point'."
  (interactive)
  (if (not unscroll-point)
      (error "Cannot unscroll yet"))
  (goto-char unscroll-point)
  (set-window-start nil unscroll-window-start)
  (set-window-hscroll nil unscroll-hscroll))
