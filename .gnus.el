(setq gnus-select-method '(nnimap "gmail"
                                  (nnimap-address "imap.gmail.com")
                                  (nnimap-server-port 993)
                                  (nnimap-stream ssl))
      message-send-mail-function 'smtpmail-send-it
      smtpmail-starttls-credentials '(("smtp.gmail.com" 587 nil nil))
      smtpmail-auth-credentials '(("smtp.gmail.com" 587 "bigeyeguy@gmail.com" nil))
      smtpmail-default-smtp-server "smtp.gmail.com"
      smtpmail-smtp-server "smtp.gmail.com"
      smtpmail-smtp-service 587

      gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]"
      mm-discouraged-alternatives '("text/html" "text/richtext")
      browse-url-generic-program "/usr/bin/chroimum"
      mm-text-html-renderer nil
      browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser"
      mm-discouraged-alternatives '("text/html" "text/richtext")
      mm-discouraged-alternatives '("text/html" "image/.*")
      mm-automatic-display (remove "text/html" mm-automatic-display)
      gnus-buttonized-mime-types '("multipart/alternative" "multipart/signed")
      gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B%s%)\n"
      gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
      gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
      gnus-thread-sort-functions '(gnus-thread-sort-by-recent-date)
      gnus-sum-thread-tree-false-root ""
      gnus-sum-thread-tree-indent " "
      gnus-sum-thread-tree-leaf-with-other "├► "
      gnus-sum-thread-tree-root ""
      gnus-sum-thread-tree-single-leaf "╰► "
      gnus-sum-thread-tree-vertical "│"

      gnus-always-read-dribble-file t
)

(add-to-list 'gnus-secondary-select-methods '(nntp "news.gmane.org"))
