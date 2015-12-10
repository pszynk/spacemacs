
;; Latex
(defun pszynk//config-latex ()
;;  (setq TeX-view-program-list '(("zathura" zathura-forward-search)))
;;  (setq TeX-view-program-selection
;;        '(
;;          (output-pdf "zathura")
;;          (output-dvi "xdvi")
;;          ))
  (setq TeX-source-correlate-mode t)
  (setq TeX-source-correlate-start-server t)
  (setq TeX-source-correlate-method 'synctex)
  (message "__pszynk__: latex config loaded")
  )

(add-hook 'LaTeX-mode-hook 'pszynk//config-latex)
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

(provide 'config-latex)
