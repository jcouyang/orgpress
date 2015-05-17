(load-file "config.el")
(require 'color-theme)
(color-theme-initialize)
(color-theme-gtk-ide)
(require 'clojure-mode)
(clojure-font-lock-setup)
(require 'org)
(require 'org-blog)
(require 'htmlize)
(setq debug-on-error t)
(setq blog-path (expand-file-name "org"))
(setq org-html-validation-link nil)
(setq org-confirm-babel-evaluate nil)
(custom-set-variables
  '(org-publish-timestamp-directory
     (convert-standard-filename "public/.org-timestamps/")))
(setq postamble (with-temp-buffer
                  (insert-file-contents "html/postamble.html")
                  (buffer-string)))
(defun set-org-publish-project-alist ()
  "Set publishing projects for Orgweb and Worg."
  (interactive)
  (setq org-publish-project-alist
    `(("blog-notes"
       ;; Directory for source files in org format
        :base-directory ,blog-path
        :base-extension "org"
        :html-doctype "html5"
        :html-head "<meta charset=\"utf-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><link rel=\"stylesheet\" href=\"/style/pixyll.css\"/><link rel=\"alternate\" type=\"application/rss+xml\" title=\"Jichao Ouyang\" href=\"http://blog.oyanglul.us/index.xml\"/>"
        :html-html5-fancy t
        :html-postamble ,postamble
        ;; HTML directory
        :publishing-directory "public"
        :publishing-function org-html-publish-to-html
        :recursive t
        :headline-levels 4
        :with-sub-superscript nil
        :section-numbers nil
        :html-link-up "/index.html"
        :html-link-home ,config-home-link
        :auto-preamble t
        :auto-sitemap t
        :sitemap-filename "index.org"
        :exclude "\!.*\.org"
        :sitemap-function org-blog-export
        :blog-entry-format ,config-entry-format
        :blog-export-dates t
        :sitemap-date-format ,config-date-format
        :blog-title ,config-blog-title
        :makeindex t
        :html-head-include-default-style nil
        )

       ;; where static files (images, pdfs) are stored
       ("blog-static"
         :base-directory ,blog-path
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|woff2\\|woff"
         :publishing-directory "public"
         :recursive t
         :publishing-function org-publish-attachment
         )
       ("rss"
         :base-directory ,blog-path
         :base-extension "org"
         :html-link-home ,config-base-url
         :html-link-use-abs-url t
         :rss-extension "xml"
         :publishing-directory "public"
         :publishing-function (org-rss-publish-to-rss)
         :section-numbers nil
         :exclude ".*"            ;; To exclude all files...
         :include ("index.org")   ;; ... except index.org.
         :table-of-contents nil)
       ("blog" :components ("blog-notes" "blog-static" "rss"))
       )))
(set-org-publish-project-alist)
