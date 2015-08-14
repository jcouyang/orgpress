#!/bin/sh
git clone git@github.com:$CIRCLE_PROJECT_USERNAME/$CIRCLE_PROJECT_REPONAME.git -b gh-pages public

USERNAME=${USERNAME:=$CIRCLE_PROJECT_USERNAME}
REPONAME=${REPONAME:=$CIRCLE_PROJECT_REPONAME}
wget https://github.com/$USERNAME/$REPONAME/archive/source.zip source.zip
unzip -jo source.zip -d source

cask exec emacs --batch -l emacs.el -f org-publish-all
# run it again for archive.org
cask exec emacs --batch -l emacs.el -f org-publish-all
