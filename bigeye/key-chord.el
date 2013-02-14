;;
;; Key Chord
;;
(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/key-chord"))
(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "fg" 'iy-go-to-char)
(key-chord-define-global "df" 'iy-go-to-char-backward)