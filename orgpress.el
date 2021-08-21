(require 'package)
(package-initialize) ;; You might already have this line
(deftheme gtk-ide "gtk-ide theme")
(load-theme 'gtk-ide t t)
(enable-theme 'gtk-ide)

(require 'org)
(require 'scala-mode)
(require 'haskell-mode)
(require 'diff-mode)
(require 'clojure-mode)
(require 'purescript-mode)
(require 'ob-shell)
(require 'ob-ruby)
(require 'htmlize)
(require 'ox-rss)

(setq make-backup-files nil)
(setq debug-on-error nil)
(setq org-html-validation-link nil)
(setq org-confirm-babel-evaluate nil)
(url-handler-mode 1)

(load-file "/blog/config.el")
;;(setq org-export-babel-evaluate nil)
(custom-set-variables
  '(org-publish-timestamp-directory
     (convert-standard-filename "public/.org-timestamps/")))
(setq postamble (with-temp-buffer
                  (insert-file-contents "html/postamble.html")
                  (buffer-string)))
(setq preamble (with-temp-buffer
                  (insert-file-contents "html/preamble.html")
                  (buffer-string)))
(setq header (with-temp-buffer
                  (insert-file-contents "html/header.html")
               (buffer-string)))

(defun my-publish-sitemap (title list)
  "Default site map, as a string.
TITLE is the the title of the site map.  LIST is an internal
representation for the files to include, as returned by
`org-list-to-lisp'.  PROJECT is the current project."
  (concat "#+TITLE:" config-blog-title "\n" "#+OPTIONS: toc:nil\n\n"
            (org-list-to-subtree
             (seq-filter
              (apply-partially
               (lambda (x) (not (string-match-p "theindex\.org" (format "%s" x) )))) list))))

(defun my-sitemap-format (entry style project)
  "Custom sitemap entry formatting"
  (if (not (directory-name-p entry))
    (format-spec config-entry-format `((?t . ,(org-publish-find-title entry project))
                 (?D . ,(format-time-string "<%Y-%m-%d %a>" (org-publish-find-date entry project)))
                 (?c . ,(org-publish-find-property entry :description project 'html))
                 (?l . ,(concat "file:" entry))
                 (?L . ,(replace-regexp-in-string "\.org" "\.html" entry))
                 ))
    "---"))

(defun set-org-publish-project-alist ()
  "Set publishing projects for Orgweb and Worg."
  (interactive)
  (setq org-publish-project-alist
    `(("blog-notes"
       ;; Directory for source files in org format
        :language "zh"
        :base-directory ,blog-path
        :base-extension "org"
        :html-doctype "html5"
        :html-head ,header
        :html-html5-fancy t
        :html-preamble ,preamble
        :html-postamble ,postamble
        ;; HTML directory
        :publishing-directory "public"
        :publishing-function org-html-publish-to-tufte-html
        :recursive t
        :headline-levels 4
        :with-sub-superscript nil
        :section-numbers nil
        :auto-preamble nil
        :auto-sitemap t
        :sitemap-style list
        :sitemap-sort-folders ignore
        :sitemap-sort-files anti-chronologically
        :sitemap-format-entry my-sitemap-format
        :sitemap-function my-publish-sitemap
        :sitemap-filename "index.org"
        :exclude "\!.*\.org"
        :sitemap-date-format ,config-date-format
        :makeindex t
        :html-head-include-default-style nil
        )

       ("blog-static"
         :base-directory ,blog-path
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|svg\\|pdf\\|mp3\\|woff2\\|woff"
         :publishing-directory "public"
         :recursive t
         :publishing-function org-publish-attachment
         )
       ("assets"
         :base-directory ,assets-path
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|svg\\|pdf\\|mp3\\|woff2\\|woff\\|html\\|md\\|ico"
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
       ("blog" :components ("blog-notes" "assets" "blog-static" "rss"))
       )))
(set-org-publish-project-alist)
