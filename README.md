# Dockerized Org Blog Generator

# TLDR
fork this repo and clone

```sh
./compile
```

# Prerequisite
 - [Docker](https://www.docker.com/get-started)

# Configuration

## variables in `config.el`

- `config-blog-title`: you blog title
- `config-base-url`: base url
- `config-home-link`: about link
- `config-date-format`: date format using [[https://www.gnu.org/software/emacs/manual/html_node/elisp/Time-Parsing.html][elisp time parsing format]]
- `config-entry-format`: template for each blog item
```elisp
(?D . ,(format-time-string "<%Y-%m-%d %a>" (org-publish-find-date entry project)))
(?c . ,(org-publish-find-property entry :description project 'html))
(?l . ,(concat "file:" entry))
(?L . ,(replace-regexp-in-string "\.org" "\.html" entry))
```

# header and footer html template
- `html/preamble.html`: header
- `html/postamble.html`: footer
- `html/header.html`: custom content inside `<head/>`

# Live Demo
https://blog.oyanglul.us
