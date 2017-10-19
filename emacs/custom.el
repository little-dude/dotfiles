(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-idle-delay 0)
 '(company-minimum-prefix-length 1)
 '(custom-safe-themes
   (quote
    ("669e02142a56f63861288cc585bee81643ded48a19e36bfdf02b66d745bcc626" "ea71faa917045669be7b7450930b59460e61816a59c1d4026acba806951e194c" "10461a3c8ca61c52dfbbdedd974319b7f7fd720b091996481c8fb1dded6c6116" "04232a0bfc50eac64c12471607090ecac9d7fd2d79e388f8543d1c5439ed81f5" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(org-agenda-files (quote ("~/documents/org/todo.org")))
 '(org-archive-location "~/documents/org/archive.org")
 '(org-directory "~/documents/org/")
 '(org-display-custom-times t)
 '(org-log-done (quote note))
 '(org-log-into-drawer t)
 '(org-log-reschedule (quote note))
 '(org-time-stamp-custom-formats (quote ("<%a %e %b %y>" . "<%a %e %b %y %Hh%M>")))
 '(package-selected-packages
   (quote
    (yaml-mode forge flycheck-joker vimrc-mode command-log-mode lispyville lispy rg exec-path-from-shell go-eldoc go-mode fill-column-indicator gruvbox-theme zenburn-theme org-bullets uniquify auto-dim-other-buffers undo-tree rainbow-delimiters elpy flycheck-pycheckers company-anaconda anaconda-mode dracula-theme rebecca-theme moe-theme doom-themes es-mode expand-region sql-indent sqlformat sqlup-mode cider clojure-mode flycheck-clojure treemacs-magit paredit use-package magit treemacs-projectile treemacs projectile-codesearch counsel-projectile projectile company-lsp lsp-ui flycheck lsp-go lsp-mode lsp-python lsp-rust solarized-theme rust-mode rust-playground counsel hydra all-the-icons-ivy company company-jedi company-racer ivy)))
 '(safe-local-variable-values
   (quote
    ((eval let*
           ((dir
             (dir-locals-find-file "."))
            (root-dir
             (if
                 (stringp dir)
                 dir
               (car dir))))
           (pyvenv-activate
            (concat root-dir "env")))
     (eval let
           ((root-dir
             (let
                 ((d
                   (dir-locals-find-file ".")))
               (if
                   (stringp d)
                   d
                 (car d)))))
           (pyvenv-activate
            (concat root-dir "env")))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(rainbow-delimiters-depth-1-face ((t (:foreground "wheat"))))
 '(rainbow-delimiters-unmatched-face ((t (:background "dark gray" :foreground "red")))))
