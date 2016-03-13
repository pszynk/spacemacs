;;; extensions.el --- Auctex Layer Extensions File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(setq latex-post-extensions
      '(
        zathura
       )
      )

(defun latex/init-zathura ()
  "Initialize zathura"

  ;; (add-hook 'LaTeX-mode-hook
  ;;           (lambda ()
  ;;             (add-to-list 'TeX-view-program-list '("zathura" zathura-forward-search))
  ;;             (add-to-list 'TeX-view-program-selection '(output-pdf "zathura"))
  ;;             )
  ;;           )
  (use-package zathura
    :defer t
    :config
    (add-hook 'LaTeX-mode-hook
              (lambda ()
                (message "loading zathura")
                (add-to-list 'TeX-view-program-list '("zathura" zathura-forward-search))
                (add-to-list 'TeX-view-program-selection '(output-pdf "zathura"))
                )
              )
    ;; (add-to-list 'TeX-view-program-list '("zathura" zathura-forward-search))
    ;; (add-to-list 'TeX-view-program-selection '(output-pdf "zathura"))
    )
  :config
  )
