(require 'eproject)
(require 'eproject-extras)

(define-project-type python (generic)
  (look-for "setup.py")
  :relevant-files ("\\.py$" "\\.rst$"))

(defun eproject-multi-occur (regex)
  "Search all open project files for 'regex' using `multi-occur'"
  (interactive "sRegex: ")
  (moccur-search
   regex nil (cdr (assoc (eproject-root) (eproject--project-buffers)))))
