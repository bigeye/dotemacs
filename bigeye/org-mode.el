(require 'org)
(stante-after org
	      ;; org-mode
	      (setq org-log-done 'time)
	      (setq org-agenda-files (list "~/org/emacs.org"
					   "~/org/blog.org"))
	      ;; (set-face-underline 'org-level-1 nil)
	      (define-key global-map "\C-ca" 'org-agenda)

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

              (require 'org-crypt)
              (org-crypt-use-before-save-magic)
              (setq org-tags-exclude-from-inheritance (quote ("crypt")))

              (setq org-crypt-key nil)
              ;; GPG key to use for encryption
              ;; Either the Key ID or set to nil to use symmetric encryption.

              (setq auto-save-default nil)
              ;; Auto-saving does not cooperate with org-crypt.el: so you need
              ;; to turn it off if you plan to use org-crypt.el quite often.
              ;; Otherwise, you'll get an (annoying) message each time you
              ;; start Org.

              ;; To turn it off only locally, you can insert this:
              ;;
              ;; # -*- buffer-auto-save-file-name: nil; -*-
)
