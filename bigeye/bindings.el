(global-set-key [Hangul] 'toggle-input-method)
(global-set-key (kbd "<M-SPC>") 'toggle-input-method)
(global-set-key (kbd "<RET>") 'newline-and-indent)

;; (global-set-key (kbd "C-x C-j C-o") 'browse-url-at-point)
;; (global-set-key (kbd "C-x C-j o") 'browse-url)

(windmove-default-keybindings 'meta)
(global-set-key [\r] 'newline-and-indent)

(global-set-key (kbd "C-c C-g") 'magit-status)

(global-set-key (kbd "C-c m") 'mvn-last)
(global-set-key (kbd "<S-SPC>") 'toggle-input-method)

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)
