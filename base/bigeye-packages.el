(require 'cl)
(require 'package)

;; Outdated repo
;; (add-to-list 'package-archives
;;              '("marmalade" . "http://marmalade-repo.org/packages/") t)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(defvar prelude-packages
  '(eshell
    erc
    erc-view-log
    erc-hl-nicks
    auto-complete
    jabber
    markdown-mode
    ace-jump-mode
    ibuffer
    ido
    color-theme
    yasnippet
    android-mode
    less-css-mode
    slim-mode
    coffee-mode
    expand-region
    window-number
    whitespace
    linum
    org
    iy-go-to-char
    monokai-theme
    glsl-mode
    emacs-eclim
    projectile
    flx-ido
    mvn
    anaconda-mode
    company
    company-anaconda
    company-c-headers
    company-go
    company-irony
    company-web
    function-args
    workgroups2
    powerline
    key-chord
    eproject
    helm
    helm-projectile
    helm-gtags
    magit
    duplicate-thing
    volatile-highlights
    smartparens
    clean-aindent-mode
    undo-tree
    ibuffer-vc
    dired+
    )
  "A list of packages to ensure are installed at launch.")

(defun prelude-packages-installed-p ()
  "Check if all packages in `prelude-packages' are installed."
  (every #'package-installed-p prelude-packages))

(defun prelude-require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package prelude-packages)
    (add-to-list 'prelude-packages package))
  (unless (package-installed-p package)
    (package-install package)))

(defun prelude-require-packages (packages)
  "Ensure PACKAGES are installed.
Missing packages are installed automatically."
  (mapc #'prelude-require-package packages))


(define-obsolete-function-alias 'prelude-ensure-module-deps 'prelude-require-packages)

(defun prelude-install-packages ()
  "Install all packages listed in `prelude-packages'."
  (unless (prelude-packages-installed-p)
    ;; check for new packages (package versions)
    (message "%s" "Emacs Prelude is now refreshing its package database...")
    (package-refresh-contents)

    (message "%s" " done.")
    ;; install the missing packages
    (prelude-require-packages prelude-packages)))

;; run package installation
(prelude-install-packages)

(provide 'bigeye-packages)
