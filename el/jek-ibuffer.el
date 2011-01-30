(require 'ibuffer)
(setq ibuffer-saved-filter-groups
      (quote (("default"
               ("dired" (mode . dired-mode))
               ("packages" (filename . "__init__.py"))
               ("python" (mode . python-mode))
               ("emacs" (or
                         (name . "^\\*.*\\*$")
                         (name . "\\.el$")))
                ))))
(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-switch-to-saved-filter-groups "default")))

; include eproject name
(add-to-list 'ibuffer-formats '((eproject 14 14 :right :elide) " "
                                mark modified read-only " "
                                (name 30 30 :left :elide) " "
                                (filename-and-process)))

(defadvice ibuffer (around ibuffer-point-to-most-recent) ()
  "Open ibuffer with cursor pointed to most recent buffer name"
  (let ((recent-buffer-name (buffer-name)))
    ad-do-it
    (ibuffer-jump-to-buffer recent-buffer-name)))
(ad-activate 'ibuffer)

(global-set-key (kbd "C-x C-b") 'ibuffer)
