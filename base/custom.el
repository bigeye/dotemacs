;; customization
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "google-chrome")
 '(compilation-error-regexp-alist (quote (("\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*" 1 2 3) ("^\\(.*\\):\\[\\([0-9]*\\),\\([0-9]*\\)\\]" 1 2 3) absoft ada aix ant bash borland python-tracebacks-and-caml comma cucumber msft edg-1 edg-2 epc ftnchek iar ibm irix java jikes-file maven jikes-line gcc-include ruby-Test::Unit gnu lcc makepp mips-1 mips-2 msft omake oracle perl php rxp sparc-pascal-file sparc-pascal-line sparc-pascal-example sun sun-ada watcom 4bsd gcov-file gcov-header gcov-nomark gcov-called-line gcov-never-called perl--Pod::Checker perl--Test perl--Test2 perl--Test::Harness weblint)))
 '(default-input-method "korean-hangul")
 '(ede-project-directories (quote ("/home/bigeye/workspace/minicc")))
 '(safe-local-variable-values (quote ((company-clang-arguments "-I/home/bigeye/workspace/tmp/tmux/") (company-clang-arguments "-I/home/bigeye/workspace/tmp/c-demo-project/include1/" "-I/home/bigeye/workspace/tmp/c-demo-project/include2/") (company-clang-arguments "-I/home/bigeye/workspace/tmp/c-demo-project/include/" "-I/home/bigeye/workspace/tmp/c-demo-project/include2/"))))
 '(same-window-buffer-names (quote ("*-Jabber-*" "*Help*")))
 '(x-select-enable-clipboard t))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; (add-to-list 'compilation-error-regexp-alist
;;              'maven)
;; (add-to-list 'compilation-error-regexp-alist-alist
;;        '(maven "\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*"
;;            1 2 3))
;; Don't know why it doesn't work
;; (add-hook 'eclim-mode-hook (lambda ()
;;                              (add-to-list 'compilation-error-regexp-alist '("\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*"
;;                                                                             1 2 3))))

(provide 'bigeye-custom)
