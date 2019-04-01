(setq config-blog-title "Orgpress Blog"
      config-base-url "https://blog.oyanglul.us"
      config-home-link "/jichao.ouyang.html"
      config-date-format "%b %d, %Y"
      config-entry-format "[[%l][%t]]
:PROPERTIES:
:HTML_CONTAINER_CLASS: blogentry
:RSS_PERMALINK: %L
:PUBDATE: %D
:END:
%c"
      blog-path (expand-file-name "org")
      assets-path (expand-file-name "assets")
      user-mail-address "oyanglulu@gmail.com"
)
