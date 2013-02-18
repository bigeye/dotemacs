(add-to-list 'load-path "~/.emacs.d/vendor")

(setq custom-file "~/.emacs.d/bigeye/custom.el")
(when (file-exists-p custom-file) (load custom-file))

(load "bigeye/defuns")
(load "bigeye/eshell")
(load "bigeye/erc")
(load "bigeye/auto-complete")
(load "bigeye/color")
(load "bigeye/whitespace")
(load "bigeye/line-number")
(load "bigeye/jabber")
(load "bigeye/font")
(load "bigeye/markdown-mode")
(load "bigeye/ace-jump-mode")
(load "bigeye/inline-string-rectangle")
(load "bigeye/mode-line")
(load "bigeye/org-mode")
(load "bigeye/ibuffer")
(load "bigeye/emacs-eclim")
(load "bigeye/ido-mode")
;; (load "bigeye/helm")

(vendor 'color-theme)
(vendor 'yasnippet)
(vendor 'android-mode)
(vendor 'restclient)
(vendor 'less-css-mode)
(vendor 'slim-mode)
(vendor 'coffee-mode)
(vendor 'expand-region)
(vendor 'iy-go-to-char)
(vendor 'window-number)

;; key binding should be in last part
(load "bigeye/bindings")