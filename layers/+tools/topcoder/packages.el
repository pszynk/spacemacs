;;; packages.el --- topcoder Layer packages File for Spacemacs
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

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.
(setq topcoder-packages
    '(
      (compile :location built-in)
      ;; winner po co to niby było?
      ansi-color
      ))

;; List of packages to exclude.
(setq topcoder-excluded-packages '())

(defun topcoder/post-init-compile ()
  "Initialize compile"

  (use-package compile
    :defer t
    :config
    )
  )

(defun topcoder/init-ansi-color ()
  "Initialize ansi-color"

  (use-package ansi-color
    :defer t
    :config
    (defadvice display-message-or-buffer (before ansi-color activate)
      "Process ANSI color codes in shell output."
      (let ((buf (ad-get-arg 0)))
        (and (bufferp buf)
             (string= (buffer-name buf) "*Shell Command Output*")
             (with-current-buffer buf
               (ansi-color-apply-on-region (point-min) (point-max))))))
    )
  )

;; Often the body of an initialize function uses `use-package'
;; For more info on `use-package', see readme:
;; https://github.com/jwiegley/use-package

;; (spacemacs/declare-prefix "ot" "topcoder")
