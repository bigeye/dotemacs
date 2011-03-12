;;;TODO(donghyun): make graphic mode in eshell using minjhong's dot emacs file

(add-to-list 'load-path "./.emacs.d")
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
(setq-default ansi-color-names-vector ["black" "red" "green" "yellow" "blue" "magenta" "cyan" "white" ] )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Color-theme Settings ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "./.emacs.d/color-theme-6.6.0")
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
	(shell-command compile-command)
	(shell-command (concat (my-linux-switch :linux
						"./"
						:win
						"")
			       (file-name-sans-extension (file-name-nondirectory buffer-file-name))
			       (my-linux-switch :linux
						"&"
						:win
						".exe&"))))
	((string= mode-name "Java/l") (ant-call "runserver"))))
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
		   (file-name-sans-extension (file-name-nondirectory buffer-file-name))
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
(add-to-list 'load-path "./.emacs.d/plugins/yasnippet-0.6.1c")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "./.emacs.d/plugins/yasnippet-0.6.1c/snippets")


;;;;;;;;;;;;;;;;;;;;;;;
;; auto-complete 1.3 ;;
;;;;;;;;;;;;;;;;;;;;;;;
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "./.emacs.d//ac-dict")
(ac-config-default)
(set-face-background 'ac-selection-face "steelblue")


;;;;(require 'highlight-current-line)
;;;;(highlight-current-line-on t)
;;;;(setq highlight-current-line-ignore-regexp nil)


;;(highlight-current-line-on t)
;; To customize the background color
;;(set-face-background 'highlight-current-line-face "blue")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; ECB Settings(disabled) ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

"(add-to-list 'load-path './.emacs.d/ecb-2.40')
(load-file './.emacs.d/ecb-2.40/ecb.el')
(require 'ecb)
(ecb-activate)"


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
  (load-file "./.emacs")
)

;; Highlight the current line
(when (not console-p) 
  (global-hl-line-mode 1)
  (set-face-background 'highlight "#fff")
)


; If non-nil, `kill-line' with no arg at beg of line kills the whole line.
;(setq kill-whole-line nil)

; Do not show startup message
; Non-nil inhibits the startup screen.
;(setq inhibit-startup-message t)

;;;;;;;;;;;;;;;;;;;;;;;
;;; Multiple Eshell ;;;
;;;;;;;;;;;;;;;;;;;;;;;
(require 'multi-eshell)


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
