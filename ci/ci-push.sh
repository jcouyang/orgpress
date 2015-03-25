cd public
git config --global user.name $NAME
git config --global user.email $EMAIL
git add .
git commit -m "auto publi:ship:"
git push origin gh-pages
