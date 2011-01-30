(require 'filladapt)
(setq-default filladapt-mode t)
(diminish 'filladapt-mode)

(require 'rebox2)
(global-set-key (kbd "M-q") 'rebox-dwim-fill)
(global-set-key (kbd "S-M-q") 'rebox-dwim-no-fill)
(add-hook 'python-mode-hook (lambda ()
                              (rebox-mode 1)))

(require 'autopair)
(autopair-global-mode)
(setq autopair-autowrap t)
(diminish 'autopair-mode)
