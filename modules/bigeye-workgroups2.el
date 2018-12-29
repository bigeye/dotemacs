(use-package workgroups2
  :config (progn
            (setq wg-prefix-key (kbd "C-c w"))
            (define-key wg-prefixed-map (kbd "s") 'wg-save-session)
            (define-key wg-prefixed-map (kbd "l") 'wg-reload-session)
            (setq wg-session-file (concat config-directory "/.emacs_workgroups"))
            (workgroups-mode 1)))
(provide 'bigeye-workgroups2)
