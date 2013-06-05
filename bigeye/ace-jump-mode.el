(require 'ace-jump-mode)
(stante-after ace-jump-mode
	      ;; you can select the key you prefer to
	      (define-key global-map (kbd "C-c SPC") 'ace-jump-mode)
	      (define-key global-map (kbd "C-c C-c SPC") 'ace-jump-line-mode)
)
