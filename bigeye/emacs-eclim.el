(add-to-list 'load-path "~/.emacs.d/vendor/emacs-eclim")
;; only add the vendor path when you want to use the libraries provided with emacs-eclim
;; (add-to-list 'load-path (expand-file-name "~/coding/git/emacs-eclim/vendor"))

(setq eclimd-wait-for-process nil)
(require 'eclim)

(setq eclim-auto-save nil)
(global-eclim-mode)
(require 'eclimd)

;; add the emacs-eclim source
(require 'ac-emacs-eclim-source)

(ac-emacs-eclim-config)