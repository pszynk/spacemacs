;;; config-latex --- configuration for TeX/LaTeX
;;; Commentary:

(defun psz//config-latex ()
 ;;; Code:

  ;; (setq TeX-view-program-list
  ;;              '(("Zathura"
  ;;                ("zathura "
  ;;                 (mode-io-correlate " --synctex-forward %n:0:%b -x \"emacsclient +%{line} %{input}\" ")
  ;;                 " %o")
  ;;                "zathura")))
  ;; (setq TeX-view-program-selection
  ;;       '((output-pdf "Zathura"))
  ;;       ;;         (output-dvi "xdvi")
  ;;       )
  (add-to-list 'TeX-view-program-list
               '("Zathura"
                 ("zathura "
                  (mode-io-correlate " --synctex-forward %n:0:%b -x \"emacsclient +%{line} %{input}\" ")
                  " %o")
                 "zathura")
               )
  (add-to-list 'TeX-view-program-selection
               '(output-pdf "Zathura")
               )

  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-start-server t)
  (setq TeX-source-correlate-method 'synctex)
  )

;; (add-hook 'LaTeX-mode-hook 'psz//config-latex)

(with-eval-after-load 'latex (psz//config-latex))

(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(provide 'config-latex)

;;; config-latex.el ends here
