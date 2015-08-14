#!/bin/sh

USERNAME=${USERNAME:=$CIRCLE_PROJECT_USERNAME}
REPONAME=${REPONAME:=$CIRCLE_PROJECT_REPONAME}
BRANCH=${BRANCH:=source}

git clone git@github.com:$USERNAME/$REPONAME.git -b gh-pages public

wget https://github.com/$USERNAME/$REPONAME/archive/$BRANCH.zip source.zip
unzip -jo source.zip -d source

cask exec emacs --batch -l emacs.el -f org-publish-all
# run it again for archive.org
cask exec emacs --batch -l emacs.el -f org-publish-all
