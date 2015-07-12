(setq
 dired-dwim-target t            ; if another Dired buffer is visibpple in another window, use that directory as target for Rename/Copy
 dired-recursive-copies 'always         ; "always" means no asking
 dired-recursive-deletes 'top           ; "top" means ask once for top level directory
 dired-listing-switches "-lha"          ; human-readable listing
 )

(require 'dired+)
(setq diredp-hide-details-initially-flag nil
      diredp-hide-details-propagate-flag nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; wdired allows you to edit a Dired buffer and write changes to disk
;; - Switch to Wdired by C-x C-q
;; - Edit the Dired buffer, i.e. change filenames
;; - Commit by C-c C-c, abort by C-c C-k
;; (require 'wdired)
;; (setq
;;  wdired-allow-to-change-permissions t   ; allow to edit permission bits
;;  wdired-allow-to-redirect-links     ; allow to edit symlinks
;;  )

(provide 'bigeye-dired)
