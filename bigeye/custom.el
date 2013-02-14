;; customization
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default-input-method "korean-hangul")
 '(make-backup-files nil)
 '(x-select-enable-clipboard t)
 '(indent-tabs-mode nil))

(menu-bar-mode -1)
(tool-bar-mode -1)

(if (eq system-type 'darwin)
  (progn
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil))
  )

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser")
(add-to-list 'same-window-buffer-names "*Help*")