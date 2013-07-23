(require 'android-mode)
(stante-after android-mode
	      (android-defun-ant-task "all")
	      (if (eq system-type 'gnu/linux)
		  (progn
		    (setq android-mode-sdk-dir (getenv "ANDROID_HOME"))
		    (add-to-list 'load-path (concat android-mode-sdk-dir "/tools/lib"))
		    (require 'android)))
)
