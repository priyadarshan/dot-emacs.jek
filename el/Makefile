EMACS=~/Applications/Emacs.app/Contents/MacOS/Emacs -q --no-site-file
export LOAD_PATH=auto-complete:bookmarkp:emacs-goodies-el:emacs-w3m:eproject:yasnippet

BLACKLIST = fringe-helper.el buffer-stack.el
ELS = $(filter-out $(BLACKLIST),$(shell ls -1 *.el))
ELCS = $(ELS:.el=.elc)

all: $(ELCS)
	make $(ELCS)

autoloads: install.el
	emacs -q --no-site-file -batch -L . -l install.el \
		-eval '(install-update-autoloads "autoloads")'

.el.elc:
	$(EMACS) -batch -L . \
		-eval "(setq max-lisp-eval-depth 1500 max-specpdl-size 3000)" \
		-eval "(mapc (lambda (dir) (add-to-list 'load-path dir)) (parse-colon-path (getenv \"LOAD_PATH\")))" \
		-f batch-byte-compile $*.el

