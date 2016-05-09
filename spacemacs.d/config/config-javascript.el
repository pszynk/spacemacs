
(defun psz//config-javascript ()

  (setq-default
   ;; js2-mode
   js2-basic-offset 2
   ;; web-mode
   css-indent-offset 2
   web-mode-markup-indent-offset 2
   web-mode-css-indent-offset 2
   web-mode-code-indent-offset 2
   web-mode-attr-indent-offset 2)

  (with-eval-after-load 'web-mode
    (add-to-list 'web-mode-indentation-params '("lineup-args" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-concats" . nil))
    (add-to-list 'web-mode-indentation-params '("lineup-calls" . nil)))

  (defun psz//use-eslint-from-node-modules ()
    (let* ((root (locate-dominating-file
                  (or (buffer-file-name) default-directory)
                  "node_modules"))
           (global-eslint (executable-find "eslint"))
           (local-eslint (expand-file-name "node_modules/.bin/eslint"
                                           root))
           (eslint (if (file-executable-p local-eslint)
                       local-eslint
                     global-eslint))
           (message "print eslint:")
           (message eslint)
           )
      (setq-local flycheck-javascript-eslint-executable eslint)))

  ;; (with-eval-after-load 'flycheck
  ;;   (flycheck-add-mode 'javascript-eslint 'js2-mode))

  (add-hook 'js2-mode-hook #'psz//use-eslint-from-node-modules)

  (with-eval-after-load 'js2-mode
    (setq-default flycheck-disabled-checkers
                  (append flycheck-disabled-checkers '(javascript-jshint))))
  )



(psz//config-javascript)

(provide 'config-javascript)




