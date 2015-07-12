(add-to-list 'load-path "~/.emacs.d/base")
(add-to-list 'load-path "~/.emacs.d/modules")
;; (add-to-list 'load-path "~/.emacs.d/vendor")

(setq config-directory "~/.emacs.d")

(setq custom-file "~/.emacs.d/base/custom.el")
(load custom-file 'noerror)

(require 'bigeye-packages)

(require 'bigeye-defuns)
(require 'bigeye-eshell)
(require 'bigeye-erc)

;; (require 'bigeye-auto-complete)

(require 'bigeye-whitespace)
(require 'bigeye-line-number)
(require 'bigeye-jabber)
(require 'bigeye-font)
(require 'bigeye-markdown-mode)
(require 'bigeye-ace-jump-mode)
(require 'bigeye-inline-string-rectangle)
(require 'bigeye-mode-line)
(require 'bigeye-org-mode)
(require 'bigeye-ibuffer)
(require 'bigeye-emacs-eclim)
;; (require 'bigeye-ido-mode)
;; (require 'bigeye-flx-ido-mode)
(require 'bigeye-compile)
(require 'bigeye-yasnippet)
;; (require 'bigeye-color-theme)
(require 'bigeye-coffee-mode)
(require 'bigeye-expand-region)
(require 'bigeye-iy-go-to-char)
(require 'bigeye-window-number)
(require 'bigeye-glsl-mode)
;; (vendor 'restclient)

(require 'bigeye-helm)
(require 'bigeye-projectile)
(require 'bigeye-gtags)
(require 'bigeye-javacc-mode)
(require 'bigeye-editing)
(require 'bigeye-show-paren-mode)
(require 'bigeye-color)
(require 'bigeye-gdb)
(require 'bigeye-workgroups2)
(require 'bigeye-powerline)
(require 'bigeye-android-mode)

;; For using JAVA, it is necessary to use upstream cedet.
;; It seems not to work well.
;; (require 'bigeye-cedet)

;; Use emacs built-in cedet
(require 'bigeye-semantic-mode)

;; (vendor 'xcscope)
;; (vendor 'xcscope+)
;; (vendor 'jflex-mode)

(load-theme 'monokai t)

(require 'bigeye-company-mode)

;; key binding should be in last part
(require 'bigeye-bindings)

;; (load-dir "~/.emacs.d/bigeye/")

(load "local" 'noerror)
