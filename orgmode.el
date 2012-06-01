;; org-mode
(setq org-log-done 'time)
(setq org-agenda-files (list "~/org/emacs.org"
                             "~/org/blog.org"))
;; (set-face-underline 'org-level-1 nil)
(define-key global-map "\C-ca" 'org-agenda)