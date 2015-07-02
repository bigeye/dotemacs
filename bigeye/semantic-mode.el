(semantic-mode 1)

(defun bigeye/add-semantic-to-autocomplete()
  (add-to-list 'ac-sources 'ac-source-semantic)
  )
(add-hook 'c-mode-common-hook 'bigeye/add-semantic-to-autocomplete)

