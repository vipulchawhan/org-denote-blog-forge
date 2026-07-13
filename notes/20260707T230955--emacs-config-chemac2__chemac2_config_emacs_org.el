(require 'use-package)
(setq package-native-compile t)
(setq use-package-always-ensure t)
(tool-bar-mode -1)
(menu-bar-mode -1)

(defvar efs/default-font-size 110)
    (defvar efs/default-variable-font-size 110)
    (set-face-attribute 'default nil :font "Victor Mono" :height efs/default-font-size)

    ;; Set the fixed pitch face
    (set-face-attribute 'fixed-pitch nil :font "Victor Mono" :height efs/default-font-size)

  ;; (set-face-attribute 'default nil :font "Iosevka NF" :height efs/default-font-size)

  ;; ;; Set the fixed pitch face
  ;; (set-face-attribute 'fixed-pitch nil :font "Iosevka NF" :height efs/default-font-size)

    
    ;; Set the variable pitch face
    (set-face-attribute 'variable-pitch nil :font "NotoSerif NF Black" :height efs/default-variable-font-size :weight 'regular)

(set-fontset-font t 'unicode (font-spec :family "Iosevka NF") nil 'append)

(use-package modus-themes
  :config
  ;; Your customizations before loading theme
  (setq modus-themes-italic-constructs t
        modus-themes-bold-constructs nil)

  (setq modus-themes-common-palette-overrides
        '((fg-line-number-inactive "gray50")
          (fg-line-number-active red-cooler)
          (bg-line-number-inactive unspecified)
          (bg-line-number-active unspecified)
          (prose-done green-intense)
          (prose-todo red-intense)
          (underline-link border)
          (underline-link-visited border)
          (underline-link-symbolic border)
          (border-mode-line-inactive bg-mode-line-inactive)
          (bg-mode-line-active bg-ochre)
          (fg-mode-line-active fg-main)
          (border-mode-line-active bg-red-subtle)
          (fg-heading-1 blue-warmer)
          (bg-heading-1 bg-blue-nuanced)
          (overline-heading-1 blue)
          (bg-tab-bar bg-ochre)
          (bg-tab-current bg-magenta-subtle)
          (bg-tab-other bg-sage)
          (fringe bg-blue-nuanced)))
  
  ;; Load the theme safely
  (load-theme 'modus-operandi :no-confirm)

  ;; Optional: keybinding for toggling themes
  (define-key global-map (kbd "<f5>") #'modus-themes-toggle))

(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)
(run-at-time nil (* 5 60) 'recentf-save-list)

(use-package which-key
  :defer 10
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1
	which-key-max-display-columns 5))

(setq org-todo-keywords

      '((sequence "TODO" "|" "DONE" )))

(use-package vertico
  ;; make extentions work (by some magic)
  :straight (:files (:defaults "extensions/*"))
  :init
  (vertico-mode)
  ;; Have the prompt at the bottom, where your eyes can find it immediatelly
  ;; (vertico-reverse-mode)
  ;; Grow and shrink the Vertico minibuffer
  (setq vertico-resize t)


  ;; Enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)
  )

(use-package yasnippet
  :init
  (yas-global-mode 1)
  :config
  ;;**** Completion via Yasnippet

  ; Orgmode has an template system: Easy template. I don't like it, since
  ; I already have Yasnippet, which is not compatible with orgmode.

  ;; fix some org-mode + yasnippet conflicts:
  (defun yas/org-very-safe-expand ()
    (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

  (add-hook 'org-mode-hook
          (lambda ()
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)))

(setq yas-snippet-dirs '("~/yasnippets"))

  ; This also lets me use some of the cool orgmode-completion collections
  ; for yasnippets that are out there.
)

(setq inhibit-splash-screen t)
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message nil)
;; If no additional commandline arguments are given, then open the default file. I wrote these lines of emacs lisp myself and I am very proud.

;; It even seems to work with emacs -nw and I don’t know why.

;; (if (equal (length command-line-args) 1)
;;     (setq initial-buffer-choice "~/Desktop/scratchpad.org"))

;; Once this is enabled, you can make the text in a region lowercase with C-x C-l or uppercase with C-x C-u.
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(use-package all-the-icons)

(use-package moody
   :config
   (setq x-underline-at-descent-line t)
   (moody-replace-mode-line-buffer-identification)
   (moody-replace-vc-mode)
   (moody-replace-eldoc-minibuffer-message-function))

(set 'moody-mode-line-height 20)

(use-package beacon)
(beacon-mode 1)

(use-package company)
(add-hook 'after-init-hook 'global-company-mode)

(use-package denote
  :hook
  (;; If you use plain text files (.txt), then you want to make the
   ;; Denote links clickable (Org mode and Markdown mode render links
   ;; as buttons right away and provide commands to open them)
   (text-mode . denote-fontify-links-mode)))
;; (require 'denote)

(use-package denote-search)
;; Remember to check the doc strings of those variables.
(setq denote-directory (expand-file-name "~/Projects/github/org-denote-blog-forge/notes/"))
(setq denote-known-keywords '("emacs" "philosophy" "politics" "economics"))
(setq denote-infer-keywords t)
(setq denote-sort-keywords t)
(setq denote-file-type 'org) ; Org is the default, set others here
(setq denote-prompts '(title keywords))
(setq denote-excluded-directories-regexp nil)
(setq denote-excluded-keywords-regexp nil)
(setq denote-rename-buffer-mode t)

;; Pick dates, where relevant, with Org's advanced interface:
(setq denote-date-prompt-use-org-read-date t)

;; Read this manual for how to specify `denote-templates'.  We do not
;; include an example here to avoid potential confusion.

;; We allow multi-word keywords by default.  The author's personal
;; preference is for single-word keywords for a more rigid workflow.
(setq denote-allow-multi-word-keywords t)

(setq denote-date-format nil) ; read doc string

;; By default, we do not show the context of links.  We just display
;; file names.  This provides a more informative view.
(setq denote-backlinks-show-context t)

;; Also see `denote-link-backlinks-display-buffer-action' which is a bit
;; advanced.

;; If you use Markdown or plain text files (Org renders links as buttons
;; right away)
;; (add-hook 'find-file-hook #'denote-link-buttonize-buffer)

;; We use different ways to specify a path for demo purposes.
(setq denote--directories
      (list denote-directory
            (thread-last denote-directory (expand-file-name "attachments"))
            (expand-file-name "~/Documents/books")))

;; Generic (great if you rename files Denote-style in lots of places):
;; (add-hook 'dired-mode-hook #'denote-dired-mode)
;;
;; OR if only want it in `denote-dired-directories':
;; (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)


;; Denote DOES NOT define any key bindings.  This is for the user to
;; decide.  For example:
(let ((map global-map))
  (define-key map (kbd "C-c n n") #'denote)
  (define-key map (kbd "C-c n N") #'denote-type)
  (define-key map (kbd "C-c n f") #'denote-open-or-create)
  (define-key map (kbd "C-c n l") #'denote-link)
  (define-key map (kbd "C-c n b") #'denote-backlinks)
  (define-key map (kbd "C-c n d") #'denote-date)
  (define-key map (kbd "C-c n s") #'denote-subdirectory)
  (define-key map (kbd "C-c n t") #'denote-template)
  ;; If you intend to use Denote with a variety of file types, it is
  ;; easier to bind the link-related commands to the `global-map', as
  ;; shown here.  Otherwise follow the same pattern for `org-mode-map',
  ;; `markdown-mode-map', and/or `text-mode-map'.
  ;; (define-key map (kbd "C-c n i") #'denote-link) ; "insert" mnemonic
  (define-key map (kbd "C-c n r") #'denote-rename-file)
  (define-key map (kbd "C-c n R") #'denote-rename-file-using-front-matter))

(use-package denote-explore
  ;; :custom
  ;; Where to store network data and in which format
  ;; (denote-explore-network-directory "<your preferred folder>")
  ;; (denote-explore-network-filename "denote-network")
  ;; (denote-explore-network-keywords-ignore "<keywords list>")
  ;; (denote-explore-network-regex-ignore "<regex>")
  ;; (denote-explore-network-format 'd3.js)
  ;; (denote-explore-network-d3-colours 'SchemeObservable10)
  ;; (denote-explore-network-d3-js "https://d3js.org/d3.v7.min.js")
  ;; (denote-explore-network-d3-template "<file path>")
  ;; (denote-explore-network-graphviz-header "<header strings>")
  ;; (denote-explore-network-graphviz-filetype 'svg)
  :bind
  (;; Statistics
   ("C-c e s n" . denote-explore-count-notes)
   ("C-c e s k" . denote-explore-count-keywords)
   ("C-c e s e" . denote-explore-barchart-filetypes)
   ("C-c e s w" . denote-explore-barchart-keywords)
   ("C-c e s t" . denote-explore-barchart-timeline)
   ;; Random walks
   ("C-c e w n" . denote-explore-random-note)
   ("C-c e w r" . denote-explore-random-regex)
   ("C-c e w l" . denote-explore-random-link)
   ("C-c e w k" . denote-explore-random-keyword)
   ;; Denote Janitor
   ("C-c e j d" . denote-explore-duplicate-notes)
   ("C-c e j D" . denote-explore-duplicate-notes-dired)
   ("C-c e j l" . denote-explore-missing-links)
   ("C-c e j z" . denote-explore-zero-keywords)
   ("C-c e j s" . denote-explore-single-keywords)
   ("C-c e j r" . denote-explore-rename-keywords)
   ("C-c e j y" . denote-explore-sync-metadata)
   ("C-c e j i" . denote-explore-isolated-files)
   ;; Visualise denote
   ("C-c e n" . denote-explore-network)
   ("C-c e r" . denote-explore-network-regenerate)
   ("C-c e d" . denote-explore-barchart-degree)
   ("C-c e b" . denote-explore-barchart-backlinks)))

;; Key bindings specifically for Dired.
;; (let ((map dired-mode-map))
;;   (define-key map (kbd "C-c C-d C-i") #'denote-link-dired-marked-notes)
;;   (define-key map (kbd "C-c C-d C-r") #'denote-dired-rename-marked-files)
;;   (define-key map (kbd "C-c C-d C-R") #'denote-dired-rename-marked-files-using-front-matter))

(use-package ivy
  :defer t
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))


(use-package counsel
  :after ivy
  :bind (("M-x" . counsel-M-x)
         ("C-x C-f" . counsel-find-file)
         :map minibuffer-local-map
         ("C-r" . counsel-minibuffer-history))
  :config
  (setq ivy-initial-inputs-alist nil)
  (counsel-mode 1))

(use-package ivy-rich
  :after ivy
  :config
  (ivy-rich-mode 1))

(use-package ivy-prescient
  :after counsel
  :config
  (ivy-prescient-mode 1)
  (prescient-persist-mode 1)
  (setq prescient-sort-length-enable nil))

(use-package savehist
  :init
  (savehist-mode 1))


(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-defaults nil))

;; Ivy Rich for having M-x description and keybinds

;; (use-package ivy-rich
;;   :after counsel
;;   :init (ivy-rich-mode 1))
;; ;; Ivy floating

;; (use-package ivy-posframe
;;   :after ivy
;;   :diminish
;;   :custom-face
;;   (ivy-posframe-border ((t (:background "#ffffff"))))
;;   :config
;;   (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-top-center))
;;         ivy-posframe-height-alist '((t . 20))
;;         ivy-posframe-parameters '((internal-border-width . 10)))
;;   (setq ivy-posframe-width 120)
;;   (setq ivy-posframe-parameters
;;       '((left-fringe . 8)
;;           (right-fringe . 8)))

;;   (ivy-posframe-mode +1))

(add-hook 'org-mode-hook 'org-indent-mode)
 
(setq org-display-inline-images t)
(setq org-redisplay-inline-images t)
(setq org-startup-with-inline-images t)

;;  to exclude specific headings from the export options.
(setq org-export-exclude-tags '("noexport")) ; In Emacs, you can use the `org-set-property` command (`C-c C-x p`) to enter properties for a heading in Org mode. To select from a list of available properties, you can use the `org-property-action` command (`C-c C-x C-p`). Here's how you can use these shortcuts:

;; (global-set-key (kbd "C-c SPC") 'set-mark-command)


(setq org-highest-priority ?A)  ;; Set the highest priority to 'A'
(setq org-lowest-priority ?D)   ;; Set the lowest priority to 'D'

(setq org-priority-faces
      '((?A . error)  ;; Priority 'A' with an error face
        (?B . warning)  ;; Priority 'B' with a warning face
        (?C . success)  ;; Priority 'C' with a success face
        (?D . (foreground-color . "gray"))))  ;; Priority 'D' with a custom face

(setq org-priority-names '((?A . "High")
                          (?B . "Medium")
                          (?C . "Low")
                          (?D . "Optional")))

(use-package elfeed
  :config
  ;; It is recommended that you make a global binding for elfeed.
  (global-set-key (kbd "C-x w") 'elfeed)
  (global-set-key (kbd "C-x y") 'elfeed-update)

  (setq elfeed-feeds
        '("http://nullprogram.com/feed/"
          "https://blume.vc/funds/feed.xml"
          "https://blume.vc/news/feed.xml"
          "https://blume.vc/newsletters/feed.xml"
          "https://blume.vc/offers/feed.xml"
          "https://high-capacity.substack.com/feed"
          "https://blume.vc/reports/feed.xml"
          "Collab Fund — https://feeds.feedburner.com/collabfund"
          "https://finshots.in/archive/rss/"
	  "https://moz.com/posts/rss/blog"
	  "http://feeds.feedburner.com/BusinessAnalystTimes-BusinessAnalysisHome"
	  "https://www.bridging-the-gap.com/feed/"
	  "https://businessanalyst.techcanvass.com/feed"
	  "https://adrianreed.co.uk/page/7/feed"
	  "https://mechanicalbooster.com/feed"
	  "https://blogmech.com/feed"
	  "https://fractory.com/feed"
	  "https://mechanicaljungle.com/feed"
	  "https://www.theengineerspost.com/feed"
	  "https://www.datasciencecentral.com/feed/format"
	  "https://dataaspirant.com/feed/"
	  "https://rweekly.org/rss"
	  "https://www.sqlservercentral.com/blogs/feed"
	  "https://www.mmsonline.com/rss/all"
	  "https://www.practicalmachinist.com/feed/"
	  "https://webengage.com/blog/feed/"
	  "https://www.practicalecommerce.com/feed"
	  "https://rhodus.substack.com/feed"
          "https://indiadatahub.substack.com/feed"
          "https://shantanugoel.com/index.xml"))

  (setq elfeed-show-mode-hook
        (lambda ()
          (set-face-attribute 'variable-pitch (selected-frame) :font (font-spec :family "Victor Mono Oblique" :size 14))
          (setq fill-column 120)
          (setq elfeed-show-entry-switch #'my-show-elfeed)))
(defun my-show-elfeed (buffer)
  (with-current-buffer buffer
    (setq buffer-read-only nil)
    (goto-char (point-min))
    (re-search-forward "\n\n")
    (fill-individual-paragraphs (point) (point-max))
    (setq buffer-read-only t))
  (switch-to-buffer buffer))
  
  (defun my-elfeed-show-hook ()
    "Enable visual line mode in elfeed show mode."
    (visual-line-mode 1))

  (add-hook 'elfeed-show-mode-hook 'my-elfeed-show-hook))

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)

(use-package golden-ratio)
(golden-ratio-mode 1)

(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

(use-package org-modern)
;; Option 2: Globally
(with-eval-after-load 'org (global-org-modern-mode))
;; (setq org-modern-star 'replace)

(use-package ox-pandoc)
(electric-pair-mode 1)

(use-package org-mind-map)

(use-package hacker-typer)

(use-package transient)
;; (use-package vterm)
;; (use-package magit)

(use-package dashboard
  :config
  (dashboard-setup-startup-hook))

(setq TeX-view-program-list
      '(("Sumatra PDF" "\"C:/Program Files/SumatraPDF/SumatraPDF.exe\" -reuse-instance %o")))
(setq TeX-view-program-selection '((output-pdf "Sumatra PDF")))

(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-PDF-mode t)

(use-package with-editor)
;; (use-package transient)
(use-package magit)
(setq org-return-follows-link t)

(use-package consult
  :bind (("C-x b" . consult-buffer)	;seaarch across all open buffers
         ("C-c M-x" . consult-mode-command) ;
	 ("C-c o" . consult-outline)
	 ("C-c r" . consult-ripgrep)
	 ("M-y" . consult-yank-pop)
         ("C-c k" . consult-kmacro)
         ("C-c h" . consult-history)
         ("C-c m" . consult-mark)
         ("C-c i" . consult-imenu)))

;; (use-package consult-denote
;;   :bind
;;   (("C-c n c" . consult-denote-find)
;;    ("C-c n g" . consult-denote-grep))
;;   :config
;;   (consult-denote-mode 1))

(use-package denote-org
  :commands
  ;; I list the commands here so that you can discover them more
  ;; easily.  You might want to bind the most frequently used ones to
  ;; the `org-mode-map'.
  ( denote-org-link-to-heading
    denote-org-backlinks-for-heading

    denote-org-extract-org-subtree

    denote-org-convert-links-to-file-type
    denote-org-convert-links-to-denote-type

    denote-org-dblock-insert-files
    denote-org-dblock-insert-links
    denote-org-dblock-insert-backlinks
    denote-org-dblock-insert-missing-links
    denote-org-dblock-insert-files-as-headings))

(use-package denote-journal
  ;; Bind those to some key for your convenience.
  :commands ( denote-journal-new-entry
              denote-journal-new-or-existing-entry
              denote-journal-link-or-create-entry )
  :hook (calendar-mode . denote-journal-calendar-mode)
  :config
  ;; Use the "journal" subdirectory of the `denote-directory'.  Set this
  ;; to nil to use the `denote-directory' instead.
  (setq denote-journal-directory
        (expand-file-name "journal" denote-directory))
  ;; Default keyword for new journal entries. It can also be a list of
  ;; strings.
  (setq denote-journal-keyword "journal")
  ;; Read the doc string of `denote-journal-title-format'.
  (setq denote-journal-title-format 'day-date-month-year))
;; (use-package denote-merge)
;; (use-package org-glossary
;;   :straight (:host github :repo "tecosaur/org-glossary"))
;; beautify links in org mode

;; (use-package org-link-beautify
;;   :config
;;   (add-hook 'after-init-hook #'org-link-beautify-mode)

;;   (org-link-beautify-mode 1) ; (ref:toggle org-link-beautify-mode)
;;   ;; You can toggle this option carefully to improve Org org-activate-links performance:
;;   (setq org-element-use-cache t)
;;   :hook (org-mode . org-link-beautify-mode))

(use-package listen)
