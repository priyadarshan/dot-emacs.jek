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

(diminish 'yas/minor-mode)
