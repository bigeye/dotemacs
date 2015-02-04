(if (eq system-type 'gnu/linux)
    (if (daemonp)
        (progn
          (add-to-list 'default-frame-alist '(font . "Bitstream Vera Sans Mono"))
          (add-hook 'after-make-frame-functions
                    (lambda (frame)
                      (with-selected-frame frame
                        (set-fontset-font "fontset-default" '(#x1100 . #xffdc)
                                          '("NanumGothic" . "iso10646-1"))
                        (set-fontset-font "fontset-default" '(#xe0bc . #xf66e)
                                          '("NanumGothic" . "iso10646-1"))
                        )))
          )
      (set-face-font 'default "Bitstream Vera Sans Mono")
      (set-fontset-font "fontset-default" '(#x1100 . #xffdc)
                        '("NanumGothic" . "iso10646-1"))
      (set-fontset-font "fontset-default" '(#xe0bc . #xf66e)
                        '("NanumGothic" . "iso10646-1"))))
