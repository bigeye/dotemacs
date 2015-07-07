(require 'package)

;; Outdated repo
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar prelude-packages
  '(eshell erc auto-complete jabber markdown-mode ace-jump-mode
           ibuffer ido color-theme yasnippet android-mode less-css-mode
           slim-mode coffee-mode expand-region window-number
           whitespace linum org iy-go-to-char monokai-theme glsl-mode
           emacs-eclim projectile flx-ido mvn anaconda-mode
           company company-anaconda company-c-headers
           company-go company-irony company-web function-args
           powerline)
  "A list of packages to ensure are installed at launch.")

(dolist (p prelude-packages)
  (when (not (package-installed-p p))
    (package-install p)))
