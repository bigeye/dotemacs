(add-to-list 'load-path "~/.emacs.d/vendor/expand-region")
(require 'expand-region)
(stante-after expand-region
	     (global-set-key (kbd "C-=") 'er/expand-region)
)

(provide 'bigeye-expand-region)
