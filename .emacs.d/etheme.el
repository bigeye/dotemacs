;;; etheme.el --- Theme support in emacs

;;;
;;; Copyright (C) 2005  Seong-Kook Shin <cinsky@gmail.com>
;;;

;;; This program is free software; you can redistribute it and/or modify
;;; it under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 2 of the License, or
;;; (at your option) any later version.
;;;
;;; This program is distributed in the hope that it will be useful,
;;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with this program; if not, write to the Free Software
;;; Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
;;;

;;;
;;; $Id: etheme.el,v 1.5 2005/06/24 23:59:40 cinsk Exp $
;;;

(eval-when-compile
  (require 'cl))

(defgroup etheme nil
  "Provide alternative theme-style face color configuration"
  :version "22.0"
  :group 'Faces)

(defvar etheme-current-theme
  nil
  "Current theme name")

(defvar etheme-set-theme-hook
  nil
  "Hook function called before applying any theme.")

(defvar etheme-alist
  '(("cinsk" 1) 
    ("vim" 2) 
    ("elflord" 3)
    ("morning" 4)
    ("canyon" 5)
    ("blue" 6)
    ("darkblue" 7)
    ("desert" 8)
    )
  "Installed etheme name alist")

;;;
;;; Default values of White on Black
;;; 
;;; modeline black on grey75
;;; modeline-inactive grey80 on grey30
;;; isearch brown4 on palevioletred2
;;; font-lock-comment-face chocolate1 on unspecified
;;; font-lock-constant-face Aquamarine on unspecified
;;; font-lock-type-face PaleGreen on unspecified
;;; font-lock-variable-name-face LightGoldenrod on unspecified
;;; font-lock-function-name-face LightSkyBlue on unspecified
;;; font-lock-preprocessor-face unspecified on unspecified
;;; font-lock-string-face LightSalmon on unspecified
;;; font-lock-keyword-face Cyan1 on unspecified
;;; 

;;;
;;; Default values of Black on White
;;; 
;;; modeline black on grey75
;;; modeline-inactive grey20 on grey90
;;; isearch lightskyblue1 on magenta2
;;; font-lock-comment-face firebrick on unspecified
;;; font-lock-constant-face CadetBlue on unspecified
;;; font-lock-type-face ForestGreen on unspecified
;;; font-lock-variable-name-face DarkGoldenrod on unspecified
;;; font-lock-function-name-face Blue1 on unspecified
;;; font-lock-preprocessor-face unspecified on unspecified
;;; font-lock-string-face RosyBrown on unspecified
;;; font-lock-keyword-face Purple on unspecified
;;; 

;;;
;;; DO NOT SET ANY ATTRIBUTE ON THESE FACES.
;;;
;;;  font-lock-comment-delimiter-face unspecified on unspecified
;;;  font-lock-doc-face unspecified on unspecified
;;;  font-lock-negation-char-face unspecified on unspecified
;;;  font-lock-regexp-backslash unspecified on unspecified
;;;  font-lock-regexp-backslash-construct unspecified on unspecified
;;;  font-lock-warning-face Red1 on unspecified

(defvar etheme-saved-face-list
  '(modeline 
    modeline-inactive
    isearch
    font-lock-builtin-face
    font-lock-comment-face
    font-lock-constant-face
    font-lock-type-face
    font-lock-variable-name-face
    font-lock-function-name-face
    font-lock-preprocessor-face
    font-lock-string-face
    font-lock-keyword-face)
  "List of face names which will be stored between theme change."
  )

	     
(defvar etheme-cinsk-faces
  '((default :foreground "powder blue" :background "black")
    (modeline :foreground "white" :background "IndianRed4")
    (modeline-inactive :foreground "grey80" :background "gray30")
    (isearch :foreground "brown4" :background "palevioletred2")
    ;; (font-lock-builtin-face :foreground "DarkGoldenrod4")
    (font-lock-comment-face :foreground "chocolate1")
    (font-lock-constant-face :foreground "Aquamarine")
    (font-lock-type-face :foreground "PaleGreen")
    (font-lock-variable-name-face :foreground "LightGoldenrod")
    (font-lock-function-name-face :foreground "LightSkyBlue")
    (font-lock-preprocessor-face :foreground unspecified)
    (font-lock-string-face :foreground "LightSalmon")
    (font-lock-keyword-face :foreground "Cyan1"))
  "cinsk style face attribute set")

(defvar etheme-cinsk-hook
  nil
  "Hook for cinsk theme")

(defvar etheme-canyon-faces
  '((default :foreground "grey30" :background "NavajoWhite2")
    (modeline :foreground "grey90" :background "chocolate2")
    (modeline-inactive :foreground "grey80" :background "chocolate4")
    (isearch :foreground "brown4" :background "palevioletred2")
    (font-lock-builtin-face :foreground "DarkGoldenrod4")
    (font-lock-comment-face :foreground "Firebrick")
    (font-lock-constant-face :foreground "purple4")
    (font-lock-type-face :foreground "aquamarine4")
    (font-lock-variable-name-face :foreground "cyan4")
    (font-lock-function-name-face :foreground "green4")
    (font-lock-preprocessor-face :foreground "IndianRed3")
    (font-lock-string-face :foreground "HotPink4")
    (font-lock-keyword-face :foreground "DarkOrange4")))

