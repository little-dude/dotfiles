;; https://orgmode.org/worg/org-tutorials/orgtutorial_dto.html

;; https://orgmode.org/manual/Activation.html
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c a") 'org-agenda)
(global-set-key (kbd "<f6>") 'org-capture)


(use-package org
  :mode (("\\.org$" . org-mode))

  :custom
  ;; Locations for our org files
  (org-directory "~/documents/org/")
  (org-archive-location "~/documents/org/archive.org")
  (org-agenda-files (list "~/documents/org/todo.org"))

  ;; Force notes to go in the :LOGBOOK: drawer
  (org-log-into-drawer t)

  ;; Display dates as <Mon 01 Jan 19> and <Mon 01 Jan 19 20h00> We do
  ;; not use the full year notation to avoid making the custom format
  ;; longer than the default one.
  ;; https://emacs.stackexchange.com/a/19876/22105
  (org-display-custom-times t)
  (org-time-stamp-custom-formats '("<%a %e %b %y>" . "<%a %e %b %y %Hh%M>"))  

  ;; Write a note when a task if marked as done
  (org-log-done 'note)
  ;; Write a note when a task is rescheduled
  (org-log-reschedule 'note)

  :config
  ;; Capture templates
  (setq org-capture-templates
        '(
          ("i" "Ticket" entry (file "todo.org")
 "* TODO %?%^g
   SCHEDULED %^{departure}T---%^{arrival}T
   %^{FROM}p
   %^{TO}p
   %^{PRICE}p
   :LOGBOOK:
   - Added %U
   :END:"
:empty-lines 1)

          ("t" "Todo" entry (file "todo.org")
"* TODO %?%^g
   SCHEDULED %^t
   :LOGBOOK:
   - Added %U
   :END:"
:empty-lines 1)
          ))
  ;; :bind
  ;; ([remap org-set-tags-command] . counsel-org-tag)
  )


;; (use-package org-super-agenda)

;; (use-package org-bullets
;;   :hook (org-mode . (lambda () (org-bullets-mode 1))))
