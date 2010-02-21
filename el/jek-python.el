(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

(defun jek-py-hooks ()
  (flyspell-prog-mode)
  (yas/minor-mode-on)
  (imenu-add-menubar-index)
  (turn-on-eldoc-mode)
  (set-variable 'fill-column 78)
)
(add-hook 'python-mode-hook 'jek-py-hooks)

(eval-after-load 'python-mode
  ;; jek's python font-lock
  '(setq python-font-lock-keywords
         `(,(rx symbol-start
                ;; From v 2.5 reference, § keywords.
                ;; def and class dealt with separately below
                (or "and" "as" "assert" "break" "continue" "del" "elif" "else"
                    "except" "exec" "finally" "for" "from" "global" "if"
                    "import" "in" "is" "lambda" "not" "or" "pass" "print"
                    "raise" "return" "try" "while" "with" "yield")
                symbol-end)
           (,(rx symbol-start
                 (or "None" "True" "False" "tuple()" "frozenset()")
                 symbol-end)    ; see § Keywords in 2.5 manual
            . font-lock-constant-face)
           ;; Definitions
           (,(rx symbol-start
                 (group "class") (1+ space) (group (1+ (or word ?_))))
            (1 font-lock-keyword-face) (2 font-lock-type-face))
           (,(rx symbol-start
                 (group "def") (1+ space) (group (1+ (or word ?_))))
            (1 font-lock-keyword-face) (2 font-lock-function-name-face))
           ;; Top-level assignments are worth highlighting.
           (,(rx line-start (group (1+ (or word ?_))) (0+ space) "=")
            (1 font-lock-variable-name-face))
           (,(rx line-start
                 (* (any " \t")) (group "@" (1+ (or word ?_)))) ; decorators
            (1 font-lock-type-face))
           (,(rx symbol-start (or "self" "cls" "class_") symbol-end)
            . font-lock-variable-name-face)
           ;; Built-ins.  (The next three blocks are from
           ;; `__builtin__.__dict__.keys()' in Python 2.5.1.)  These patterns
           ;; are debateable, but they at least help to spot possible
           ;; shadowing of builtins.
           (,(rx symbol-start
                 (or
                  ;; exceptions
                  "ArithmeticError" "AssertionError" "AttributeError"
                  "BaseException" "DeprecationWarning" "EOFError"
                  "EnvironmentError" "Exception" "FloatingPointError"
                  "FutureWarning" "GeneratorExit" "IOError" "ImportError"
                  "ImportWarning" "IndentationError" "IndexError" "KeyError"
                  "KeyboardInterrupt" "LookupError" "MemoryError" "NameError"
                  "NotImplemented" "NotImplementedError" "OSError"
                  "OverflowError" "PendingDeprecationWarning" "ReferenceError"
                  "RuntimeError" "RuntimeWarning" "StandardError"
                  "StopIteration" "SyntaxError" "SyntaxWarning" "SystemError"
                  "SystemExit" "TabError" "TypeError" "UnboundLocalError"
                  "UnicodeDecodeError" "UnicodeEncodeError" "UnicodeError"
                  "UnicodeTranslateError" "UnicodeWarning" "UserWarning"
                  "ValueError" "Warning" "ZeroDivisionError") symbol-end)
            . font-lock-type-face)
           (,(rx (or line-start (not (any ". \t"))) (* (any " \t")) symbol-start
                 (group
                  (or
                   ;; callable built-ins, fontified when not appearing as
                   ;; object attributes
                   "abs" "all" "any" "apply" "basestring" "bool" "buffer"
                   "callable" "chr" "classmethod" "cmp" "coerce" "compile"
                   "complex" "copyright" "credits" "delattr" "dict" "dir"
                   "divmod" "enumerate" "eval" "execfile" "exit" "file"
                   "filter" "float" "frozenset" "getattr" "globals" "hasattr"
                   "hash" "help" "hex" "id" "input" "int" "intern"
                   "isinstance" "issubclass" "iter" "len" "license" "list"
                   "locals" "long" "map" "max" "min" "object" "oct" "open"
                   "ord" "pow" "property" "quit" "range" "raw_input" "reduce"
                   "reload" "repr" "reversed" "round" "set" "setattr" "slice"
                   "sorted" "staticmethod" "str" "sum" "super" "tuple" "type"
                   "unichr" "unicode" "vars"
                   "xrange" "zip")) symbol-end)
            (1 font-lock-builtin-face))
           (";" . font-lock-warning-face)
           (,(rx symbol-start "__" (+? (char alnum)) "__" symbol-end)
            0 font-lock-preprocessor-face t)
           (,(rx symbol-start
                 "__" (+? (char alnum)) "_" (+? (char alnum)) "__"
                 symbol-end)
            0 font-lock-warning-face t)
           (,(rx symbol-start
                 (or
                  ;; other built-ins
                  "Ellipsis" "_" "__debug__" "__import__"
                  "__base__" "__bases__" "__class__" "__doc__"
                  "__module__" "__mro__" "__name__" "__subclasses__")
                 symbol-end)
            0 font-lock-builtin-face t))))

(defun load-ropemacs ()
  "Load pymacs and ropemacs"
  (interactive)
  (require 'pymacs)
  (pymacs-load "ropemacs" "rope-")
  ;; Automatically save project python buffers before refactorings
  (setq ropemacs-confirm-saving 'nil)
)
(global-set-key "\C-xpl" 'load-ropemacs)