(defvar etheme-canyon-hook
  nil
  "Hook for canyon theme")

(defvar etheme-vim-faces
  '((default :foreground "gray" :background "black")
    (modeline :foreground "black" :background "gray75")
    (modeline-inactive :foreground "grey80" :background "gray30")
    (isearch :foreground "brown4" :background "palevioletred2")
    ;; (font-lock-builtin-face :foreground "DarkGoldenrod4")
    (font-lock-comment-face :foreground "RoyalBlue")
    (font-lock-constant-face :foreground "Aquamarine")
    (font-lock-type-face :foreground "green")
    (font-lock-variable-name-face :foreground "LightGoldenrod")
    (font-lock-function-name-face :foreground "LightSkyBlue")
    (font-lock-preprocessor-face :foreground "magenta")
    (font-lock-string-face :foreground "red")
    (font-lock-keyword-face :foreground "DarkOrange2"))
  "graphical version of vim style face attribute set")

(defvar etheme-vim-hook
  nil
  "Hook for vim theme")

(defvar etheme-elflord-faces
  '((default :foreground "cyan" :background "black")
    (modeline :foreground "black" :background "gray75")
    (modeline-inactive :foreground "grey80" :background "gray30")
    (isearch :foreground "brown4" :background "palevioletred2")
    ;; (font-lock-builtin-face :foreground "DarkGoldenrod4")
    (font-lock-comment-face :foreground "#80a0ff")
    (font-lock-constant-face :foreground "magenta")
    (font-lock-type-face :foreground "#60ff60")
    (font-lock-variable-name-face :foreground "#40ffff")
    (font-lock-function-name-face :foreground "white")
    (font-lock-preprocessor-face :foreground "#ff80ff")
    (font-lock-string-face :foreground "magenta")
    (font-lock-keyword-face :foreground "#aa4444"))
  "vim elflord-like face attribute set")

(defvar etheme-elflord-hook
  nil
  "Hook for elflord theme")

(defvar etheme-morning-faces
  '((default :foreground "black" :background "grey90")
    (modeline :foreground unspecified :background "LightBlue1")
    (modeline-inactive :foreground unspecified :background "LightBlue3")
    (isearch :foreground unspecified :background "yellow")
    ;; (font-lock-builtin-face :foreground "DarkGoldenrod4")
    (font-lock-comment-face :foreground "blue")
    (font-lock-constant-face :foreground "magenta")
    (font-lock-type-face :foreground "forest green")
    (font-lock-variable-name-face :foreground "blue4")
    (font-lock-function-name-face :foreground "sienna4")
    (font-lock-preprocessor-face :foreground "DarkViolet")
    (font-lock-string-face :foreground "magenta")
    (font-lock-keyword-face :foreground "SlateBlue"))
  "vim morning-like face attribute set")

(defvar etheme-morning-hook
  nil
  "Hook for morning theme")

(defvar etheme-blue-faces
  '((default :foreground "white" :background "navy")
    (modeline :foreground "black" :background "deep sky blue")
    (modeline-inactive :foreground "grey60" :background "navy")
    (isearch :foreground unspecified :background "yellow")
    (font-lock-builtin-face :foreground "yellow")
    (font-lock-comment-face :foreground "LightGrey")
    (font-lock-constant-face :foreground "cyan")
    (font-lock-type-face :foreground "yellow")
    (font-lock-variable-name-face :foreground "burlywood")
    (font-lock-function-name-face :foreground "beige")
    (font-lock-preprocessor-face :foreground "green")
    (font-lock-string-face :foreground "cyan")
    (font-lock-keyword-face :foreground "tomato"))
  "vim morning-like face attribute set")

(defvar etheme-blue-hook
  nil
  "Hook for blue theme")

(defvar etheme-darkblue-faces
  '((default :foreground "LightGrey" :background "#000040")
    (modeline :foreground "black" :background "deep sky blue")
    (modeline-inactive :foreground "grey60" :background "navy")
    (isearch :foreground unspecified :background "yellow")
    (font-lock-builtin-face :foreground "yellow")
    (font-lock-comment-face :foreground "#80a0ff")
    (font-lock-constant-face :foreground "cyan")
    (font-lock-type-face :foreground "#60ff60")
    (font-lock-variable-name-face :foreground "#40ffff")
    (font-lock-function-name-face :foreground "beige")
    (font-lock-preprocessor-face :foreground "#ff80ff")
    (font-lock-string-face :foreground "#ffa0a0")
    (font-lock-keyword-face :foreground "green"))
  "vim morning-like face attribute set")

(defvar etheme-darkblue-hook
  nil
  "Hook for darkblue theme")

