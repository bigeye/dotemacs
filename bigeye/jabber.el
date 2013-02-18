(if (file-readable-p "~/.jabber_accounts")
    (progn
                                        ; Load personal accounts (setq jabber-account-list '(...) )
                                        ; (setq jabber-account-list '(
                                        ;
                                        ;                              ("username@gmail.com"
                                        ;                              (:password . "userpassword")
                                        ;                              (:network-server . "talk.google.com")
                                        ;                              (:port . 443)
                                        ;                              (:connection-type . ssl))
                                        ;                            )
                                        ; )
       (load-file "~/.jabber_accounts")
       (add-to-list 'load-path "~/.emacs.d/vendor/jabber")
       (require 'jabber-autoloads)
       (add-to-list 'same-window-buffer-names "*-Jabber-*")
       (custom-set-variables
        ;; custom-set-variables was added by Custom.
        ;; If you edit it by hand, you could mess it up, so be careful.
        ;; Your init file should contain only one such instance.
        ;; If there is more than one, they won't work right.
        '(jabber-message-alert-same-buffer nil)
        '(jabber-auto-reconnect t)
        '(jabber-avatar-verbose nil)
        '(jabber-vcard-avatars-retrieve nil)
        '(jabber-chat-buffer-format "*-Jabber-%n-*")
        '(jabber-history-enabled t)
        '(jabber-mode-line-mode t)
        '(jabber-roster-buffer "*-Jabber-*")
        '(jabber-roster-line-format " %14s | %-23n(%j) %S")
        '(jabber-libnotify-method 'shell)
        '(jabber-show-offline-contacts nil)
        '(jabber-show-resources nil)
        '(jabber-roster-show-bindings nil)
        '(jabber-alert-presence-message-function (lambda (who oldstatus newstatus statustext) nil))
        '(jabber-use-global-history nil)
        '(jabber-roster-show-title nil))
       (if (/= 0 (length jabber-account-list))
           (jabber-connect-all))
       (global-set-key (kbd "C-x g") 'jabber-display-roster)
       )

      (defvar my-libnotify-program "/usr/bin/notify-send")
      (defun my-notify-send (title message)
        (start-process "notify" " notify"
                       my-libnotify-program "--expire-time=2500" title message))
      (defun my-jabber-libnotify-message (from buf text proposed-alert)
        "(jabber.el hook) Notify of new Jabber chat messages via libnotify"
        (when (or jabber-message-alert-same-buffer
                  (not (memq (selected-window) (get-buffer-window-list buf))))
          (if (jabber-muc-sender-p from)
              (my-notify-send (format "(PM) %s"
                                      (jabber-jid-displayname (jabber-jid-user from)))
                              (format "%s: %s" (jabber-jid-resource from) text)))
          (my-notify-send (format "%s" (jabber-jid-displayname from))
                          text)))
      (add-hook 'jabber-alert-message-hooks 'my-jabber-libnotify-message))

;; (defvar libnotify-program "/usr/bin/notify-send")
;; (defun notify-send (title message)
;;   (start-process "notify" " notify"
;; 		 libnotify-program "--expire-time=4000" title message))
;; (defun libnotify-jabber-notify (from buf text proposed-alert)
;;   "(jabber.el hook) Notify of new Jabber chat messages via libnotify"
;;   (when (or jabber-message-alert-same-buffer
;;             (not (memq (selected-window) (get-buffer-window-list buf))))
;;     (if (jabber-muc-sender-p from)
;;         (notify-send (format "(PM) %s"
;;                        (jabber-jid-displayname (jabber-jid-user from)))
;;                (format "%s: %s" (jabber-jid-resource from) text)))
;;       (notify-send (format "%s" (jabber-jid-displayname from))
;;              text)))