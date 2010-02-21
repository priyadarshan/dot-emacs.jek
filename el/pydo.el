;; Easily show todo items

(require 'compile)

(defun pydo ()
  "Run pydo against the current buffer after checking
  if the buffer should be saved"
  (interactive)
  (let* ((file (buffer-file-name (current-buffer)))
         (command (concat "pydo \"" file "\"")))
    (save-some-buffers (not compilation-ask-about-save) nil)
    (compilation-start command nil (lambda (modename) "pydo"))
  )
)
