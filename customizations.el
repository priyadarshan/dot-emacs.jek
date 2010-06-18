;; for compatibility with older Aquamacs versions
; (defvar aquamacs-140-custom-file-upgraded t)
; (unless (fboundp 'auto-detect-longlines) (defun auto-detect-longlines () t))

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 172 t)
 '(column-number-mode t)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(dabbrev-case-fold-search nil)
 '(default-frame-alist (quote ((tool-bar-lines . 0) (menu-bar-lines . 1) (foreground-color . "Black") (background-color . "White") (cursor-type . box) (cursor-color . "Red") (fringe) (left-fringe . 5) (right-fringe . 5))))
 '(enable-recursive-minibuffers nil)
 '(espresso-indent-level 4)
 '(flymake-allowed-file-name-masks (quote (("\\.py" flymake-pycheckers-init))))
 '(focus-follows-mouse nil)
 '(global-hl-line-mode t)
 '(iedit-occurrence-face (quote match))
 '(indent-tabs-mode nil)
 '(indicate-buffer-boundaries (quote left))
 '(indicate-empty-lines t)
 '(inhibit-startup-screen t)
 '(initial-buffer-choice "~/TODO")
 '(overflow-newline-into-fringe t)
 '(pabbrev-read-only-error nil)
 '(py-continuation-offset 2)
 '(python-continuation-offset 2)
 '(recentf-mode t)
 '(recentf-save-file "~/.emacs.d/recent-files")
 '(require-final-newline nil)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(todoo-file-name "~/TODO")
 '(track-eol t)
 '(truncate-partial-width-windows nil)
 '(uniquify-buffer-name-style (quote reverse) nil (uniquify))
 '(uniquify-separator ":")
 '(vline-face (quote hl-line)))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(diff-added ((t (:inherit diff-changed :foreground "blue"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "red"))))
 '(flyspell-duplicate ((t (:foreground "Gold3" :underline t))))
 '(flyspell-incorrect ((t (:foreground "OrangeRed" :underline t))))
 '(fringe ((((class color) (background light)) (:background "grey97"))))
 '(mode-line ((((class color) (min-colors 88)) (:background "grey75" :foreground "black" :box (:line-width -1 :style released-button) :height 1.1 :family "optima"))))
 '(rst-mode-default ((t (:inherit text-mode-default :slant normal :weight normal :height 120 :family "monaco"))) t)
 '(sml-modeline-end-face ((t nil)))
 '(sml-modeline-vis-face ((t nil)))
 '(trailing-whitespace ((((class color) (background light)) (:background "#eeeeaa")))))

(put 'downcase-region 'disabled nil)
