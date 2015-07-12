;;; A quick major mode help with discover-my-major
(require 'discover-my-major)

(global-unset-key (kbd "C-h h"))        ; original "C-h h" displays "hello world" in different languages
(define-key 'help-command (kbd "h m") 'discover-my-major)

(provide 'bigeye-help)
;;; bigeye-help.el ends here
