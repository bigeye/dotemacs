(add-hook 'c-mode-common-hook 'my-c-mode)


(defun my-c-mode()
  "My c mode"
  (set (make-local-variable 'compile-command)
       (when buffer-file-name
         (concat (cond ((string= mode-name "C++/l") "g++")
                       ((string= mode-name "C/l") "gcc"))
                 " -O2 -lm "
                 (file-name-nondirectory buffer-file-name)
                 " -o "
                 (file-name-sans-extension
                  (file-name-nondirectory buffer-file-name)))
       )))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Compilation Settings ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun my-run ()
  "Run the output of compile"
  (interactive)
  (cond ((or (string= mode-name "C++/l") (string= mode-name "C/l"))
         (if (= (shell-command compile-command "*compilation*") 0)
             (let ((outbuffer
                    (concat "* Result of "
                            (file-name-sans-extension (file-name-nondirectory buffer-file-name))
                            " *"))
                   (run-command
                    (concat "./"
                            (file-name-sans-extension (file-name-nondirectory buffer-file-name))
                            "&"))
                   proc)
               (setq proc
                     (get-buffer-process (get-buffer-create outbuffer)))
               (if proc
                   (kill-process proc))
               (sleep-for 0 60)
               ;; (unless (get-buffer-window-list outbuffer)
               ;;     (list
               ;;      (message "test")
               ;;      (display-buffer outbuffer t (window-buffer (split-window-vertically))))))
               ;; ;; (keyboard-quit)
               (shell-command run-command outbuffer)
               (switch-to-buffer-other-window outbuffer))

           (let ((compilation-buffer "*compilation*"))
             (with-current-buffer compilation-buffer
               (display-buffer compilation-buffer)
               (compilation-mode))
             (switch-to-buffer-other-window compilation-buffer)
             (keyboard-quit))
           ))))


(global-set-key (kbd "<C-f7>") 'compile)
(global-set-key (kbd "<f7>") 'recompile)
(global-set-key (kbd "<f5>") 'my-run)

(provide 'bigeye-compile)
