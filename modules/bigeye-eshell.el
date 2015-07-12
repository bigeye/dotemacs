(require 'eshell)
(stante-after eshell
	      (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
	      (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
	      (setq-default ansi-color-names-vector
			    ["black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" ])
	      (defun eshell/clear ()
		"Clears the shell buffer"
		(interactive)
		(let ((inhibit-read-only t))
		  (erase-buffer)))

	      (setq eshell-save-history-on-exit t)
	      (setq eshell-history-size 512)
	      (setq eshell-hist-ignoredups t)
	      (setq eshell-cmpl-cycle-completions nil)
	      ;; C-a
	      ;; from ZwaX at EmacsWiki
	      ;; I use the following code. It makes C-a go to the beginning of the
	      ;; command line, unless it is already there, in which case it goes to the
	      ;; beginning of the line. So if you are at the end of the command line
	      ;; and want to go to the real beginning of line, hit C-a twice:
	      (defun eshell-maybe-bol ()
		(interactive)
		(let ((p (point)))
		  (eshell-bol)
		  (if (= p (point))
		      (beginning-of-line))))

	      (add-hook 'eshell-mode-hook
			'(lambda () (define-key eshell-mode-map "\C-a" 'eshell-maybe-bol)))

	      ;; use ansi-term for these commands
	      (add-hook
	       'eshell-first-time-mode-hook
	       (lambda ()
		 (setq eshell-visual-commands
		       (append '("mutt" "vim" "screen" "ftp" "lftp" "telnet" "ssh" "tmux")
			       eshell-visual-commands))))
)

(require 'shell-pop)
(global-set-key (kbd "C-c t") 'shell-pop)

(provide 'bigeye-eshell)
