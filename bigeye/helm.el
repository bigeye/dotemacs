(add-to-list 'load-path "~/.emacs.d/vendor/helm")
(require 'helm-config)

(global-set-key (kbd "C-c h") 'helm-mini)
(helm-mode 1)

(global-set-key (kbd "C-x C-f") 'helm-find-files)
