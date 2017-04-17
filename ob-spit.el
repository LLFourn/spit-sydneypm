;;; ob-spit.el --- Execute Spit code within org-mode blocks

;;; Commentary:
;;
;; run spit snippets


;;; Code:
(require 'org)
(require 'ob)


(defgroup ob-spit nil
  "org-mode blocks for Spit"
  :group 'org)

(defcustom ob-spit:default-spit nil
  "Default Spit interpreter to use"
  :group 'ob-spit
  :type 'string
  )

(defvar org-babel-default-header-args:spit '())

(add-to-list 'org-babel-default-header-args:spit '(:wrap . "src shell"))


;;;###autoload
(defun org-babel-execute:spit (body params)
  "org-babel spit hook."
   (let* ((in-docker (cdr (assoc :in-docker params)))
          (os (cdr (assoc :os params)))
          (run (assoc :run params))
          (opts (cdr (assoc :opts params)))
          (cmd (list
                 "spit"
                 (when in-docker (concat "--in-docker=" in-docker))
                 (when os        (concat "--os=" os))
                 (when run       (concat "--run"))
                 (when opts      (concat "--opts=" opts))
                 "eval"
                 ))
          (derp (prin1 (mapconcat 'identity cmd " ")))
          )
     (org-babel-eval (mapconcat 'identity cmd " ") body)
     )
  )


;;;###autoload
(eval-after-load "org"
  '(add-to-list 'org-src-lang-modes '("spit" . spit)))

(provide 'ob-spit)


;;; ob-perl6.el ends here
