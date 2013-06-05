(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar prelude-packages
  '(eshell erc auto-complete jabber markdown-mode ace-jump-mode
           ibuffer ido color-theme yasnippet android-mode less-css-mode
           slim-mode coffee-mode expand-region window-number magit
	   whitespace linum org iy-go-to-char monokai-theme)
  "A list of packages to ensure are installed at launch.")

(dolist (p prelude-packages)
  (when (not (package-installed-p p))
    (package-install p)))
