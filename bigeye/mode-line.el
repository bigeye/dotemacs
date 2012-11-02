(setq mode-line-position
      '(
        (window-number-mode (:eval (window-number-string)))
        #(" " 0 1
          (help-echo "mouse-1: Select (drag to resize)\nmouse-2: Make current window occupy the whole frame\nmouse-3: Remove current window from display"))
        (size-indication-mode
         (8
          #(" of %I" 0 6
            (help-echo "Size indication mode\nmouse-1: Display Line and Column Mode Menu" mouse-face mode-line-highlight local-map
                       (keymap
                        (mode-line keymap
                                   (down-mouse-1 keymap
                                                 (column-number-mode menu-item "Display Column Numbers" column-number-mode :help "Toggle displaying column numbers in the mode-line" :button
                                                                     (:toggle . column-number-mode))
                                                 (line-number-mode menu-item "Display Line Numbers" line-number-mode :help "Toggle displaying line numbers in the mode-line" :button
                                                                   (:toggle . line-number-mode))
                                                 "Toggle Line and Column Number Display")))))))
        (line-number-mode
         ((column-number-mode
           (10
            #(" (%l,%c)" 0 8
              (help-echo "Line number and Column number\nmouse-1: Display Line and Column Mode Menu" mouse-face mode-line-highlight local-map
                         (keymap
                          (mode-line keymap
                                     (down-mouse-1 keymap
                                                   (column-number-mode menu-item "Display Column Numbers" column-number-mode :help "Toggle displaying column numbers in the mode-line" :button
                                                                       (:toggle . column-number-mode))
                                                   (line-number-mode menu-item "Display Line Numbers" line-number-mode :help "Toggle displaying line numbers in the mode-line" :button
                                                                     (:toggle . line-number-mode))
                                                   "Toggle Line and Column Number Display"))))))
           (6
            #(" L%l" 0 4
              (help-echo "Line Number\nmouse-1: Display Line and Column Mode Menu" mouse-face mode-line-highlight local-map
                         (keymap
                          (mode-line keymap
                                     (down-mouse-1 keymap
                                                   (column-number-mode menu-item "Display Column Numbers" column-number-mode :help "Toggle displaying column numbers in the mode-line" :button
                                                                       (:toggle . column-number-mode))
                                                   (line-number-mode menu-item "Display Line Numbers" line-number-mode :help "Toggle displaying line numbers in the mode-line" :button
                                                                     (:toggle . line-number-mode))
                                                   "Toggle Line and Column Number Display"))))))))
         ((column-number-mode
           (5
            #(" C%c" 0 4
              (help-echo "Column number\nmouse-1: Display Line and Column Mode Menu" mouse-face mode-line-highlight local-map
                         (keymap
                          (mode-line keymap
                                     (down-mouse-1 keymap
                                                   (column-number-mode menu-item "Display Column Numbers" column-number-mode :help "Toggle displaying column numbers in the mode-line" :button
                                                                       (:toggle . column-number-mode))
                                                   (line-number-mode menu-item "Display Line Numbers" line-number-mode :help "Toggle displaying line numbers in the mode-line" :button
                                                                     (:toggle . line-number-mode))
                                                   "Toggle Line and Column Number Display")))))))))))
