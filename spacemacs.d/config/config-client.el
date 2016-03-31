;;; config-client --- configuration for using emacsclient
;;; Commentary:

(require 'cutils)
(require 'cl-lib)

(defun psz-open-file (fpath &optional fline fcol)
 ;;; Code:

    ;; Load the file
    (find-file fpath)

    ;; Jump to the point if one is given
    ;; (when (not (every 'psz-s-empty-p (list fline fcol)))
    (when (or fline fcol)
      (goto-char (point-min))
      (if fline (forward-line (1- fline)))
      (if fcol (forward-char (1- fcol))))

    ;; Raise/focus our window; depends on the windowing system
    ;; (raise-frame)
    (select-frame-set-input-focus (selected-frame))


    ;; Automatically pick up changes made in IntelliJ
    (auto-revert-mode t)
    )

(defun psz-focus-frame ()
  (x-send-client-message
   nil                ; DISPLAY - nil is selected frame
   0                  ; DEST - 0 is root window of display
   nil                ; FROM - nil is selected frame
   "_NET_ACTIVE_WINDOW"    ; MESSAGE-TYPE - name of an Atom as a string
   32                 ; FORMAT  - size of the values in bits
   '(1 "_NET_WM_USER_TIME" 0) ; VALUES
   )
  )

(defun psz-is-frame-p ()
  (if (> (length (frame-list)) 1) 't)
  )

(provide 'config-client)

;;; config-client.el ends here
