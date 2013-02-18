(define-key ctl-x-map "\C-m" jabber-global-keymap)
(global-set-key [Hangul] 'toggle-input-method)
(global-set-key (kbd "<M-SPC>") 'toggle-input-method)

(global-set-key (kbd "C-x C-j C-o") 'browse-url-at-point)
(global-set-key (kbd "C-x C-j o") 'browse-url)
(global-set-key (kbd "C-x C-j C-l") 'jabber-activity-switch-to)
(global-set-key (kbd "C-x C-j C-;") 'erc-track-switch-buffer)

(windmove-default-keybindings 'meta)
(global-set-key [\r] 'newline-and-indent)