(defvar etheme-desert-faces
  '((default :foreground "white" :background "grey20")
    (modeline :foreground "black" :background "deep sky blue")
    (modeline-inactive :foreground "grey20" :background "#c2bfa5")
    (isearch :foreground "slategrey" :background "khaki")
    (font-lock-builtin-face :foreground "yellow")
    (font-lock-comment-face :foreground "SkyBlue")
    (font-lock-constant-face :foreground "#ffa0a0")
    (font-lock-type-face :foreground "darkkhaki")
    (font-lock-variable-name-face :foreground "palegreen")
    (font-lock-function-name-face :foreground "beige")
    (font-lock-preprocessor-face :foreground "indianred")
    (font-lock-string-face :foreground "#ffa0a0")
    (font-lock-keyword-face :foreground "navajowhite"))
  "vim morning-like face attribute set")

(defvar etheme-desert-hook
  nil
  "Hook for darkblue theme")


(defun etheme-set-faces (theme)
  "Set the given face attribute set THEME"
  (mapcar #'(lambda (arg)
	    (apply #'set-face-attribute
		   (append (list (car arg) nil) (cdr arg))))
	theme))

(defun etheme-run-hook (theme-name)
  "Run THEME-NAME hook"
  (let ((hook-name (intern (concat "etheme-" theme-name "-hook"))))
    (run-hooks hook-name)))

(defun etheme-add-hook (theme-name function &optional append)
  "Add FUNCTION to the THEME-NAME hook"
  (let ((hook-name (intern (concat "etheme-" theme-name "-hook"))))
    (add-hook hook-name function append)))

(defun etheme-apply-theme (theme-name)
  "Set the current theme to THEME-NAME"
  (if (stringp theme-name)
      (let ((faces (eval (intern (concat "etheme-" theme-name "-faces")))))
	(setq etheme-current-theme theme-name)
	(etheme-run-hook theme-name)
	(etheme-set-faces faces)
	)))

(defun etheme-set-theme (theme-name)
  "Set the current theme to THEME-NAME"
  (interactive "P")
  (global-font-lock-mode 1)
  (let ((name theme-name))
    (if (stringp name)
	(etheme-apply-theme name)
      (progn (etheme-apply-theme 
	      (setq name (completing-read "theme name: "
					  etheme-alist nil t "")))
	     (message "etheme: %s selected" name)))))

(etheme-add-hook "vim" 'menu-bar-right-scroll-bar)
(etheme-add-hook "vim" '(lambda () (tool-bar-mode 1)))
(etheme-add-hook "vim" '(lambda () (set-cursor-color "white")))
(etheme-add-hook "vim" '(lambda () (set-mouse-color "white")))

(etheme-add-hook "morning" 'menu-bar-right-scroll-bar)
(etheme-add-hook "morning" '(lambda () (tool-bar-mode 1)))
(etheme-add-hook "morning" '(lambda () (set-cursor-color "plum4")))
(etheme-add-hook "morning" '(lambda () (set-mouse-color "blue4")))

(etheme-add-hook "elflord" 'menu-bar-right-scroll-bar)
(etheme-add-hook "elflord" '(lambda () (tool-bar-mode 1)))
(etheme-add-hook "elflord" '(lambda () (set-cursor-color "white")))
(etheme-add-hook "elflord" '(lambda () (set-mouse-color "white")))

(etheme-add-hook "cinsk" 'menu-bar-left-scroll-bar)
(etheme-add-hook "cinsk" '(lambda () (tool-bar-mode -1)))
(etheme-add-hook "cinsk" '(lambda () (set-cursor-color "white")))
(etheme-add-hook "cinsk" '(lambda () (set-mouse-color "white")))

(etheme-add-hook "canyon" 'menu-bar-left-scroll-bar)
(etheme-add-hook "canyon" '(lambda () (tool-bar-mode 1)))
(etheme-add-hook "canyon" '(lambda () (set-cursor-color "plum4")))
(etheme-add-hook "canyon" '(lambda () (set-mouse-color "blue4")))

(etheme-add-hook "blue" 'menu-bar-right-scroll-bar)
(etheme-add-hook "blue" '(lambda () (tool-bar-mode -1)))
(etheme-add-hook "blue" '(lambda () (set-cursor-color "SkyBlue")))
(etheme-add-hook "blue" '(lambda () (set-mouse-color "DimGray")))

(etheme-add-hook "darkblue" 'menu-bar-right-scroll-bar)
(etheme-add-hook "darkblue" '(lambda () (tool-bar-mode -1)))
(etheme-add-hook "darkblue" '(lambda () (set-cursor-color "white")))
(etheme-add-hook "darkblue" '(lambda () (set-mouse-color "yellow")))

(etheme-add-hook "desert" 'menu-bar-right-scroll-bar)
(etheme-add-hook "desert" '(lambda () (tool-bar-mode -1)))
(etheme-add-hook "desert" '(lambda () (set-cursor-color "khaki")))
(etheme-add-hook "desert" '(lambda () (set-mouse-color "yellow")))

(provide 'etheme)

