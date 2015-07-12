(require 'erc)

(erc-autojoin-mode t)
(setq erc-prompt (lambda ()
                   (if (and (boundp 'erc-default-recipients) (erc-default-target))
                       (erc-propertize (concat (erc-default-target) ">") 'read-only t 'rear-nonsticky t 'front-nonsticky t)
                     (erc-propertize (concat "ERC>") 'read-only t 'rear-nonsticky t 'front-nonsticky t))))

(setq erc-track-exclude-types '("JOIN" "PART" "QUIT" "NICK" "MODE"))
(setq erc-button-url-regexp
      "\\([-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]+\\.\\)+[-a-zA-Z0-9_=!?#$@~`%&*+\\/:;,]*[-a-zA-Z0-9\\/]")

(setq erc-mode-line-format "%t")

(require 'erc-hl-nicks)

(require 'erc-log)
(setq erc-log-channels-directory "~/.erc")
(erc-log-enable)

(ignore-errors
  (load "~/.erc_accounts" t))
;; (global-set-key (kbd "C-x C-j C-;") 'erc-track-switch-buffer)


(provide 'bigeye-erc)
