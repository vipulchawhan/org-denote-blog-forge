(require 'package)

(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'denote)
  (package-refresh-contents)
  (package-install 'denote))

(require 'ox-publish)
(require 'subr-x)
(require 'denote)

(setq org-publish-use-timestamps-flag nil)
(setq org-html-html5-fancy t)
(setq org-html-doctype "html5")
(setq org-html-validation-link nil)
(setq org-export-with-section-numbers nil)
(setq org-export-with-toc t)
(setq org-html-head "")
(setq org-html-preamble nil)
(setq org-html-postamble nil)
(setq make-backup-files nil)

(defun vipul/denote-title-from-file (file)
  (with-temp-buffer
    (insert-file-contents file)
    (goto-char (point-min))
    (if (re-search-forward "^#\\+title:[ \t]*\\(.+\\)$" nil t)
        (string-trim (match-string 1))
      (let* ((base (file-name-base file))
             (parts (split-string base "--"))
             (title+keywords (if (> (length parts) 1) (cadr parts) base))
             (title-part (car (split-string title+keywords "__"))))
        (mapconcat #'capitalize (split-string title-part "-" t) " ")))))

(defun vipul/org-publish-sitemap-entry (entry style project)
  (let ((file (org-publish--expand-file-name entry project)))
    (if (directory-name-p entry)
        entry
      (format "[[file:%s][%s]]"
              entry
              (vipul/denote-title-from-file file)))))

(defun vipul/denote-link-export (path desc backend _protocol)
  (cond
   ((eq backend 'html)
    (let* ((files (directory-files-recursively
                   "notes"
                   (concat "^" (regexp-quote path) "--.*\\.org$")))
           (target (when files
                     (concat (file-name-base (car files)) ".html")))
           (label (or desc path)))
      (if target
          (format "<a href=\"%s\">%s</a>" target label)
        (format "<span class=\"broken-denote-link\">%s</span>" label))))
   (t
    (or desc path))))

(org-link-set-parameters
 "denote"
 :export #'vipul/denote-link-export)

(setq org-publish-project-alist
      '(("notes"
         :base-directory "notes"
         :base-extension "org"
         :publishing-directory "public"
         :recursive nil
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :section-numbers nil
         :with-toc t
         :with-author nil
         :with-creator nil
         :auto-sitemap t
         :sitemap-filename "index.org"
         :sitemap-title "Notes"
         :sitemap-style list
         :sitemap-sort-files anti-chronologically
         :sitemap-format-entry vipul/org-publish-sitemap-entry
         :html-head ""
         :html-preamble nil
         :html-postamble nil)

        ("attachments"
         :base-directory "notes"
         :base-extension "png\\|jpg\\|jpeg\\|gif\\|svg\\|webp\\|pdf\\|css\\|js"
         :publishing-directory "public"
         :recursive t
         :publishing-function org-publish-attachment)

        ("site"
         :components ("notes" "attachments"))))

