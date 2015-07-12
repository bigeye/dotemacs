;; Configuration for basic editing

;; Enable conversion to uppercase/lowercase in region
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(setq c-basic-offset 2
      indent-tabs-mode nil
      make-backup-files nil
      menu-bar-mode nil
      tool-bar-mode nil)

(if (eq system-type 'darwin)
  (progn
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil))
  )


(provide 'bigeye-editing)
