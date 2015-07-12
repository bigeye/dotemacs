(add-to-list 'load-path "~/.emacs.d/vendor/mark-multiple")
(require 'inline-string-rectangle)
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)
(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
(global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)

(global-set-key (kbd "C-*") 'mark-all-like-this)

(provide 'bigeye-inline-string-rectangle)
