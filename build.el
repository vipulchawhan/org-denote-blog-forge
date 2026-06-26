(require 'ox-publish)

(setq org-html-html5-fancy t)
(setq org-html-doctype "html5")
(setq org-html-validation-link nil)
(setq org-export-with-toc t)
(setq org-export-with-section-numbers nil)
(setq make-backup-files nil)

(setq org-publish-project-alist
      '(("notes"
         :base-directory "notes"
         :base-extension "org"
         :publishing-directory "public"
         :recursive nil
         :publishing-function org-html-publish-to-html
         :with-author nil
         :with-creator nil
         :with-date t
         :headline-levels 4
         :auto-sitemap t
         :sitemap-title "Notes"
         :sitemap-filename "index.org"
         :sitemap-sort-files anti-chronologically)

        ("static"
         :base-directory "notes"
         :base-extension "css\\|js\\|png\\|jpg\\|jpeg\\|gif\\|svg\\|pdf"
         :publishing-directory "public"
         :recursive t
         :publishing-function org-publish-attachment)

        ("site" :components ("notes" "static"))))
