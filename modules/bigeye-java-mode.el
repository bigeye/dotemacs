(add-hook 'java-mode-hook
          (lambda ()
            "Treat Java 1.5 @-style annotations as comments."
            (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
            (modify-syntax-entry ?@ "< b" java-mode-syntax-table)))


(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 4)
                            (c-set-offset 'arglist-cont-nonempty '++)
                            (c-set-offset 'statement-cont '++)
                            ))

(provide 'bigeye-java-mode)
