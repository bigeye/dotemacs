(erc-autojoin-mode t)
(setq erc-mode-line-format "%S %t")
(and
 (require 'erc-highlight-nicknames)
 (add-to-list 'erc-modules 'highlight-nicknames)
 (erc-update-modules))

;; check channels
;; (erc-track-mode t)
;; (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"

;;                                  "324" "329" "332" "333" "353" "477"))
;; don't show any of this
;; (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(ignore-errors
  (load "~/.erc_accounts" t))
