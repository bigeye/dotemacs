(use-package java-mode-indent-annotations
  :load-path "vendor/java-mode-indent-annotations")



(defun my-java-mode-hook ()
  (require 'cc-mode-expansions
  (er/add-cc-mode-expansions)
  (setq c-basic-offset 2)
  (c-set-offset 'arglist-cont-nonempty '++)
  (c-set-offset 'statement-cont '++)
  )

(provide 'bigeye-java-mode)
