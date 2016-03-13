;;; config-org --- configuration for Org mode
;;; Commentary:

(defun pszynk//config-org ()
 ;;; Code:

  ;; try set org-directory from env
  (setq org-directory
        (cond
         ((getenv "PERSONAL_DIR"))
         (t "~/org")))

  (setq org-default-notes-file (f-join org-directory "organizer.org"))

  ;; refile search org files up to 6 levels
  (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))
  )

(with-eval-after-load 'org (pszynk//config-org))

(provide 'config-org)

;;; config-org.el ends here
