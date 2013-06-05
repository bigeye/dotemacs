(require 'markdown-mode)
(stante-after markdown-mode
	      (setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
	      (setq markdown-command "Markdown.pl")
)
