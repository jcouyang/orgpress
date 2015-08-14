#!/bin/sh
git clone git@github.com:$USER/$REPO.git -b gh-pages public
cask exec emacs --batch -l emacs.el -f org-publish-all
# run it again for archive.org
cask exec emacs --batch -l emacs.el -f org-publish-all
