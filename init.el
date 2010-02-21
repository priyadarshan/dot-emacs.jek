(setq load-path
      (append
       (list
        (expand-file-name "~/.emacs.d/el")
        ; svn co http://yasnippet.googlecode.com/svn/trunk yasnippet
        (expand-file-name "~/.emacs.d/el/yasnippet")
        (expand-file-name "~/.emacs.d/el/emacs-goodies-el")
        )
        load-path))

(server-start)

(setq backup-directory-alist
      `(("." . ,(expand-file-name "~/.emacs.d/backups"))))

;; virtualenv
(setq exec-path
      (cons (expand-file-name "~/libexec/devtools/bin") exec-path))
(add-to-list 'exec-path (expand-file-name "~/bin"))
(add-to-list 'exec-path "/usr/local/bin")

(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

(pymacs-load "pastemacs" "paste-")
(setq paste-kill-url t
      paste-show-in-browser nil)

(set-frame-parameter nil 'alpha 97)

(load-library "jek-fly")

(require 'ido)
(require 'yasnippet)
(require 'dropdown-list)
(yas/initialize)
(setq yas/root-directory
      (list "~/.emacs.d/el/snippets" "~/.emacs.d/el/yasnippet/snippets"))
(yas/load-directory "~/.emacs.d/el/snippets")
(yas/load-directory "~/.emacs.d/el/yasnippet/snippets")
(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt))

(require 'all)

(require 'browse-kill-ring)
(browse-kill-ring-default-keybindings)

(require 'uniquify)
(require 'diminish)
(diminish 'yas/minor-mode)

(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("i3-main" (filename . "work/i3/i3-main"))
               ("tickets" (filename . "work/i3/tkt-"))
               ("gd" (filename . "work/i3/gd-"))
               ("work" (filename . "work/i3/"))
               ("forks" (filename . "work/fork/"))
               ("flatland" (filename . "projects/oss/src/flatland-"))
               ("sqlalchemy" (filename . "projects/oss/src/sa-"))
               ("emacs" (or
                         (name . "^\\*.*\\*$")
                         (name . "\\.el$")))
                ))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))


(load-library "pydo")
(load-library "jek-js2")
(load-library "jek-python")
(load "~/.emacs.d/el/nxhtml/autostart.el")

(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "C-\\") 'call-last-kbd-macro)
(global-set-key (kbd "<s-up>") 'beginning-of-buffer)
(global-set-key (kbd "<s-down>") 'end-of-buffer)
(global-set-key (kbd "C-M-<down>") 'flymake-goto-next-error)
(global-set-key (kbd "C-M-<up>") 'flymake-goto-prev-error)


(autoload 'todoo-mode "todoo" "TODO Mode" t)
(add-to-list 'auto-mode-alist '("TODO$" . todoo-mode))

(setq debug-on-error nil)
(setq custom-file "~/.emacs.d/customizations.el")
(load custom-file)
