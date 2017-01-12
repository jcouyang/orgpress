FROM jcouyang/emacs:24
COPY emacs.el /emacs/orgpress.el
CMD cask exec emacs --batch -l /emacs/orgpress.el -f org-publish-all

