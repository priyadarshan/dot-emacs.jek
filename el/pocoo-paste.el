;; pocoo-paste.el
;;
;; Dan Colish <dcolish@gmail.com>
;; Copyright (c) 2010
;; All rights reserved
;; Redistribution and use in source and binary forms, with or without
;; modification, are permitted provided that the following conditions are met:
;;     * Redistributions of source code must retain the above copyright
;;       notice, this list of conditions and the following disclaimer.
;;     * Redistributions in binary form must reproduce the above copyright
;;       notice, this list of conditions and the following disclaimer in the
;;       documentation and/or other materials provided with the distribution.
;;     * Neither the name of the <organization> nor the
;;       names of its contributors may be used to endorse or promote products
;;       derived from this software without specific prior written permission.
;; THIS SOFTWARE IS PROVIDED BY Daniel Colish ''AS IS'' AND ANY
;; EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;; WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
;; DISCLAIMED. IN NO EVENT SHALL Daniel Colish BE LIABLE FOR ANY
;; DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;; (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
;;  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
;; ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;; (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;; SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


;; TODO: 
;; 1. manage the *Pocoo* buffer better

(require 'xml-rpc)

(defgroup pocoo-paste nil
  "Customization group for pocoo-paste.el"
  :group 'applications)

(defcustom pocoo-always-private nil
  "Non-nil means always post privately"
  :type 'boolean
  :group 'pocoo-paste)

(defcustom pocoo-never-ask-private nil
  "Non-nil means never ask to paste privately"
  :type 'boolean
  :group 'pocoo-paste)

(defvar pocoo-url "http://paste.pocoo.org/xmlrpc/")


;;;###autoload
(defun pocoo-get-diff (old-id new-id)
  (interactive "Mold id: \nMnew id: ")
  (with-output-to-temp-buffer "*Pocoo*"
    (princ (xml-rpc-method-call pocoo-url 'pastes.getDiff 
                                            old-id new-id))))

;;;###autoload
(defun pocoo-get-last ()
  (interactive)
  (pocoo-simple-get 'pastes.getLast nil))

;;;###autoload
(defun pocoo-get-languages ()
  (interactive)
  (pocoo-get-list 'pastes.getLanguages))

;;;###autoload
(defun pocoo-get-paste (paste)
  (interactive "Mpaste: ")
  (pocoo-simple-get 'pastes.getPaste paste))

;;;###autoload
(defun pocoo-get-recent (num)
  (interactive "namount: ")
  (with-output-to-temp-buffer "*Pocoo*"
    (princ 
     (mapconcat (lambda (arg)
                    (cdr (assoc "code" arg)))
                (xml-rpc-method-call pocoo-url 'pastes.getRecent num)
                "\n"))))

;;;###autoload
(defun pocoo-get-styles ()
  (interactive)
  (pocoo-get-list 'styles.getStyles))

;;;###autoload
(defun pocoo-get-stylesheet (name)
  (interactive "Mstylesheet name: ")
  (with-output-to-temp-buffer "*Pocoo*"
    (princ (xml-rpc-method-call pocoo-url 'styles.getStylessheet name))))

;;;###autoload
(defun pocoo-paste-buffer (language)
  (interactive "Mlanguage: ")
  (pocoo-call-xml-paste language (buffer-string)))

;;;###autoload
(defun pocoo-paste-region (point mark language)
  (interactive "r\nMlanguage: ")
  (pocoo-call-xml-paste language (buffer-substring-no-properties point mark)))


;; Utility functions
(defun check-private () 
  (if (eq pocoo-always-private t)
      t
      (if (eq pocoo-never-ask-private nil)
          (yes-or-no-p "Private paste? ")
        nil)))

(defun pocoo-call-xml-paste (lang code)
  (let ((paste (format"http://paste.pocoo.org/show/%s" 
                        (xml-rpc-method-call pocoo-url 'pastes.newPaste lang code
                                             'nil 'nil 'nil 
                                             (check-private)))))
    (message "Paste created: %s" paste)
    (kill-new paste)))

(defun pocoo-get-list (fn)
  (with-output-to-temp-buffer "*Pocoo*"
    (princ (mapconcat 'car
                      (xml-rpc-method-call pocoo-url 'pastes.getLanguages)
                      "\n"))))

(defun pocoo-get-code (fn arg)
  (with-output-to-temp-buffer "*Pocoo*"
    (princ (cdr (assoc "code" 
                       (if (eq arg nil)
                           (xml-rpc-method-call pocoo-url fn)
                         (xml-rpc-method-call pocoo-url fn arg)))))))


(provide 'pocoo-paste)