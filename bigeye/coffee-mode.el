(require 'coffee-mode)
(stante-after coffee-mode
	      (defun coffee-custom ()
		"coffee-mode-hook"
		;; CoffeeScript uses two spaces.
		(make-local-variable 'tab-width)
		(set 'tab-width 2))
	      (add-hook 'coffee-mode-hook 'coffee-custom)
)
