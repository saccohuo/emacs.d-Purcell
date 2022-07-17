;;; init org-export

;;; set css style when export org file to html or pdf
;; put your css files there
(defvar org-theme-css-dir "~/.emacs.d/export-themes/org-css/")

(defun toggle-org-custom-inline-style ()
  (interactive)
  (let ((hook 'org-export-before-parsing-hook)
        (fun 'set-org-html-style))
    (if (memq fun (eval hook))
        (progn
          (remove-hook hook fun 'buffer-local)
          (message "Removed %s from %s" (symbol-name fun) (symbol-name hook)))
      (add-hook hook fun nil 'buffer-local)
      (message "Added %s to %s" (symbol-name fun) (symbol-name hook)))))

(defun org-theme ()
  (interactive)
  (let* ((cssdir org-theme-css-dir)
         (css-choices (directory-files cssdir nil ".css$"))
         (css (completing-read "theme: " css-choices nil t)))
    (concat cssdir css)))

(defun set-org-html-style (&optional backend)
  (interactive)
  (when (or (null backend) (eq backend 'html))
    (let ((f (or (and (boundp 'org-theme-css) org-theme-css) (org-theme))))
      (if (file-exists-p f)
          (progn
            (set (make-local-variable 'org-theme-css) f)
            (set (make-local-variable 'org-html-head)
                 (with-temp-buffer
                   (insert "<style type=\"text/css\">\n<!--/*--><![CDATA[/*><!--*/\n")
                   (insert-file-contents f)
                   (goto-char (point-max))
                   (insert "\n/*]]>*/-->\n</style>\n")
                   (buffer-string)))
            (set (make-local-variable 'org-html-head-include-default-style)
                 nil)
            (message "Set custom style from %s" f))
        (message "Custom header file %s doesnt exist")))))


;;Don't display validate in the bottom of html when export
(setq org-html-validation-link nil)


;; support for MathJax 3.x
;; 还是不支持 SIunitx
(setq org-html-mathjax-template
      "<script type=\"text/javascript\" id=\"MathJax-script\" async src=\"%PATH\"></script>
<script type=\"text/x-mathjax-config\">
window.MathJax = {
  loader: {
    load: ['[tex]/autoload', '[tex]/ams', '[tex]/color', '[tex]/cancel', '[tex]/physics','[tex]/mathtools', '[tex]/colortbl', '[tex]/gensymb', '[tex]/centernot', '[tex]/colorv2', '[tex]/empheq', '[tex]/textcomp', '[tex]/upgreek', '[tex]/cases']
  },
  tex: {
    tags: \"ams\",
    packages: {['base', 'autoload', 'ams', 'color', 'cancel', 'physics', 'mathtools', 'colortbl', 'gensymb', 'centernot', 'colorv2', 'empheq', 'textcomp', 'upgreek', 'cases']
  }
};
</script>
")
;; (setq org-html-mathjax-template "")

(setq org-html-mathjax-options
      '(
        (path "https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js")
        (scale "100")
        (align "center")
        (indent "2em")
        (mathml nil))
      )

;; Below only support for MathJax 2.x
;; refer to the page [[http://docs.mathjax.org/en/latest/tex.html#][MathJax TeX and LaTeX Support — MathJax 2.7 documentation]]
;; (setq org-html-mathjax-template
;;       "<script type=\"text/javascript\" src=\"%PATH\"></script>
;; <script type=\"text/x-mathjax-config\">
;; MathJax.Hub.Config({
;;   extensions: [\"tex2jax.js\", \"[Contrib]/siunitx/siunitx.js\", \"[Contrib]/physics/physics.js\", \"[Contrib]/sqrtspacing.js\"],
;;   TeX: {
;;     equationNumbers: { autoNumber: \"AMS\" },
;;     extensions: [\"autoload-all.js\", \"AMSmath.js\", \"AMSsymbols.js\", \"color.js\", \"sinuitx.js\", \"physics.js\", \"cancel.js\", \"begingroup.js\", \"sqrtspacing.js\"]
;; }
;; });
;; </script>
;; ")
;; ;; (setq org-html-mathjax-template "")

;; (setq org-html-mathjax-options
;;       '(
;;         (path "https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.2/MathJax.js?config=TeX-AMS_HTML")
;;         (scale "100")
;;         (align "center")
;;         (indent "2em")
;;         (mathml nil))
;;       )

;; ;; (setq org-html-mathjax-options
;; ;;       '((path "D:/MyDocuments/My Knowledge/Plugins/Org2Wiz/MathJax/MathJax.js\?config=TeX-AMS-MML_HTMLorMML")
;; ;;         (scale "100")
;; ;;         (align "center")
;; ;;         (indent "2em")
;; ;;         (mathml nil))
;; ;;       )





(provide 'init-ox)
