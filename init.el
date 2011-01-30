(setq load-path
      (append
       (list
        "~/.emacs.d/el"
        ; svn co http://yasnippet.googlecode.com/svn/trunk yasnippet
        "~/.emacs.d/el/yasnippet"
        ; git clone http://github.com/m2ym/auto-complete.git
        "~/.emacs.d/el/auto-complete"
        "~/.emacs.d/el/emacs-goodies-el"
        "~/.emacs.d/el/bookmarkp"
        ; cvs -d :pserver:anonymous@cvs.namazu.org:/storage/cvsroot co emacs-w3m
        "~/.emacs.d/el/emacs-w3m"
        ; git clone https://github.com/jrockway/eproject.git
        "~/.emacs.d/el/eproject"
        ; (newer than the shipped version)
        "~/.emacs.d/el/org-mode/lisp"
        )
        load-path))
; Check for stale .elc on startup. Slow, but I only restart Emacs after reboots.
(byte-recompile-directory "~/.emacs.d/el")
(server-start)

(setq
   backup-by-copying t
   backup-directory-alist `(("." .
                             ,(expand-file-name "~/.emacs.d/var/backups")))
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)
(setq auto-save-file-name-transforms
      (quote ((".*" "~/.emacs.d/var/saves/\\1" t))))

;; virtualenv of development tools
(setq exec-path (cons (expand-file-name "~/libexec/devtools/bin") exec-path))
(add-to-list 'exec-path (expand-file-name "~/bin"))
(add-to-list 'exec-path "/usr/local/bin")
(add-to-list 'exec-path"/opt/local/bin")

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(require 'diminish)
(require 'uniquify)

(require 'bookmark+)

(autoload 'w3m-browse-url "w3m-load" "emacs-w3m." t)
(setq browse-url-browser-function 'w3m-browse-url)
(eval-after-load 'w3m-search
  '(progn
     (add-to-list 'w3m-search-engine-alist
                  '("python" "http://www.google.com/search?hl=en&q=site:docs.python.org+inurl:/library/+%s"))
     (add-to-list 'w3m-search-engine-alist
                  '("emacs-wiki" "http://www.emacswiki.org/cgi-bin/wiki.pl?search=%s"))))

(require 'popup)
(require 'pos-tip)
(require 'popup-kill-ring)
(global-set-key "\M-y" 'popup-kill-ring)

(autoload 'simplenote-browse "simplenote" nil t)
(autoload 'markdown-mode "markdown-mode" nil t)

(autoload 'todoo-mode "todoo" "TODO Mode" t)
(add-to-list 'auto-mode-alist '("TODO$" . todoo-mode))

(load-library "jek-ido")
(load-library "jek-electric")
(load-library "jek-frames")
; (load-library "jek-ac")
(load-library "jek-fly")
(load-library "jek-hs")
(load-library "jek-snippets")
(load-library "jek-searchrep")
(load-library "jek-mark")
(load-library "jek-ibuffer")
(load-library "jek-js2")
(load-library "jek-python")
(load-library "jek-eproject")

(global-set-key (kbd "C-\\") 'call-last-kbd-macro)
(global-set-key (kbd "<s-up>") 'beginning-of-buffer)
(global-set-key (kbd "<s-down>") 'end-of-buffer)
(global-set-key (kbd "C-M-<down>") 'flymake-goto-next-error)
(global-set-key (kbd "C-M-<up>") 'flymake-goto-prev-error)
(global-set-key (kbd "C-M-?") 'flymake-display-err-menu-for-current-line)

(put 'narrow-to-page 'disabled nil)
(put 'narrow-to-region 'disabled nil)

(setq debug-on-error nil)
(setq custom-file "~/.emacs.d/customizations.el")
(load custom-file)

(let ((custom-extra (expand-file-name "~/.emacs.d/customizations-private.el")))
  (if (file-exists-p custom-extra)
      (load custom-extra)))
