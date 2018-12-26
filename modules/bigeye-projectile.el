(require 'helm)
(require 'projectile)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-enable-caching t)

; (projectile-project-type) takes too much time
(setq projectile-mode-line
         '(:eval (format " Projectile[%s]"
                        (projectile-project-name))))

(provide 'bigeye-projectile)
