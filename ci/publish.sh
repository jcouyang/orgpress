#!/bin/sh

USERNAME=${USERNAME:=$CIRCLE_PROJECT_USERNAME}
NAME=${NAME:=USERNAME}
REPONAME=${REPONAME:=$CIRCLE_PROJECT_REPONAME}
BRANCH=${BRANCH:=source}

git clone git@github.com:$USERNAME/$REPONAME.git -b gh-pages public

wget https://github.com/$USERNAME/$REPONAME/archive/$BRANCH.zip -O source.zip
unzip source.zip

mv $REPONAME-$BRANCH source

cask exec emacs --batch -l emacs.el -f org-publish-all
# run it again for archive.org
cask exec emacs --batch -l emacs.el -f org-publish-all
