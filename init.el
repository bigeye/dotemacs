(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

(setq config-directory "~/.emacs.d")

(setq custom-file "~/.emacs.d/bigeye/custom.el")
(load custom-file 'noerror)

(load "packages")

(load "bigeye/defuns")

(load "bigeye/eshell")
(load "bigeye/erc")
(load "bigeye/auto-complete")
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
(load "bigeye/compile")
;; (load "bigeye/helm")
;; (load "bigeye/color-theme")
(load "bigeye/yasnippet")
(load "bigeye/android-mode")
(load "bigeye/coffee-mode")
(load "bigeye/expand-region")
(load "bigeye/iy-go-to-char")
(load "bigeye/window-number")
;; (vendor 'restclient)

(load "bigeye/color")

(vendor 'xcscope)
(vendor 'xcscope+)

(load-theme 'monokai t)

;; key binding should be in last part
(load "bigeye/bindings")

;; (load-dir "~/.emacs.d/bigeye/")

(load "local" 'noerror)