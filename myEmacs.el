(setq my-dotemacs-path "~/dotemacs")
(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d"))
;; Set Env
(setenv "PATH"
  (concat
   "/usr/lib/android-sdk-linux_86/platform-tools" ":"
   "/usr/lib/android-sdk-linux_86/tools" ":"
   (getenv "PATH")
  )
)
;;Test Key Binding
(defmacro global-defkey (key def)
"*Bind KEY globally to DEF.
nKEY should be a string in the format used for saving keyboard
macros (cf. 'insert-kbd-macro')."
`(global-set-key (read-kbd-macro,key),def))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Input Method Settings ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;change input method to korean-hangul
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default-input-method "korean-hangul")
 '(ecb-options-version "2.40"))
(global-set-key (kbd "<Hangul>") 'toggle-input-method)

;;;;;;;;;;;;;;;;;;;;;;;
;;; Eshell Settings ;;;
;;;;;;;;;;;;;;;;;;;;;;;

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(setq-default ansi-color-names-vector
              ["black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" ])
(defun eshell/clear ()
  "Clears the shell buffer"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)))

(setq eshell-save-history-on-exit t)
(setq eshell-history-size 512)
(setq eshell-hist-ignoredups t)
(setq eshell-cmpl-cycle-completions nil)

;;;; C-a
;; from ZwaX at EmacsWiki
;; I use the following code. It makes C-a go to the beginning of the
;; command line, unless it is already there, in which case it goes to the
;; beginning of the line. So if you are at the end of the command line
;; and want to go to the real beginning of line, hit C-a twice:
(defun eshell-maybe-bol ()
  (interactive)
  (let ((p (point)))
    (eshell-bol)
    (if (= p (point))
        (beginning-of-line))))

(add-hook 'eshell-mode-hook
          '(lambda () (define-key eshell-mode-map "\C-a" 'eshell-maybe-bol)))

;; use ansi-term for these commands
(add-hook
 'eshell-first-time-mode-hook
 (lambda ()
   (setq eshell-visual-commands
         (append '("mutt" "vim" "screen" "ftp" "lftp" "telnet" "ssh" "tmux")
                 eshell-visual-commands))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Color-theme Settings ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/color-theme-6.6.0"))
(require 'color-theme)
(color-theme-initialize)
(color-theme-katester)
;(color-theme-feng-shui)

;;;;;;;;;;;;;;;;;;;;
;;; Ant Settings ;;;
;;;;;;;;;;;;;;;;;;;;

(defun file-search-upward (directory file)
  "search a file upward"
  (let* ((updir (file-truename (concat (file-name-directory directory) "../")))
	 (curfd   (if (not (string= (substring directory (- (length directory) 1)) "/"))
		      (concat directory "/" file)
		    (concat directory file))))
    (if (file-exists-p curfd)
	curfd
      (if (and (not (string= (file-truename directory) updir))
	       (< (length updir) (length (file-truename directory))))
	  (file-search-upward updir file)
	nil))))

(defun join-string-list (string-list)
    "Concatenates a list of strings
and puts spaces between the elements."
    (format "" "~{~A~^ ~}" string-list))

(defun ant-call (&optional args)
  "Call Ant's build.xml"
  (interactive "MAnt Target:")
;  (let ((oldbuf (get-buffer "*ant-compilation*")))
;    (if (not (null oldbuf))
;	(kill-buffer "*ant-compilation*")))
  (let* ((buildfile (file-search-upward (file-name-directory (buffer-file-name)) "build.xml"))
	 (outbuf (get-buffer-create "*ant-compilation*"))
	 (curbuf (current-buffer))
	 )
    (switch-to-buffer-other-window outbuf)
    (insert "#> ant -f " buildfile " " args "\n")
    (switch-to-buffer-other-window curbuf)
;    (call-process "ant" nil outbuf t "-f" buildfile 'args)))
    (shell-command (concat "ant -f " buildfile  " " args "&") outbuf)))
					;(mapconcat 'identity args " ") "&") outbuf)))
					; buildfile " " target))))


;;;;;;;;;;;;;;;;;;;;;;;;;
;;; System dependency ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;

(defsubst is-win ()
  (eq system-type 'windows-nt))
(defsubst is-linux ()
  (not (is-win)))
(defsubst my-linux-switch (:linux linux :win win)
  (cond ((is-linux) linux)
        ((is-win) win)))
(defconst console-p (eq (symbol-value 'window-system) nil)
  "Are we running in a console (non-X) environment?")



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
                    (concat (my-linux-switch :linux
                                             "./"
                                             :win
                                             "")
                            (file-name-sans-extension (file-name-nondirectory buffer-file-name))
                            (my-linux-switch :linux
                                             "&"
                                             :win
                                             ".exe&")))
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
           ))

        ((string= mode-name "Java/l")
         (ant-call "runserver"))))
                                        ;'("clean" "install" "launch")))))


(global-defkey "<C-f7>" 'compile)
(global-defkey "<f7>" 'recompile)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; JAVA mode Settings ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(require 'java-complete)
(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2)
                            (local-set-key (kbd "C-<tab>") 'java-complete)))

;;;;;;;;;;;;;;;;;;;;;;;
;;; C mode Settings ;;;
;;;;;;;;;;;;;;;;;;;;;;;

;(add-hook 'c-mode-common-hook (function cscope:hook))
(add-hook 'c-mode-common-hook 'my-c-mode)


(defun my-c-mode()
  "My c mode"
    (set (make-local-variable 'compile-command)
         (when buffer-file-name
           (concat (my-linux-switch :linux
                                    (cond ((string= mode-name "C++/l") "g++")
                                          ((string= mode-name "C/l") "gcc"))
                                    :win
                                    (cond ((string= mode-name "C++/l") "g++")
                                          ((string= mode-name "C/l") "gcc")))
                   " -O2 -lm "
                   (file-name-nondirectory buffer-file-name)
                   " -o "
                   (file-name-sans-extension
                    (file-name-nondirectory buffer-file-name))
                   (my-linux-switch :linux
                                    ""
                                    :win
                                    ".exe"))))
)



;;;;;;;;;;;;;;;;;;;;;;;;
;;; Icicles Settings ;;;
;;;;;;;;;;;;;;;;;;;;;;;;

(require 'icicles)
(icy-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Rcirc Settings ( IRC ) ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'rcirc)
(require 'rcirc-pounce)
(require 'rcirc-extension)
(setq rcirc-default-username "webirc-888")
(setq rcirc-default-full-name "webirc-888")
(setq rcirc-default-nick "webirc-888")
(setq rcirc-server-alist '(("irc.hanirc.org" :port 8080)))
(set-rcirc-decode-coding-system 'euc-kr)
(set-rcirc-encode-coding-system 'euc-kr)


;;;;;;;;;;;;;;;;;;;;
;;; GUD Settings ;;;
;;;;;;;;;;;;;;;;;;;;

(require 'gud);
(setq gdb-many-windows t)
(global-set-key [f5] 'my-run)
(global-set-key [f9] 'gud-break)
(global-set-key [(shift f9)] 'gud-remove)
(global-set-key [f10] 'gud-next)
(global-set-key [f11] 'gud-step)
(global-set-key [(shift f11)] 'gud-finish)
(global-set-key [(shift f10)] '(lambda ()
                                (interactive)
                                (call-interactively 'gud-tbreak)
                                (call-interactively 'gud-cont)))
(global-set-key (kbd "C-x C-a C-c") 'gud-cont)
(global-set-key (kbd "C-x C-a C-w") 'gud-watch)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; CEDET Settings(disabled) ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;;(load-file "~/.emacs.d/cedet/common/cedet.el")


;; Enable EDE (Project Management) features
;;(global-ede-mode 1) ;Turn on variable `ede-minor-mode' mode when arg
		    ;is positive.  If arg is negative, disable.
		    ;Toggle otherwise.

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
;;(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
;;(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languges only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

;;(require 'semantic-ia) 
;;(global-semanticdb-minor-mode 1)

;;(setq semanticdb-default-save-directory "~/.emacs.d/#semanticdb.cache#")

;;(semantic-add-system-include "/usr/include/" 'c-mode)
;;(semantic-add-system-include
;; "/usr/lib/gcc/x86_64-linux-gnu/4.4.3/include"
;; 'c-mode)
;;(semantic-add-system-include "/usr/include/" 'c++-mode)
;;(semantic-add-system-include
;; "/usr/lib/gcc/x86_64-linux-gnu/4.4.3/include"
;; 'c++-mode)
;(semantic-add-system-include
; "/usr/lib/gcc/i686-pc-linux-gnu/4.1.2/include/g++-v4/"
; 'c++-mode)

;;(global-set-key (kbd "<C-return>") 'semantic-ia-complete-symbol-menu)
;;(global-set-key (kbd "<C-S-return>") 'semantic-ia-complete-tip)
;;(global-set-key (kbd "C-c <C-return>") 'semantic-complete-analyze-inline)
;;(global-set-key (kbd "C-x <C-return>") 'semantic-analyze-possible-completions)
;;(global-set-key (kbd "RET") 'newline-and-indent)


"(global-set-key [(meta return)] 'senator-complete-symbol)

(global-set-key [(meta shift return)] 'complete-symbol)

(global-set-key [(control meta return)] 'ebrowse-tags-complete-symbol)"

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; YAsnippet settings ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/plugins/yasnippet-0.6.1c"))
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory (concat my-dotemacs-path "/.emacs.d/plugins/yasnippet-0.6.1c/snippets"))


;;;;;;;;;;;;;;;;;;;;;;;
;; auto-complete 1.3 ;;
;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat my-dotemacs-path "/.emacs.d//ac-dict"))
(ac-config-default)
(set-face-background 'ac-selection-face "steelblue")


;;;;(require 'highlight-current-line)
;;;;(highlight-current-line-on t)
;;;;(setq highlight-current-line-ignore-regexp nil)


;;(highlight-current-line-on t)
;; To customize the background color
;;(set-face-background 'highlight-current-line-face "blue")

;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;; ECB Settings(disabled) ;;;
;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; "(add-to-list 'load-path './.emacs.d/ecb-2.40')
;; (load-file './.emacs.d/ecb-2.40/ecb.el')
;; (require 'ecb)
;; (ecb-activate)"


;;;;;;;;;;;;;;;;;;;;;;
;;; Other Settings ;;;
;;;;;;;;;;;;;;;;;;;;;;
(windmove-default-keybindings 'meta)

(defun previous-window ()
  (interactive)
  (other-window -1)
)

(defun reload-dotemacs ()
  "Reload .emacs"
  (interactive)
  (load-file (concat my-dotemacs-path "/myEmacs.el"))
)

;; Highlight the current line
;; (when (not console-p)
(global-hl-line-mode 1)
(set-face-background 'highlight "#fff")
;; )

;; Turn on whitespace-mode
(global-whitespace-mode 1)
(setq whitespace-style
      (quote
       (face tabs spaces trailing lines space-before-tab newline indentation
             empty space-after-tab space-mark tab-mark)))

; If non-nil, `kill-line' with no arg at beg of line kills the whole line.
;(setq kill-whole-line nil)

; Do not show startup message
; Non-nil inhibits the startup screen.
;(setq inhibit-startup-message t)

;;;;;;;;;;;;;;;;;;;;;;;
;;; Multiple Eshell ;;;
;;;;;;;;;;;;;;;;;;;;;;;
;; (require 'multi-eshell)


;;;;;;;;;;;;;;;;;;;
;;; Key Binding ;;;
;;;;;;;;;;;;;;;;;;;

(global-defkey "<f3>" 'comment-dwim)
(global-defkey "<C-f5>" 'reload-dotemacs)
;(global-defkey "<C-tab>" 'other-window)
(global-defkey "<backtab>" 'previous-window)
(global-defkey "<RET>" 'newline-and-indent)
(global-defkey "C-x C-b" 'buffer-menu)

(setq-default indent-tabs-mode nil)

(set-variable 'x-select-enable-clipboard t) ;; Make cutting and pasting uses the clipboard


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; Python mode setting ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-hook 'python-mode-hook (lambda ()
                              (setq python-indent 2)))
;;; Line Number
;;; show line number the cursor is on, in status bar (the mode line)
;;; set 1 by default
;;; (line-number-mode 1)
(global-linum-mode 1)

;; Column Number
(column-number-mode 1)

;; Don't make backup~ file
(setq make-backup-files nil)

;; Disable Menu Bar
(menu-bar-mode -1)

;; Disable Tool Bar
(tool-bar-mode -1)

;; scroll one line at a time (less "jumpy" than defaults)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time

(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling

(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

(setq scroll-step 1) ;; keyboard scroll one line at a time

(setq scroll-conservatively 10000)


;; (defun point-of-beginning-of-bottom-line ()
;;   (save-excursion
;;     (move-to-window-line -1)
;;     (point)))

;; (defun point-of-beginning-of-line ()
;;   (save-excursion
;;     (beginning-of-line)
;;     (point)))

;; (defun next-one-line () (interactive)
;;   (if (= (point-of-beginning-of-bottom-line) (point-of-beginning-of-line))
;;       (progn (scroll-up 1)
;;              (next-line 1))
;;     (next-line 1)))

;; (defun point-of-beginning-of-top-line ()
;;   (save-excursion
;;     (move-to-window-line 0)
;;     (point)))

;; (defun previous-one-line () (interactive)
;;   (if (= (point-of-beginning-of-top-line) (point-of-beginning-of-line))
;;       (progn (scroll-down 1)
;;              (previous-line 1))
;;     (previous-line 1)))

;; (global-set-key (kbd "<C-n>") 'next-one-line)
;; (global-set-key (kbd "<C-p>") 'previous-one-line)

;;;;;;;;;;;;;;;;;;;;;
;;;; CSharp Mode ;;;;
;;;;;;;;;;;;;;;;;;;;;

;; (require 'csharp-mode)

;; (setq auto-mode-alist
;;       (append '(("\\.cs$" . csharp-mode)) auto-mode-alist))
;; (defun my-csharp-mode-fn ()
;;   "function that runs when csharp-mode is initialized for a buffer."
;;   (local-set-key "\M-\\"   'cscomp-complete-at-point)
;;   (local-set-key "\M-\."   'cscomp-complete-at-point-menu)
;; )
;; (add-hook  'csharp-mode-hook 'my-csharp-mode-fn t)

;; (add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/cedet/semantic"))
;; (add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/cedet/semantic/bovine"))
;; (add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/cedet/common"))
;; (add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/cedet/eieio"))
;; (add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/cedet/contrib"))

;; (load "semantic")
;; (load "semantic-load")
;; (load "wisent-csharp")

;; (require 'csharp-completion)

;; (setq erc-default-coding-system 'euc-kr)
;; (setq erc-encoding-coding-alist '(
;;                                     ("#gnome" . euc-kr)
;;                                     ("irc.hanirc.org" . euc-kr)
;;                                      ))



;;;;;;;;;;;;
;; Indent ;;
;;;;;;;;;;;;

;; (setq-default c-basic-offset 2
;;               js-indent-level 2
;;               css-indent-offset 2
;;               mumamo-submode-indent-offset 2
;;               tab-width 2)

;; (setq-default indent-tabs-mode nil)

(defun pear/php-mode-init()
  "Set some buffer-local variables."
  (setq case-fold-search t)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close '0)
)

(add-hook 'php-mode-hook 'pear/php-mode-init)


;; ;;;;;;;;;;;;
;; ;; NXHTML ;;
;; ;;;;;;;;;;;;

;; (load (concat my-dotemacs-path "/.emacs.d/nxhtml/autostart.el"))
(require 'nxml-mode)
(setq mumamo-background-colors nil)
(add-hook 'nxml-mode-hook
          (lambda ()
            (rng-validate-mode 0))
          t)


;; ;;;;;;;;;;;;;;
;; ;; PHP Mode ;;
;; ;;;;;;;;;;;;;;
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.ctp\\'" . nxhtml-mumamo-mode))
;; (add-to-list 'auto-mode-alist '("\\.php?\\'" . php-mode))


;; ;;;;;;;;;;;;;;;;;
;; ;;; Haml Mode ;;;
;; ;;;;;;;;;;;;;;;;;

(require 'haml-mode)

(add-hook 'haml-mode-hook
          '(lambda ()
             (setq indent-tabs-mode nil)
             (define-key haml-mode-map "\C-m" 'newline-and-indent)))

;;;;;;;;;;;;;;;;;;;;;;
;; ELIM (IM Client) ;;
;;;;;;;;;;;;;;;;;;;;;;

;; (add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/elim/elisp"))
;; (autoload 'garak "garak" nil t)
;; (setq tree-widget-image-enable t)


;;;;;;;
;;; hexrgb (only for mac)
;;;;;

(require 'hexrgb)

;;;;;;;;;;;;;;;;;;;;;
;; Jabber
;;;;;;;;;;

(add-to-list 'load-path
             (concat my-dotemacs-path "/.emacs.d/emacs-jabber-0.8.90"))
(require 'jabber-autoloads)

(setq jabber-account-list '(
                            ("bigeyeguy@gmail.com"
                             (:password . "dj4067cg*")
                             (:network-server . "talk.google.com")
                             (:port . 443)
                             (:connection-type . ssl))
                            ("bigeye@adby.me"
                             (:password . "dong0811")
                             (:network-server . "talk.google.com")
                             (:port . 443)
                             (:connection-type . ssl))
                            ))






























































(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(jabber-auto-reconnect t)
 '(jabber-avatar-verbose nil)
 '(jabber-vcard-avatars-retrieve nil)
 '(jabber-chat-buffer-format "*-Jabber-%n-*")
 '(jabber-history-enabled t)
 '(jabber-mode-line-mode t)
 '(jabber-roster-buffer "*-Jabber-*")
 '(jabber-roster-line-format " %c %-25n %u %-8s (%r)")
 '(jabber-show-offline-contacts nil)
 '(jabber-show-resources nil)
 '(jabber-roster-show-bindings nil)
 '(jabber-roster-show-title nil))

(if (eq system-type 'darwin)
  (progn
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil))
  )