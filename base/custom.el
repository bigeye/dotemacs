;; customization
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(browse-url-browser-function (quote browse-url-generic))
 '(browse-url-generic-program "google-chrome")
 '(c-basic-offset 4 t)
 '(compilation-error-regexp-alist
   (quote
    (("\\[ERROR\\] \\(.+?\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\].*" 1 2 3)
     ("^\\(.*\\):\\[\\([0-9]*\\),\\([0-9]*\\)\\]" 1 2 3)
     absoft ada aix ant bash borland python-tracebacks-and-caml comma cucumber msft edg-1 edg-2 epc ftnchek iar ibm irix java jikes-file maven jikes-line gcc-include ruby-Test::Unit gnu lcc makepp mips-1 mips-2 msft omake oracle perl php rxp sparc-pascal-file sparc-pascal-line sparc-pascal-example sun sun-ada watcom 4bsd gcov-file gcov-header gcov-nomark gcov-called-line gcov-never-called perl--Pod::Checker perl--Test perl--Test2 perl--Test::Harness weblint)))
 '(default-input-method "korean-hangul")
 '(ede-project-directories (quote ("/home/bigeye/workspace/minicc")))
 '(fill-column 100)
 '(indent-tabs-mode nil)
 '(java-mode-hook
   (quote
    (er/add-cc-mode-expansions google-set-java-style
                               (lambda nil "Treat Java 1.5 @-style annotations as comments."
                                 (setq c-basic-offset 4)
                                 (setq c-comment-start-regexp "(@|/(/|[*][*]?))")
                                 (modify-syntax-entry 64 "< b" java-mode-syntax-table))
                               (lambda nil
                                 (setq whitespace-line-column 100)))) t)
 '(magit-use-overlays nil)
 '(package-selected-packages
   (quote
    (eclim expand-region ace-window avy json-mode helm-bind-key bind-key mark-multiple shell-pop rainbow-mode help-fns+ help+ discover-my-major info+ flycheck-tip flycheck vlf ztree dired+ ibuffer-vc undo-tree clean-aindent-mode smartparens volatile-highlights duplicate-thing magit yasnippet workgroups2 window-number slim-mode powerline mvn monokai-theme markdown-mode less-css-mode key-chord jabber iy-go-to-char helm-projectile helm-gtags glsl-mode function-args flx-ido erc-view-log erc-hl-nicks eproject emacs-eclim company-web company-irony company-go company-c-headers company-anaconda color-theme coffee-mode auto-complete android-mode ace-jump-mode)))
 '(projectile-ignored-projects
   (quote
    ("/usr/local/google/home/donghyun/twodroid/master/vendor/google_experimental/")))
 '(safe-local-variable-values
   (quote
    ((company-clang-arguments "-I/home/bigeye/workspace/tmp/tmux/")
     (company-clang-arguments "-I/home/bigeye/workspace/tmp/c-demo-project/include1/" "-I/home/bigeye/workspace/tmp/c-demo-project/include2/")
     (company-clang-arguments "-I/home/bigeye/workspace/tmp/c-demo-project/include/" "-I/home/bigeye/workspace/tmp/c-demo-project/include2/"))))
 '(same-window-buffer-names (quote ("*-Jabber-*" "*Help*")))
 '(select-enable-clipboard t)
 '(whitespace-line-column 100))


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
