(setq load-path
      (append
       (list
        ; git clone git://repo.or.cz/anything-config.git
        "~/.emacs.d/el/anything-config"
        "~/.emacs.d/el/anything-config/extensions"
        )
        load-path))

(require 'auto-complete-config)
(ac-config-default)


(defvar ac-source-python '((candidates .
   (lambda ()
     (mapcar '(lambda (completion)
                (first (last (split-string completion "\\." t))))
             (python-symbol-completions (python-partial-symbol)))))))

(add-hook 'python-mode-hook
   (lambda() (setq ac-sources '(ac-source-python))))
