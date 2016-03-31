
;;; config-mu4e --- configuration for mu4e
;;; Commentary:

(defun psz//config-mu4e ()
 ;;; Code:

  ;;; Set up some common mu4e variables
  (setq mu4e-maildir "~/.mail"
        ;; mu4e-trash-folder "/Trash"
        ;; mu4e-refile-folder "/Archive"
        mu4e-update-interval nil
        mu4e-compose-signature-auto-include nil
        mu4e-view-show-images t
        mu4e-view-show-addresses t)

;;; Mail directory shortcuts
  (setq mu4e-maildir-shortcuts
        '(("/gmail/INBOX" . ?g)
          ("/college/Inbox" . ?c)))

;;; Bookmarks
  (setq mu4e-bookmarks
        `(("flag:unread AND NOT flag:trashed" "Unread messages" ?u)
          ("date:today..now" "Today's messages" ?t)
          ("date:7d..now" "Last 7 days" ?w)
          ("mime:image/*" "Messages with images" ?p)
          (,(mapconcat 'identity
                       (mapcar
                        (lambda (maildir)
                          (concat "maildir:" (car maildir)))
                        mu4e-maildir-shortcuts) " OR ")
           "All inboxes" ?i)))

  (setq mu4e-account-alist
        '(("gmail"
           (mu4e-sent-messages-behavior delete)
           (mu4e-sent-folder "/gmail/sent")
           (mu4e-drafts-folder "/gmail/draft")
           (mu4e-trash-folder "/gmail/trash")
           (mu4e-refile-folder "/gmail/arch")
           (user-mail-address "itsjustheham@gmail.com")
           (user-full-name "Paul")
           (mu4e-headers-skip-duplicates t)
           (mu4e-get-mail-command "mbsync gmail")
           (mu4e-change-filenames-when-moving t)
           )
          )
        )
  (mu4e/mail-account-reset)

  )

(with-eval-after-load 'mu4e (psz//config-mu4e))

(provide 'config-mu4e)

;;; config-org.el ends here
