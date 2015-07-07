;; customization
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(android-mode-build-command-alist (quote ((ant . "ant -e") (maven . "mvn -Psign"))))
 '(android-mode-builder (quote maven) nil nil "I'm using maven.")
 '(android-mode-sdk-dir (getenv "ANDROID_HOME"))
 '(auto-save-default nil)
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "google-chrome")
 '(c-basic-offset 2)
 '(company-idle-delay 0.3)
 '(company-minimum-prefix-length 2)
 '(compilation-error-regexp-alist (quote (("\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*" 1 2 3) ("^\\(.*\\):\\[\\([0-9]*\\),\\([0-9]*\\)\\]" 1 2 3) absoft ada aix ant bash borland python-tracebacks-and-caml comma cucumber msft edg-1 edg-2 epc ftnchek iar ibm irix java jikes-file maven jikes-line gcc-include ruby-Test::Unit gnu lcc makepp mips-1 mips-2 msft omake oracle perl php rxp sparc-pascal-file sparc-pascal-line sparc-pascal-example sun sun-ada watcom 4bsd gcov-file gcov-header gcov-nomark gcov-called-line gcov-never-called perl--Pod::Checker perl--Test perl--Test2 perl--Test::Harness weblint)))
 '(default-input-method "korean-hangul")
 '(eclim-auto-save nil)
 '(eclim-eclipse-dirs (quote ("~/opt/eclipse")))
 '(eclimd-wait-for-process nil)
 '(ede-project-directories (quote ("/home/bigeye/workspace/minicc")))
 '(indent-tabs-mode nil)
 '(jabber-alert-presence-message-function (lambda (who oldstatus newstatus statustext) nil))
 '(jabber-auto-reconnect t)
 '(jabber-avatar-verbose nil)
 '(jabber-chat-buffer-format "*-Jabber-%n-*")
 '(jabber-history-enabled t)
 '(jabber-libnotify-method (quote shell))
 '(jabber-message-alert-same-buffer nil)
 '(jabber-mode-line-mode t)
 '(jabber-roster-buffer "*-Jabber-*")
 '(jabber-roster-line-format " %14s | %-23n(%j) %S")
 '(jabber-roster-show-bindings nil)
 '(jabber-roster-show-title nil)
 '(jabber-show-offline-contacts nil)
 '(jabber-show-resources nil)
 '(jabber-use-global-history nil)
 '(jabber-vcard-avatars-retrieve nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(org-agenda-files (quote ("~/org/")))
 '(org-default-notes-file (concat org-directory "/notes.org"))
 '(org-log-done (quote time))
 '(org-log-into-drawer t)
 '(org-mobile-directory "~/org/mobileorg")
 '(org-refile-targets (quote ((nil :maxlevel . 2) (org-agenda-files :maxlevel . 1))))
 '(org-src-fontify-natively t)
 '(org-tags-exclude-from-inheritance (quote ("crypt")))
 '(org-todo-keywords (quote ((sequence "TODO(t!)" "|" "DONE(d!)") (sequence "REPORT(r!)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f@/!)") (sequence "|" "CANCELED(c!)"))))
 '(safe-local-variable-values (quote ((company-clang-arguments "-I/home/bigeye/workspace/tmp/tmux/") (company-clang-arguments "-I/home/bigeye/workspace/tmp/c-demo-project/include1/" "-I/home/bigeye/workspace/tmp/c-demo-project/include2/") (company-clang-arguments "-I/home/bigeye/workspace/tmp/c-demo-project/include/" "-I/home/bigeye/workspace/tmp/c-demo-project/include2/"))))
 '(same-window-buffer-names (quote ("*-Jabber-*" "*Help*")))
 '(tool-bar-mode nil)
 '(x-select-enable-clipboard t))

(if (eq system-type 'darwin)
  (progn
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil))
  )

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (add-to-list 'compilation-error-regexp-alist
;;              'maven)
;; (add-to-list 'compilation-error-regexp-alist-alist
;;        '(maven "\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*"
;;            1 2 3))
;; Don't know why it doesn't work
;; (add-hook 'eclim-mode-hook (lambda ()
;;                              (add-to-list 'compilation-error-regexp-alist '("\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*"
;;                                                                             1 2 3))))
