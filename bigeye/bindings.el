(global-set-key [Hangul] 'toggle-input-method)
(global-set-key (kbd "<M-SPC>") 'toggle-input-method)
(global-set-key (kbd "<RET>") 'newline-and-indent)

(global-set-key (kbd "C-x C-j C-o") 'browse-url-at-point)
(global-set-key (kbd "C-x C-j o") 'browse-url)

(windmove-default-keybindings 'meta)
(global-set-key [\r] 'newline-and-indent)

(global-set-key (kbd "C-c g") 'magit-status)

(global-set-key "\C-x\C-n" 'other-window)
(global-set-key "\C-x\C-p" 'other-window-backward)

(global-set-key "\M-," 'point-to-top)
(global-set-key "\M-." 'point-to-bottom)
