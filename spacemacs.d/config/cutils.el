;;; cutils --- useful functions
;;; Commentary:


;; STRINGS

(defun psz-s-trim-l (s)
  "Remove whitespace at the beginning of S."
  (if (string-match "\\`[ \t\n\r]+" s)
      (replace-match "" t t s)
    s))

(defun psz-s-trim-r (s)
  "Remove whitespace at the end of S."
  (if (string-match "[ \t\n\r]+\\'" s)
      (replace-match "" t t s)
    s))

(defun psz-s-trim (s)
  "Remove whitespace at the beginning and end of S."
  (s-trim-left (s-trim-right s)))

(defun psz-s-empty-p (string)
  "Return true if the string is empty or nil. Expects string."
  (or (null string)
      (zerop (length (psz-s-trim string)))))

(provide 'cutils)

;;; cutils.el ends here
