(require 'eclim)
(require 'eclimd)
(setq eclimd-wait-for-process nil)
(setq eclim-auto-save nil)
(global-eclim-mode)
(setq eclim-eclipse-dirs '("~/opt/eclipse"))

;; add the emacs-eclim source
;; (require 'ac-emacs-eclim-source)

;; (ac-emacs-eclim-config)
