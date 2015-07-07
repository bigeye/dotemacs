(autoload 'jflex-mode "jflex-mode" nil t)
(setq auto-mode-alist (cons '("\\(\\.flex\\|\\.jflex\\)\\'" . jflex-mode) auto-mode-alist))

(provide 'bigeye-jflex-mode)
