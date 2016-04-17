;;; config-org --- configuration for Org mode
;;; Commentary:

(require 'f)

(defun psz//config-org ()
 ;;; Code:

  ;; try set org-directory from env
  (setq org-directory
        (f-join (cond
                  ((getenv "PERSONAL_DIR"))
                  (t "~/org"))
                "org")
        )

  (setq org-default-notes-file (f-join org-directory "organizer.org"))
  (setq org-agenda-files (f-join org-directory "agenda.org"))

  ;; refile search org files up to 6 levels
  (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))

  ;; active Babel languages
  (org-babel-do-load-languages
   'org-babel-load-languages
   '(
     ;; (C . t)
     ;; (cpp . t)
     (emacs-lisp . t)
     ;; (haskell . t)
     ;; (java . t)
     ;; (js . t)
     ;; (latex . t)
     (python . t)
     ;; (R . t)
     (shell . t)
     (sql . t)
     ;; (sqlite . t)
     )
   )

  (set-face-attribute 'org-agenda-date-today nil :inherit 'bold :foreground "cyan" :slant 'italic :height 1.2)
  (set-face-attribute 'org-agenda-date-weekend nil :inherit 'bold :foreground "plum")
  )

(with-eval-after-load 'org (psz//config-org))

(provide 'config-org)

;;; config-org.el ends here
