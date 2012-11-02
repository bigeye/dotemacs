;; org-mode
(setq org-log-done 'time)
(setq org-agenda-files (list "~/org/emacs.org"
                             "~/org/blog.org"))
;; (set-face-underline 'org-level-1 nil)
(define-key global-map "\C-ca" 'org-agenda)

;;
;; Org-mode
;;

(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/org-mode/lisp"))
(require 'org-install)
(setq org-default-notes-file "~/org/notes.org")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org.gpg$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.ref$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.ref.gpg$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.notes$" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-agenda-files '("~/org"))
(setq org-log-into-drawer t)
(setq org-todo-keywords
           '((sequence "TODO(t!)" "|" "DONE(d!)")
             (sequence "REPORT(r!)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f@/!)")
             (sequence "|" "CANCELED(c!)")))
(setq org-mobile-directory "~/org/mobileorg")
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/notes.org" "Tasks")
         "* TODO %?\n%T")
        ("m" "Movie" entry (file+headline "~/org/movie.org" "Movies")
         "* TODO %?\n%T\n:PROPERTIES:\n:DIRECTOR:\n:STARS:\n:RELEASE DATE:\n:RECOMMENDED BY:\n:END:" )))

(setq org-refile-targets '((nil :maxlevel . 2)
                           (org-agenda-files :maxlevel . 1)))
