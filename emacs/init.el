;; Setup package.el
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(unless package--initialized (package-initialize))

;; load our shell environment
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Setup use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Offload the custom-set-variables to a separate file
;; This keeps your init.el neater and you have the option
;; to gitignore your custom.el if you see fit.
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; maximize the emacs window on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Disable menu-bar, tool-bar, and scroll-bar.
(if (fboundp 'menu-bar-mode)
    (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode)
    (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode)
    (scroll-bar-mode -1))

(setq inhibit-startup-screen t)           ; Disable startup screen
(setq initial-scratch-message "")         ; Make *scratch* buffer blank
(setq-default frame-title-format '("%b")) ; Make window title the buffer name
(set-frame-font "-CYEL-Iosevka-normal-normal-normal-*-18-*-*-*-d-0-iso10646-1")
(setq linum-format "%4d ")                ; Prettify line number format
(add-hook 'prog-mode-hook                 ; Show line numbers in programming modes
          (if (fboundp 'display-line-numbers-mode)
              #'display-line-numbers-mode
            #'linum-mode))

(global-hl-line-mode +1) ; highlight the line where the cursor is

;; Avoid littering the user's filesystem with backups
(setq backup-by-copying t                    ; don't clobber symlinks
      backup-directory-alist
      '((".*" . "~/.emacs.d/saves/"))        ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups

;; Lockfiles unfortunately cause more pain than benefit
(setq create-lockfiles nil)

(use-package dockerfile-mode
  :ensure t
  :config (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

(use-package use-package-chords
  :ensure t
  :config
  (key-chord-mode 1)
  ;; The default value is 0.1 but it's a bit short. The problem is
  ;; that it kinda feels slow when moving with `j` or `k` if we set it
  ;; to 0.2.
  (setq key-chord-two-keys-delay 0.2))

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :chords (("jk" . evil-normal-state))
  :config
  (evil-mode 1)
  ;; Use vim-like search.
  (evil-select-search-module 'evil-search-module 'evil-search)
  (define-key evil-normal-state-map "s" nil)
  (define-key evil-normal-state-map (kbd "ss") 'evil-window-split)
  (define-key evil-normal-state-map (kbd "sv") 'evil-window-vsplit)
  (define-key evil-normal-state-map (kbd "sr") 'evil-window-rotate-downwards)

  (define-key evil-normal-state-map (kbd "M-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "M-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "M-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "M-l") 'evil-window-right)

  (define-key evil-normal-state-map (kbd "C-M-h") 'evil-window-move-far-left)
  (define-key evil-normal-state-map (kbd "C-M-j") 'evil-window-move-very-bottom)
  (define-key evil-normal-state-map (kbd "C-M-k") 'evil-window-move-very-top)
  (define-key evil-normal-state-map (kbd "C-M-l") 'evil-window-move-far-right)

  (define-key evil-normal-state-map (kbd "C-=") 'balance-windows)
  (define-key evil-normal-state-map (kbd "C-s z") 'delete-other-windows)

  ;; (define-key evil-normal-state-map (kbd "no") 'highlight-remove-all)
  )

;; See https://emacs.stackexchange.com/a/9584/22105
(defadvice evil-inner-word (around iw-motion activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?- "w" table)
    (with-syntax-table table ad-do-it)))

(defadvice evil-forward-word-begin (around w-motion activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?- "w" table)
    (with-syntax-table table ad-do-it)))

(defadvice evil-forward-word-end (around e-motion activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?- "w" table)
    (with-syntax-table table ad-do-it)))

(defadvice evil-backward-word-begin (around b-motion activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?- "w" table)
    (with-syntax-table table ad-do-it)))

(defadvice evil-backward-word-end (around ge-motion activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?- "w" table)
    (with-syntax-table table ad-do-it)))

(defadvice evil-a-word (around a-word activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?- "w" table)
    (with-syntax-table table ad-do-it)))

(defadvice evil-inner-word (around inner-word activate)
  (let ((table (copy-syntax-table (syntax-table))))
    (modify-syntax-entry ?_ "w" table)
    (modify-syntax-entry ?- "w" table)
    (with-syntax-table table ad-do-it)))


;; Allows to see which commands are being called:
;; - command-log-mode
;; - clm/open-command-log-buffer
(use-package command-log-mode)

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-magit
  :config
  (evil-define-key* evil-magit-state magit-mode-map [escape] nil))

;; colorful parenthesis
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode)
  :custom-face
  (rainbow-delimiters-unmatched-face ((t (:background "dark gray" :foreground "red"))))
  (rainbow-delimiters-depth-1-face ((t (:foreground "wheat")))))
(show-paren-mode 1)
(setq show-paren-delay 0)

(use-package treemacs
  :config
  (setq treemacs-show-cursor nil)
  :bind
  (([f9] . treemacs)))

(use-package treemacs-evil)

(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)

(use-package treemacs-icons-dired
  :after treemacs dired
  :ensure t
  :config (treemacs-icons-dired-mode))

(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package auto-dim-other-buffers
  :diminish auto-dim-other-buffers-mode
  :init (auto-dim-other-buffers-mode))

;; (use-package gruvbox-theme
;;   :config (load-theme 'gruvbox t))
(use-package atom-one-dark-theme
  :config
  (load-theme 'atom-one-dark)
  (custom-theme-set-faces
   'atom-one-dark
   ;; - see which face we want to customize: C-u C-x =
   ;; - describe a face: `describe-face`
   ;; - list colors: `list-colors-display`
   ;; - list of attributes we can customize: https://github.com/syl20bnr/spacemacs/tree/master/layers/%2Bthemes/theming#attributes
   ;;
   ;; The cyan is pretty terrible when working with lots of keywords with hiccup
   ;; Other things I tried:
   ;; - (:foreground "#E5C07B") a nice yellow but still a bit tiring. Could be used for something else though
   ;; - (:foreground "sienna") a maroon that is pretty warm but also quite ugly.
   '(clojure-keyword-face ((t (:foreground "seashell4" :slant italic))))))

; we highlight the current line, but it's too pale with atom-one-dark so we override it here
(set-face-background hl-line-face "gray0")

(use-package uniquify
  :ensure nil
  :config
  (setq uniquify-buffer-name-style 'forward)
  (setq uniquify-separator "/")
  (setq uniquify-after-kill-buffer-p t)     ; rename after killing uniquified
  (setq uniquify-ignore-buffers-re "^\\*")) ; don't muck with special buffers

(setq-default indent-tabs-mode nil) ; disable hard tabs
(setq-default tab-width 4) ; default tab width is 4, not 8
;; make TAB actually insert a tab instead of auto-indenting the current line
;;
;; FIXME: instead of blindly inserting a tab, this should add an indentation level. For instance:
;; - with (indent-tabs-mode nil) and (tab-width 4), if the cursor is at column 6, it should insert 2 spaces
;; - with (indent-tabs-mode nil) and (tab-width 4), if the cursor is at column 4, it should insert 4 spaces
;; - with (indent-tabs-mode t) is should insert a \t
(setq-default tab-always-indent nil)
;; FIXME: RET should insert enough tabs to match the previous line's indentation

(use-package company
  :custom
  ;; delay to start completion
  (company-idle-delay 0)
  ;; nb of chars before triggering completion
  (company-minimum-prefix-length 1)

  :config
  ;; enable company-mode in all buffers
  (global-company-mode)

  :bind
  ;; use <C> instead of <M> to navigate completions
  (:map company-active-map
	      ("M-n" . nil)
	      ("M-p" . nil)
	      ("C-n" . #'company-select-next)
	      ("C-p" . #'company-select-previous)))

(use-package projectile
  :init
  (projectile-mode +1)
  :config
  (counsel-projectile-mode)
  :bind
  (:map projectile-mode-map
        ;; Not sure I want to use Super in emacs, since I use it a lot in gnome
        ;; ("s-p" . projectile-command-map)
        ("C-c p" . projectile-command-map)))

(use-package lsp-mode
  :hook
  (rust-mode . lsp))

(use-package company-lsp
  :commands company-lsp
  :config (push 'company-lsp company-backends))

(use-package rust-mode
  :bind
  (:map rust-mode-map
        ("C-c C-c" . rust-compile)
        ("C-c C-t" . rust-test)))

;; we keep our secrets in an encrypted file
(setq auth-sources
    '((:source "~/.config/authinfo.gpg")))

;; (use-package lispy
;;   :hook ((lisp-mode scheme-mode emacs-lisp-mode) . lispy-mode)
;;   :config
;;   (lispy-define-key lispy-mode-map "o" 'lispy-different)
;;   (lispy-define-key lispy-mode-map ">" 'lispy-slurp-or-barf-right)
;;   (lispy-define-key lispy-mode-map "<" 'lispy-slurp-or-barf-left))

;; (use-package lispyville
;;   :hook (lispy-mode . lispyville-mode))

(use-package flycheck
  :init
  ;; (setq flycheck-mode-globals '(not rust-mode))
  (global-flycheck-mode))

(use-package go-mode
  :config
    (go-eldoc-setup)
    (setq gofmt-command "goimports")
    (setq compile-command "go test -v")
    (let ((gopath (getenv "GOPATH"))
          (golint-el "src/golang.org/x/lint/misc/emacs/golint.el"))
      (add-to-list 'load-path (concat gopath "/" golint-el)))
    (require 'golint)
    (defun compile-bench ()
      (interactive
       (let ((cmd  "go test -v --bench . --benchmem"))
         (compile cmd))))
    (defun compile-test ()
      (interactive
       (let ((cmd  "go test -v"))
         (compile cmd))))
    (setq compilation-read-command nil) ; do not ask for confirmation for `compile-command`
    :hook
    ;; see https://emacs.stackexchange.com/questions/5452/before-save-hook-for-cc-mode
    ((go-mode . (lambda () (add-hook 'before-save-hook 'gofmt-before-save nil 'local))))
    :bind (:map go-mode-map
                ("C-c C-c" . compile-test)
                ("C-c C-b" . compile-bench)
                ("C-c C-l" . golint)))

(use-package es-mode
  :init (add-to-list 'auto-mode-alist '("\\.es$" . es-mode))
  :hook ((es-result-mode . hs-minor-mode)))

(use-package cider
  :init
  ;; for some reason, some ultra code still get
  ;; loaded and cider's repl fails to start. To avoid
  ;; that, apply the workaround found at
  ;; https://github.com/venantius/ultra/issues/103#issuecomment-470470888
  (setenv "LEIN_USE_BOOTCLASSPATH" "no")
  :config
  ;; Skip :user section of ~/.lein/profiles.clj when using
  ;; cider-jack-in. See https://github.com/venantius/ultra
  (setq cider-lein-parameters "with-profile emacs repl :headless :host localhost")
  ;; for clojurescript we use yarn, not node, so we have to tweak the
  ;; command a little bit.
  ;; FIXME: this is project specific, this should be a file-local
  (setq cider-shadow-cljs-command "yarn shadow-cljs")
  ;; by default, the shadow-cljs that cider run is `yarn shadow-cljs
  ;; server` but we want to watch the app. FIXME: this is project
  ;; specific so it should be set at the project level instead.
  (setq cider-shadow-cljs-parameters "watch app")
  ;; clojure stacktraces are huge, so make the *Messages* buffers bigger
  (setq message-log-max 100000))

(use-package flycheck-joker)

(use-package magit
  :bind (("C-x g" . magit-status))
  :config
  ;; this is a workaround for https://github.com/magit/forge/issues/87
  ;; it should be removed for emacs 27
  (setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3"
      ghub-use-workaround-for-emacs-bug nil))

(use-package forge
  :after magit)

(use-package ivy
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  ;; by default, the regexp used by ivy to starts with ^, which is
  ;; annoying
  (setq ivy-initial-inputs-alist nil)
  :bind
  (("\C-s" . 'swiper)
   ("M-x" . 'counsel-M-x)
   ("C-x C-f" . 'counsel-find-file)
   (:map minibuffer-local-map ("C-r" . 'counself-minibuffer-history))))

;; ;; take from https://github.com/lunaryorn/old-emacs-configuration/blob/master/init.el
;; (use-package flycheck-virtualenv        ; Setup Flycheck by virtualenv
;;   :load-path "lisp/"
;;   :after python
;;   :commands (my-flycheck-virtualenv-setup)
;;   :hook (python-mode . 'my-flycheck-virtualenv-setup))

(use-package elpy
  ;; Only call `elpy-enable` when needed.
  ;; See: https://emacs.stackexchange.com/q/10065/22105
  :init (with-eval-after-load 'python (elpy-enable))
  :config
  ;; by default, elpy uses flymake. This forces it to use flycheck instead
  ;; See:
  ;;     - https://github.com/jorgenschaefer/elpy/wiki/Customizations#use-flycheck-instead-of-flymake
  ;;     - https://github.com/jorgenschaefer/elpy/issues/137
  (when (require 'flycheck nil t)
    (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
    (add-hook 'elpy-mode-hook 'flycheck-mode)))

(use-package sql
  :config
  ;; with mariadb, the default regexp used to match the prompt is a bit off. This fixes it.
  (sql-set-product-feature 'mysql :prompt-regexp "^\\(MariaDB\\|MySQL\\) \\[[_a-zA-Z]*\\]> "))

(use-package rg
  :config (rg-enable-default-bindings))

;; from https://stackoverflow.com/a/24659949/1836144 see also
;; https://emacs.stackexchange.com/questions/13214/automatically-formatting-sql-code
(defun sql-indent-string ()
  "Indent the string under the cursor as SQL."
  (interactive)
  (save-excursion
    (er/mark-inside-quotes)
    (let* ((text (buffer-substring-no-properties (region-beginning) (region-end)))
           (pos (region-beginning))
           (column (progn (goto-char pos) (current-column)))
           (formatted-text (with-temp-buffer
                             (insert text)
                             (delete-trailing-whitespace)
                             (sql-indent-buffer)
                             (replace-string "\n" (concat "\n" (make-string column (string-to-char " "))) nil (point-min) (point-max))
                             (buffer-string))))
      (delete-region (region-beginning) (region-end))
      (goto-char pos)
      (insert formatted-text))))

(defun load-directory (dir)
  (let ((load-it (lambda (f)
                   (load-file (concat (file-name-as-directory dir) f)))))
    (mapc load-it (directory-files dir nil "\\.el$"))))
(load-directory "~/.emacs.d/lisp/")

(put 'downcase-region 'disabled nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package vimrc-mode
  :init (add-to-list 'auto-mode-alist '("\\.vim\\(rc\\)?\\'" . vimrc-mode)))
