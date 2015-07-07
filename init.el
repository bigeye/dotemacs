(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/vendor")

(setq config-directory "~/.emacs.d")

(setq custom-file "~/.emacs.d/bigeye/custom.el")
(load custom-file 'noerror)

(load "packages")

(load "bigeye/defuns")
(load "bigeye/eshell")
(load "bigeye/erc")

;; (load "bigeye/auto-complete")

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
;; (load "bigeye/ido-mode")
;; (load "bigeye/flx-ido-mode")
(load "bigeye/compile")
(load "bigeye/yasnippet")
;; (load "bigeye/color-theme")
(load "bigeye/coffee-mode")
(load "bigeye/expand-region")
(load "bigeye/iy-go-to-char")
(load "bigeye/window-number")
(load "bigeye/glsl-mode")
;; (vendor 'restclient)

(load "bigeye/helm")
(load "bigeye/projectile.el")
(load "bigeye/gtags")
(load "bigeye/javacc-mode")
(load "bigeye/editing")
(load "bigeye/show-paren-mode")
(load "bigeye/color")
(load "bigeye/gdb")

;; For using JAVA, it is necessary to use upstream cedet.
;; It seems not to work well.
;; (load "bigeye/cedet")

;; Use emacs built-in cedet
(load "bigeye/semantic-mode")

(vendor 'xcscope)
(vendor 'xcscope+)
(vendor 'jflex-mode)

(load-theme 'monokai t)

(load "bigeye/company-mode")

;; key binding should be in last part
(load "bigeye/bindings")

;; (load-dir "~/.emacs.d/bigeye/")

(load "local" 'noerror)
