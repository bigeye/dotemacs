(require 'android-mode)

(setq
 android-mode-build-command-alist (quote ((ant . "ant -e") (maven . "mvn -Psign")))
 android-mode-builder 'maven
 android-mode-sdk-dir (getenv "ANDROID_HOME")
 )

(provide 'bigeye-android-mode)
