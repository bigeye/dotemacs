(require 'helm)
(require 'projectile)

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(setq projectile-enable-caching t)

(provide 'bigeye-projectile)
