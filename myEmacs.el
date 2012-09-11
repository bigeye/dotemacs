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

;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; IMPORTANT: For Emacs >= 23.2, you must place this *before* any
;; CEDET component (including EIEIO) gets activated by another 
;; package (Gnus, auth-source, ...).
(load-file (concat my-dotemacs-path "/.emacs.d/cedet/common/cedet.el"))

;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode,
;;   imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode,
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberant ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languages only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
;; (global-srecode-minor-mode 1)

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
(global-defkey "<M-SPC>" 'toggle-input-method)

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

;; (require 'rcirc)
;; (require 'rcirc-pounce)
;; (require 'rcirc-extension)
;; (setq rcirc-default-username "webirc-888")
;; (setq rcirc-default-full-name "webirc-888")
;; (setq rcirc-default-nick "webirc-888")
;; (setq rcirc-server-alist '(("irc.hanirc.org" :port 8080)))
;; (set-rcirc-decode-coding-system 'euc-kr)
;; (set-rcirc-encode-coding-system 'euc-kr)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ERC Settings ( IRC ) ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(erc-autojoin-mode t)
(setq erc-mode-line-format "%S %t")
(and
 (require 'erc-highlight-nicknames)
 (add-to-list 'erc-modules 'highlight-nicknames)
 (erc-update-modules))

;; check channels
;; (erc-track-mode t)
;; (setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"

;;                                  "324" "329" "332" "333" "353" "477"))
;; don't show any of this
;; (setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(load "~/.erc_accounts" t)

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ECB Settings           ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/ecb"))
(require 'ecb)

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
(set-face-background 'highlight "DarkOliveGreen1")
;; )

;; Turn on whitespace-mode
(global-whitespace-mode 1)
(setq whitespace-style
      (quote
       (face tabs spaces trailing lines space-before-tab newline indentation
             space-after-tab space-mark tab-mark)))
(setq whitespace-global-modes '(c-mode c++-mode python-mode php-mode java-mode jde-mode))
(add-hook 'jde-mode-hook
          (lambda ()
            (setq whitespace-line-column 100)))
(set-face-attribute 'whitespace-line nil
                    :background "peach puff"
                    :foreground "nil"
                    :weight 'bold)
(set-face-attribute 'whitespace-space-after-tab nil
                    :background "lemon chiffon")
(set-face-attribute 'whitespace-indentation nil
                    :background "lemon chiffon")

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

;;
;; Anything config
;;
(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/anything-config"))
(require 'anything-config)

(global-set-key (kbd "C-x b")
  (lambda() (interactive)
    (anything
     :prompt "Switch to: "
     :candidate-number-limit 10                 ;; up to 10 of each
     :sources
     '( anything-c-source-buffers               ;; buffers
        anything-c-source-recentf               ;; recent files
        anything-c-source-bookmarks             ;; bookmarks
        anything-c-source-files-in-current-dir+ ;; current dir
        anything-c-source-locate))))            ;; use 'locate'

;;;;;;;;;;;;;;;;;;;;;;
;;;     Jabber     ;;;
;;;;;;;;;;;;;;;;;;;;;;

(if (file-readable-p "~/.jabber_accounts")
  (progn
    ; Load personal accounts (setq jabber-account-list '(...) )
    ; (setq jabber-account-list '(
    ;                             ("username@gmail.com"
    ;                              (:password . "userpassword")
    ;                              (:network-server . "talk.google.com")
    ;                              (:port . 443)
    ;                              (:connection-type . ssl))
    ;                            )
    ; )
    (load-file "~/.jabber_accounts")
    (if (eq system-type 'darwin)
        (require 'hexrgb))

    (add-to-list 'load-path
                 (concat my-dotemacs-path "/.emacs.d/emacs-jabber-0.8.90"))
    (require 'jabber-autoloads)
    (add-to-list 'same-window-buffer-names "*-Jabber-*")
    (custom-set-variables
     ;; custom-set-variables was added by Custom.
     ;; If you edit it by hand, you could mess it up, so be careful.
     ;; Your init file should contain only one such instance.
     ;; If there is more than one, they won't work right.
     '(jabber-message-alert-same-buffer nil)
     '(jabber-auto-reconnect t)
     '(jabber-avatar-verbose nil)
     '(jabber-vcard-avatars-retrieve nil)
     '(jabber-chat-buffer-format "*-Jabber-%n-*")
     '(jabber-history-enabled t)
     '(jabber-mode-line-mode t)
     '(jabber-roster-buffer "*-Jabber-*")
     '(jabber-roster-line-format " %14s | %-23n(%j) %S")
     '(jabber-libnotify-method 'shell)
     '(jabber-show-offline-contacts nil)
     '(jabber-show-resources nil)
     '(jabber-roster-show-bindings nil)
     '(jabber-alert-presence-message-function (lambda (who oldstatus newstatus statustext) nil))
     '(jabber-roster-show-title nil))
    (if (/= 0 (length jabber-account-list))
        (jabber-connect-all))
    (global-set-key (kbd "C-x g") 'jabber-display-roster)
    )

  (defvar my-libnotify-program "/usr/bin/notify-send")
  (defun my-notify-send (title message)
    (start-process "notify" " notify"
                   my-libnotify-program "--expire-time=2500" title message))
  (defun my-jabber-libnotify-message (from buf text proposed-alert)
    "(jabber.el hook) Notify of new Jabber chat messages via libnotify"
    (when (or jabber-message-alert-same-buffer
              (not (memq (selected-window) (get-buffer-window-list buf))))
      (if (jabber-muc-sender-p from)
          (my-notify-send (format "(PM) %s"
                               (jabber-jid-displayname (jabber-jid-user from)))
                       (format "%s: %s" (jabber-jid-resource from) text)))
      (my-notify-send (format "%s" (jabber-jid-displayname from))
                   text)))
  (add-hook 'jabber-alert-message-hooks 'my-jabber-libnotify-message)
  )

;; (defvar libnotify-program "/usr/bin/notify-send")
;; (defun notify-send (title message)
;;   (start-process "notify" " notify"
;; 		 libnotify-program "--expire-time=4000" title message))
;; (defun libnotify-jabber-notify (from buf text proposed-alert)
;;   "(jabber.el hook) Notify of new Jabber chat messages via libnotify"
;;   (when (or jabber-message-alert-same-buffer
;;             (not (memq (selected-window) (get-buffer-window-list buf))))
;;     (if (jabber-muc-sender-p from)
;;         (notify-send (format "(PM) %s"
;;                        (jabber-jid-displayname (jabber-jid-user from)))
;;                (format "%s: %s" (jabber-jid-resource from) text)))
;;       (notify-send (format "%s" (jabber-jid-displayname from))
;;              text)))

;;;;;;;;;;;;;;;;;;;;
;;; Mac Settings ;;;
;;;;;;;;;;;;;;;;;;;;

(if (eq system-type 'darwin)
  (progn
    (setq mac-option-key-is-meta nil)
    (setq mac-command-key-is-meta t)
    (setq mac-command-modifier 'meta)
    (setq mac-option-modifier nil))
  )

(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "chromium-browser")

(if (file-readable-p "~/.gnus.el")
  (progn
    ;; (gnus)
    )
  )

(if (and (eq window-system 'x)
         (eq system-type 'gnu/linux))
    (progn
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                             '(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
      (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
                             '(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))))

(if (eq system-type 'gnu/linux)
    (if (daemonp)
        (progn
          (add-to-list 'default-frame-alist '(font . "Bitstream Vera Sans Mono"))
          (add-hook 'after-make-frame-functions
                    (lambda (frame)
                      (with-selected-frame frame
                        (set-fontset-font "fontset-default" '(#x1100 . #xffdc)
                                          '("UnBom" . "iso10646-1"))
                        (set-fontset-font "fontset-default" '(#xe0bc . #xf66e)
                                          '("UnBom" . "iso10646-1"))
                        )))
          )
      (set-face-font 'default "Bitstream Vera Sans Mono")
      (set-fontset-font "fontset-default" '(#x1100 . #xffdc)
                        '("UnBom" . "iso10646-1"))
      (set-fontset-font "fontset-default" '(#xe0bc . #xf66e)
                        '("UnBom" . "iso10646-1"))))

;; multi-term
(require 'multi-term)

;; (load "orgmode")

(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/android-mode"))
(require 'android-mode)
(if (eq system-type 'gnu/linux)
    (progn
      (setq android-mode-sdk-dir "/usr/local/android-sdk-linux")
      (add-to-list 'load-path (concat android-mode-sdk-dir "/tools/lib"))
      (require 'android)))
      
(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/restclient"))
(require 'restclient)

(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/less-css-mode"))
(require 'less-css-mode)

(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/slim-mode"))
(require 'slim-mode)

(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/coffee-mode"))
(require 'coffee-mode)

(defun coffee-custom ()
  "coffee-mode-hook"
  ;; CoffeeScript uses two spaces.
  (make-local-variable 'tab-width)
  (set 'tab-width 2))

(add-hook 'coffee-mode-hook 'coffee-custom)

(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/markdown-mode"))
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))
(setq markdown-command "Markdown.pl")

(add-to-list 'load-path (expand-file-name (concat my-dotemacs-path "/.emacs.d/jde/dist/jdee-2.4.1/lisp")))
(add-to-list 'load-path (expand-file-name (concat my-dotemacs-path "/.emacs.d/elib")))

(require 'jde)

(custom-set-variables
 '(jde-jdk (quote ("icedtea7")))
 '(jde-jdk-registry (quote (("sun-jdk-1.6.0.26" . "/opt/sun-jdk-1.6.0.26")
                            ("icedtea7" . "/usr/lib64/icedtea7")))))
;; (load "semantic/edit")
;; (add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/jde/dist/jdee-2.4.1/lisp"))
;; (require 'jde-autoload)

;; ;; (setenv "JAVA_HOME" "/usr/lib/jvm/icedtea-7")
;; ;; (setenv "CLASSPATH" ".")
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(jde-global-classpath (quote ("/usr/local/android-sdk-linux/platforms/android-8/android.jar")))
;;  '(jde-jdk-registry (quote (("IcedTea JDK 6.1.11.1" . "/usr/lib/jvm/icedtea-bin-6"))))
;;  '(jde-sourcepath (quote ("/usr/local/android-sdk-linux/sources/android-14")))

(add-to-list 'same-window-buffer-names "*Help*")

;;
;; ace jump mode major function
;; 
(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/ace-jump-mode"))
(autoload
  'ace-jump-mode
  "ace-jump-mode"
  "Emacs quick move minor mode"
  t)
;; you can select the key you prefer to
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)



;; 
;; enable a more powerful jump back function from ace jump mode
;;
(autoload
  'ace-jump-mode-pop-mark
  "ace-jump-mode"
  "Ace jump back:-)"
  t)
(eval-after-load "ace-jump-mode"
  '(ace-jump-mode-enable-mark-sync))
(define-key global-map (kbd "C-x SPC") 'ace-jump-mode-pop-mark)

;;
;; Expand region
;;
(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/expand-region"))
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)

;;
;; Iy-go-to-char
;;
(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/iy-go-to-char"))
(require 'iy-go-to-char)
(global-set-key (kbd "M-m") 'iy-go-to-char)

;;
;; Key Chord
;;
(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/key-chord"))
(require 'key-chord)
(key-chord-mode 1)

(key-chord-define-global "fg" 'iy-go-to-char)
(key-chord-define-global "df" 'iy-go-to-char-backward)

(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/mark-multiple"))
(require 'inline-string-rectangle)
(global-set-key (kbd "C-x r t") 'inline-string-rectangle)

(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)
(global-set-key (kbd "C-M-m") 'mark-more-like-this) ; like the other two, but takes an argument (negative is previous)
(global-set-key (kbd "C-*") 'mark-all-like-this)

(add-hook 'sgml-mode-hook
          (lambda ()
            (require 'rename-sgml-tag)
            (define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag)))

;;
;; Org-mode
;;

(add-to-list 'load-path (concat my-dotemacs-path "/.emacs.d/org-mode/lisp"))
(require 'org-install)
(setq org-default-notes-file "~/org/notes.org")

(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.org.gpg$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.ref$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.ref.gpg$" . org-mode))
(add-to-list 'auto-mode-alist '("\\.notes$" . org-mode))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-agenda-files '("~/org"))
(setq org-log-into-drawer t)
(setq org-todo-keywords
           '((sequence "TODO(t!)" "|" "DONE(d!)")
             (sequence "REPORT(r!)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f@/!)")
             (sequence "|" "CANCELED(c!)")))
(setq org-mobile-directory "~/org/mobileorg")
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/notes.org" "Tasks")
         "* TODO %?\n%T")
        ("m" "Movie" entry (file+headline "~/org/movie.org" "Movies")
         "* TODO %?\n%T\n:PROPERTIES:\n:DIRECTOR:\n:STARS:\n:RELEASE DATE:\n:RECOMMENDED BY:\n:END:" )))

(setq org-refile-targets '((nil :maxlevel . 2)
                           (org-agenda-files :maxlevel . 1)))