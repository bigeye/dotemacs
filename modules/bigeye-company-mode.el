;; (add-hook 'after-init-hook 'global-company-mode)
(global-company-mode)
(add-to-list 'company-backends 'company-c-headers)

(setq company-backends (delete 'company-semantic company-backends))
(eval-after-load "cc-mode"
  '(progn
     (add-to-list 'company-c-headers-path-system "/usr/include/c++/4.9/")
     ))

(setq company-idle-delay 0.3
      company-minimum-prefix-length 2)
;;      (define-key c-mode-map   (kbd "<tab>") 'company-complete)
;;      (define-key c++-mode-map (kbd "<tab>") 'company-complete)))

(provide 'bigeye-company-mode)
