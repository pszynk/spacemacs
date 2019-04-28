;;; config-spellcheck --- fix for hunspell error
;;; Commentary:

(defun ispell-find-hunspell-dictionaries ()
  "Look for installed Hunspell dictionaries.
Will initialize `ispell-hunspell-dictionary-alist' according
to dictionaries found, and will remove aliases from the list
in `ispell-dicts-name2locale-equivs-alist' if an explicit
dictionary from that list was found."
  (let ((hunspell-found-dicts
         (split-string
          (with-temp-buffer
            (ispell-call-process ispell-program-name
                                 null-device
                                 t
                                 nil
                                 ;; Hunspell 1.7.0 (and later?) won't
                                 ;; show LOADED DICTIONARY unless
                                 ;; there's at least one file argument
                                 ;; on the command line.  So we feed
                                 ;; it with the null device.
                                 "-D" null-device)
            (buffer-string))
          "[\n\r]+"
          t))
        hunspell-default-dict
        hunspell-default-dict-entry
        hunspell-multi-dict)
    (dolist (dict hunspell-found-dicts)
      (let* ((full-name (file-name-nondirectory dict))
             (basename  (file-name-sans-extension full-name))
             (affix-file (concat dict ".aff")))
        (if (string-match "\\.aff$" dict)
            ;; Found default dictionary
            (progn
              (if hunspell-default-dict
                  (setq hunspell-multi-dict
                        (concat (or hunspell-multi-dict
                                    (car hunspell-default-dict))
                                "," basename))
                (setq affix-file dict)
                ;; FIXME: The cdr of the list we cons below is never
                ;; used.  Why do we need a list?
                (setq hunspell-default-dict (list basename affix-file)))
              (ispell-print-if-debug
               "++ ispell-fhd: default dict-entry:%s name:%s basename:%s\n"
               dict full-name basename))
          (if (and (not (assoc basename ispell-hunspell-dict-paths-alist))
                   (file-exists-p affix-file))
              ;; Entry has an associated .aff file and no previous value.
              (let ((affix-file (expand-file-name affix-file)))
                (ispell-print-if-debug
                 "++ ispell-fhd: dict-entry:%s name:%s basename:%s affix-file:%s\n"
                 dict full-name basename affix-file)
                (cl-pushnew (list basename affix-file)
                            ispell-hunspell-dict-paths-alist :test #'equal))
            (ispell-print-if-debug
             "-- ispell-fhd: Skipping entry: %s\n" dict)))))
    ;; Remove entry from aliases alist if explicit dict was found.
    (let (newlist)
      (dolist (dict ispell-dicts-name2locale-equivs-alist)
        (if (assoc (car dict) ispell-hunspell-dict-paths-alist)
            (ispell-print-if-debug
             "-- ispell-fhd: Excluding %s alias.  Standalone dict found.\n"
             (car dict))
          (cl-pushnew dict newlist :test #'equal)))
      (setq ispell-dicts-name2locale-equivs-alist newlist))
    ;; Add known hunspell aliases
    (dolist (dict-equiv ispell-dicts-name2locale-equivs-alist)
      (let ((dict-equiv-key (car dict-equiv))
            (dict-equiv-value (cadr dict-equiv))
            (exclude-aliases (list   ;; Exclude TeX aliases
                              "esperanto-tex"
                              "francais7"
                              "francais-tex"
                              "norsk7-tex")))
        (if (and (assoc dict-equiv-value ispell-hunspell-dict-paths-alist)
                 (not (assoc dict-equiv-key ispell-hunspell-dict-paths-alist))
                 (not (member dict-equiv-key exclude-aliases)))
            (let ((affix-file (cadr (assoc dict-equiv-value
                                           ispell-hunspell-dict-paths-alist))))
              (ispell-print-if-debug "++ ispell-fhd: Adding alias %s -> %s.\n"
                                     dict-equiv-key affix-file)
              (cl-pushnew (list dict-equiv-key affix-file)
                          ispell-hunspell-dict-paths-alist :test #'equal)))))
    ;; Parse and set values for default dictionary.
    (setq hunspell-default-dict (or hunspell-multi-dict
                                    (car hunspell-default-dict)))
    ;; If hunspell-default-dict is nil, ispell-parse-hunspell-affix-file
    ;; will barf with an error message that doesn't help users figure
    ;; out what is wrong.  Produce an error message that points to the
    ;; root cause of the problem.
    (or hunspell-default-dict
        (error "Can't find Hunspell dictionary with a .aff affix file"))
    (setq hunspell-default-dict-entry
	        (ispell-parse-hunspell-affix-file hunspell-default-dict))
    ;; Create an alist of found dicts with only names, except for default dict.
    (setq ispell-hunspell-dictionary-alist
	        (list (cons nil (cdr hunspell-default-dict-entry))))
    (dolist (dict (mapcar #'car ispell-hunspell-dict-paths-alist))
      (cl-pushnew (if (string= dict hunspell-default-dict)
                      hunspell-default-dict-entry
                    (list dict))
                  ispell-hunspell-dictionary-alist :test #'equal))))

(provide 'config-spellcheck)

;;; config-spellcheck.el ends here
