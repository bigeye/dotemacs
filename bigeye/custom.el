;; customization
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default-input-method "korean-hangul")
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
 '(x-select-enable-clipboard t)
 '(indent-tabs-mode nil)
 '(c-basic-offset 2))

(menu-bar-mode -1)
(tool-bar-mode -1)

(if (eq system-type 'darwin)
  (progn
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil))
  )

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")
(add-to-list 'same-window-buffer-names "*Help*")
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
(add-hook 'eclim-mode-hook (lambda ()
                             (add-to-list 'compilation-error-regexp-alist '("\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*"
                                                                            1 2 3))))
