
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/local")
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
(use-package yasnippet
  :config (progn
            (add-to-list 'yas-snippet-dirs "~/.emacs.d/local/snippets")
            (yas-global-mode 1))
  :ensure t)
;; (require 'bigeye-color-theme)
(require 'bigeye-coffee-mode)
(use-package expand-region
  :bind ("C-=" . er/expand-region)
  :ensure t)


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
(require 'bigeye-volatile-highlights)
(require 'bigeye-smartparens)
(require 'bigeye-clean-aindent-mode)
(require 'bigeye-undo-tree)
(require 'bigeye-backup)
(require 'bigeye-dired)
(require 'bigeye-vlf)
(require 'bigeye-flyspell)
(require 'bigeye-flycheck)
(require 'bigeye-help)
(require 'bigeye-rainbow-mode)

;; For using JAVA, it is necessary to use upstream cedet.
;; It seems not to work well.
;; (require 'bigeye-cedet)

;; Use emacs built-in cedet
(require 'bigeye-semantic-mode)

;; (vendor 'xcscope)
;; (vendor 'xcscope+)
;; (vendor 'jflex-mode)
(require 'bigeye-java-mode)

(use-package avy
  :bind ("C-c SPC" . avy-goto-word-or-subword-1)
  :ensure t)

(use-package ace-window
  :bind ("M-p" . ace-window)
  :ensure t)

(load-theme 'monokai t)

(require 'bigeye-company-mode)

;; key binding should be in last part
(require 'bigeye-bindings)

;; (load-dir "~/.emacs.d/bigeye/")

(load "local")
