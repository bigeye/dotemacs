(require 'window-number)
(stante-after window-number
	     (setq window-number-mode-map (make-sparse-keymap))
	     ;; (window-number-define-keys window-number-mode-map "C-x C-o ")
	     (window-number-mode 1)
)

(provide 'bigeye-window-number)
