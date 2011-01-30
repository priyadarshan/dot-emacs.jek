(set-frame-parameter nil 'alpha 97)
(add-to-list 'default-frame-alist '(alpha . 97))

(global-set-key (kbd "s-<left>")
                '(lambda () (interactive) (other-window -1)))
(global-set-key (kbd "s-<right>") 'other-window)

(autoload 'buffer-stack-up "buffer-stack" nil t)
(autoload 'buffer-stack-down "buffer-stack" nil t)
(autoload 'buffer-stack-bury "buffer-stack" nil t)
(autoload 'buffer-stack-untrack "buffer-stack" nil t)
(autoload 'buffer-stack-track "buffer-stack" nil t)

(global-set-key (kbd "S-s-<right>") 'buffer-stack-up)
(global-set-key (kbd "S-s-<left>") 'buffer-stack-down)
(global-set-key (kbd "S-s-<down>") 'buffer-stack-bury)
(global-set-key (kbd "C-s-<up>") 'buffer-stack-untrack)
(global-set-key (kbd "C-S-s-<up>") 'buffer-stack-track)

(global-set-key (kbd "s-+")
  '(lambda () (interactive) (text-scale-adjust 1)))
(global-set-key (kbd "s--")
  '(lambda () (interactive) (text-scale-adjust -1)))
(global-set-key (kbd "s-0")
  '(lambda () (interactive) (text-scale-adjust (- text-scale-mode-amount))))


; bookmarked
(defun jek/frame-doublewide ()
  (interactive)
  (set-frame-size (selected-frame) 162 56)
  (split-window-horizontally))
