;; stolen from http://lunaryorn.com/blog/2013/05/31/byte-compiling-eval-after-load/
(defmacro stante-after (feature &rest forms)
  "After FEATURE is loaded, evaluate FORMS.

FEATURE may be an unquoted feature symbol or a file name, see
`eval-after-load'."
  (declare (indent 1) (debug t))
  `(eval-after-load ',feature
     '(progn ,@forms)))

;; stolen from http://stackoverflow.com/questions/11690980/why-cant-i-use-old-theme-style-file-under-emacs-24-1
(defun plist-to-alist (the-plist)
  (defun get-tuple-from-plist (the-plist)
    (when the-plist
      (cons (car the-plist) (cadr the-plist))))

  (let ((alist '()))
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
  alist))

(defun vendor (library)
  (let* ((file (symbol-name library))
         (normal (concat "~/.emacs.d/vendor/" file))
         (suffix (concat normal ".el"))
         (bigeye (concat "~/.emacs.d/bigeye/" file)))
    (cond
     ((file-directory-p normal) (add-to-list 'load-path normal) (require library))
     ((file-exists-p suffix) (require library)))
    (when (file-exists-p (concat bigeye ".el"))
      (load bigeye))))

(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

(provide 'bigeye-defuns)
