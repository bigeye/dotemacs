(require 'eclim)
(global-eclim-mode)
(require 'eclimd)

(setq eclim-auto-save nil
      eclim-eclipse-dirs (quote ("~/opt/eclipse"))
      eclimd-wait-for-process nil)

;; add the emacs-eclim source
;; (require 'ac-emacs-eclim-source)

;; (ac-emacs-eclim-config)

(provide 'bigeye-emacs-eclim)
