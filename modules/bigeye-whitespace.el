(require 'whitespace)
(stante-after whitespace
	      (setq global-whitespace-mode nil)
	      (setq whitespace-style
		    (quote
		     (face tabs spaces trailing lines space-before-tab newline indentation
			   space-after-tab space-mark tab-mark)))
	      (setq whitespace-global-modes '(c-mode c++-mode python-mode php-mode java-mode jde-mode js-mode))
	      (add-hook 'java-mode-hook
			(lambda ()
			  (setq whitespace-line-column 100)))
	      (set-face-attribute 'whitespace-line nil
				  :background "peach puff"
				  :foreground "nil"
				  :weight 'bold)
	      (set-face-attribute 'whitespace-space-after-tab nil
				  :background "lemon chiffon")
	      (set-face-attribute 'whitespace-indentation nil
				  :background "lemon chiffon")
)

(provide 'bigeye-whitespace)
