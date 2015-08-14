cd public
git config --global user.email "$EMAIL"
git config --global user.name "$USERNAME"
git add .
git commit -m "publi:ship: by [OrgPress](https://github.com/jcouyang/orgpress)"
git push origin gh-pages
