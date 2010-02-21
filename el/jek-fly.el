(setq ispell-program-name "/usr/local/bin/aspell"
      ispell-extra-args '("--sug-mode=fast")
      ispell-dictionary "english"
      ispell-dictionary-alist
      (let ((default '("[A-Za-z]" "[^A-Za-z]" "[']" nil
                       ("-B" "-d" "english" "--dict-dir"
                        "/Library/Application Support/cocoAspell/aspell6-en-6.0-0")
                       nil iso-8859-1)))
        `((nil ,@default)
          ("english" ,@default))))

(require 'flyspell)
(setq flyspell-mouse-map
      (let ((map (make-sparse-keymap)))
        (define-key map (if (featurep 'xemacs) [button3] [down-mouse-3])
          #'flyspell-correct-word)
        map))

(when (load "flymake" t)
  (defun flymake-pycheckers-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      ; http://discorporate.us/jek/talks/pycheckers.py
      (list (expand-file-name "~/libexec/devtools/bin/pycheckers")
            (list local-file))))

  ;;; getting weird backtraces coming from fringe + revert-buffer
  ;; (require 'fringe-helper)
  ;; (defvar flymake-fringe-overlays nil)
  ;; (make-variable-buffer-local 'flymake-fringe-overlays)
  ;; (defadvice flymake-make-overlay (after add-to-fringe first
  ;;                                        (beg end tooltip-text face mouse-face)
  ;;                                        activate compile)
  ;;   (push (fringe-helper-insert-region
  ;;          beg end
  ;;          (fringe-lib-load (if (eq face 'flymake-errline)
  ;;                               fringe-lib-exclamation-mark
  ;;                             fringe-lib-question-mark))
  ;;          'left-fringe 'font-lock-warning-face)
  ;;         flymake-fringe-overlays))
  ;; (defadvice flymake-delete-own-overlays (after remove-from-fringe activate
  ;;                                               compile)
  ;;   (mapc 'fringe-helper-remove flymake-fringe-overlays)
  ;;   (setq flymake-fringe-overlays nil))
  )
(add-hook 'find-file-hook 'flymake-find-file-hook)


;; License: Gnu Public License
;;
;; Additional functionality that makes flymake error messages appear
;; in the minibuffer when point is on a line containing a flymake
;; error. This saves having to mouse over the error, which is a
;; keyboard user's annoyance

;;flymake-ler(file line type text &optional full-file)
(defun show-fly-err-at-point ()
  "If the cursor is sitting on a flymake error, display the
message in the minibuffer"
  (interactive)
  (let ((line-no (line-number-at-pos)))
    (dolist (elem flymake-err-info)
      (if (eq (car elem) line-no)
	  (let ((err (car (second elem))))
	    (message "%s" (fly-pyflake-determine-message err)))))))

(defun fly-pyflake-determine-message (err)
  "pyflake is flakey if it has compile problems, this adjusts the
message to display, so there is one ;)"
  (cond ((not (or (eq major-mode 'Python) (eq major-mode 'python-mode) t)))
	((null (flymake-ler-file err))
	 ;; normal message do your thing
	 (flymake-ler-text err))
	(t ;; could not compile err
	 (format "compile error, problem on line %s" (flymake-ler-line err)))))

(defadvice flymake-goto-next-error (after display-message activate compile)
  "Display the error in the mini-buffer rather than having to mouse over it"
  (show-fly-err-at-point))

(defadvice flymake-goto-prev-error (after display-message activate compile)
  "Display the error in the mini-buffer rather than having to mouse over it"
  (show-fly-err-at-point))

(defadvice flymake-mode (before post-command-stuff activate compile)
  "Add functionality to the post command hook so that if the
cursor is sitting on a flymake error the error information is
displayed in the minibuffer (rather than having to mouse over
it)"
  (set (make-local-variable 'post-command-hook)
       (cons 'show-fly-err-at-point post-command-hook)))
