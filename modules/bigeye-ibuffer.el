(require 'ibuffer)

(add-hook 'ibuffer-hook
          (lambda ()
            (ibuffer-vc-set-filter-groups-by-vc-root)
            (unless (eq ibuffer-sorting-mode 'alphabetic)
              (ibuffer-do-sort-by-alphabetic))))

;; (setq ibuffer-saved-filter-groups
;;       (quote (("default"
;;                ("Org"
;;                 (mode . org-mode))
;;                ("Programming" ;; prog stuff not already in MyProjectX
;;                 (or
;;                  (mode . c-mode)
;;                  (mode . perl-mode)
;;                  (mode . python-mode)
;;                  (mode . emacs-lisp-mode)
;;                  ;; etc
;;                  ))
;;                ("ERC"   (mode . erc-mode))))))

(setq ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

;; Use human readable Size column instead of original one
(define-ibuffer-column size-h
  (:name "Size" :inline t)
  (cond
   ((> (buffer-size) 1000) (format "%7.3fk" (/ (buffer-size) 1000.0)))
   ((> (buffer-size) 1000000) (format "%7.3fM" (/ (buffer-size) 1000000.0)))
   (t (format "%8d" (buffer-size)))))

;; Modify the default ibuffer-formats
(setq ibuffer-formats
      '((mark modified read-only vc-status-mini " "
              (name 18 18 :left :elide)
              " "
              (size-h 9 -1 :right)
              " "
              (mode 16 16 :left :elide)
              " "
              (vc-status 16 16 :left)
              " "
              filename-and-process)))

(global-set-key "\C-x\C-b" 'ibuffer)

(defun bigeye-ibuffer-hook ()
  (local-unset-key (kbd "C-x C-f")))
(add-hook 'ibuffer-hook 'bigeye-ibuffer-hook)

(provide 'bigeye-ibuffer)
