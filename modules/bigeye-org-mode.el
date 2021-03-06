(require 'org)

;;; This code snippet is imported from
;;; http://stackoverflow.com/a/8432149/776937.
;;; Originally authored by Chris Zheng

(defvar org-mobile-sync-timer nil)

(defvar org-mobile-sync-idle-secs (* 60 60))

(defun org-mobile-sync ()
  (interactive)
  (message "org-mobile-sync")
  (org-mobile-pull)
  (org-mobile-push))

(defun org-mobile-sync-enable ()
  "enable mobile org idle sync"
  (interactive)
  (setq org-mobile-sync-timer
        (run-with-idle-timer org-mobile-sync-idle-secs t
                             'org-mobile-sync)))

(defun org-mobile-sync-disable ()
  "disable mobile org idle sync"
  (interactive)
  (cancel-timer org-mobile-sync-timer))

;;; Org-mode config

(stante-after org
  ;; org-mode
  ;; (set-face-underline 'org-level-1 nil)
  (define-key global-map "\C-ca" 'org-agenda)

  (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.org.gpg$" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.ref$" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.ref.gpg$" . org-mode))
  (add-to-list 'auto-mode-alist '("\\.notes$" . org-mode))

  (global-set-key "\C-cl" 'org-store-link)
  (global-set-key "\C-cc" 'org-capture)
  (global-set-key "\C-ca" 'org-agenda)
  (global-set-key "\C-cb" 'org-iswitchb)

  (setq org-capture-templates
        '(("t" "Todo" entry (file+headline "~/org/notes.org" "Tasks")
           "* TODO %?\n%T")
          ("m" "Movie" entry (file+headline "~/org/movie.org" "Movies")
           "* TODO %?\n%T\n:PROPERTIES:\n:DIRECTOR:\n:STARS:\n:RELEASE DATE:\n:RECOMMENDED BY:\n:END:" )))
  (setq
   org-agenda-files (quote ("~/org/"))
   org-default-notes-file (concat org-directory "/notes.org")
   org-log-done (quote time)
   org-log-into-drawer t
   org-mobile-directory "~/org/mobileorg"
   org-refile-targets (quote ((nil :maxlevel . 2) (org-agenda-files :maxlevel . 1)))
   org-src-fontify-natively t
   org-tags-exclude-from-inheritance (quote ("crypt"))
   org-todo-keywords (quote ((sequence "TODO(t!)" "|" "DONE(d!)") (sequence "REPORT(r!)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f@/!)") (sequence "|" "CANCELED(c!)")))
   )


  (org-mobile-sync-enable)

  (require 'org-crypt)
  (org-crypt-use-before-save-magic))

(provide 'bigeye-org-mode)
