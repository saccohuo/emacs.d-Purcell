(require 'package)


;;; Install into separate package dirs for each Emacs version, to prevent bytecode incompatibility
(let ((versioned-package-dir
       (expand-file-name (format "elpa-%s.%s" emacs-major-version emacs-minor-version)
                         user-emacs-directory)))
  (setq package-user-dir versioned-package-dir))



;;; Standard package repositories

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Official MELPA Mirror, in case necessary.
  ;;(add-to-list 'package-archives (cons "melpa-mirror" (concat proto "://www.mirrorservice.org/sites/melpa.org/packages/")) t)
  (if (< emacs-major-version 24)
      ;; For important compatibility libraries like cl-lib
      (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))
    (unless no-ssl
      ;; Force SSL for GNU ELPA
      (setcdr (assoc "gnu" package-archives) "https://elpa.gnu.org/packages/"))))

;; We include the org repository for completeness, but don't normally
;; use it.
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))


(defconst sanityinc/no-ssl (and (memq system-type '(windows-nt ms-dos))
                                (not (gnutls-available-p))))

;;; Also use Melpa for most packages
(add-to-list 'package-archives
             `("melpa" . ,(if sanityinc/no-ssl
                              "http://melpa.org/packages/"
                            "https://melpa.org/packages/")))

;; NOTE: In case of MELPA problems, the official mirror URL is
;; https://www.mirrorservice.org/sites/stable.melpa.org/packages/


;; (when (< emacs-major-version 24)
;;   ;; Mainly for ruby-mode
;;   (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t))

;; ;; We include the org repository for completeness, but don't normally
;; ;; use it.
;; (add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

;; (when (< emacs-major-version 24)
;;   (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t))

;; ;;; Also use Melpa for most packages
;; (add-to-list 'package-archives '("melpa" . ,(if (< emacs-major-version 24)
;;                                                 "http://melpa.org/packages/"
;;                                               "https://melpa.org/packages/")))

;; (add-to-list 'package-archives '("THU" . "https://mirror.tuna.tsinghua.edu.cn/elpa/"))
;; (add-to-list 'package-archives '("emacs-china" . "http://elpa.emacs-china.org/"))
;; (add-to-list 'package-archives '("emacs-china" . "http://elpa.zilongshanren.com/melpa/"))



;;; On-demand installation of packages

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
            ;; Record this as a package the user installed explicitly
            (package-install package nil)
          (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))


(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))


;;; Fire up package.el

(setq package-enable-at-startup nil)
(package-initialize)



(require-package 'fullframe)
(fullframe list-packages quit-window)


(require-package 'cl-lib)
(require 'cl-lib)

(defun sanityinc/set-tabulated-list-column-width (col-name width)
  "Set any column with name COL-NAME to the given WIDTH."
  (when (> width (length col-name))
    (cl-loop for column across tabulated-list-format
             when (string= col-name (car column))
             do (setf (elt column 1) width))))

(defun sanityinc/maybe-widen-package-menu-columns ()
  "Widen some columns of the package menu table to avoid truncation."
  (when (boundp 'tabulated-list-format)
    (sanityinc/set-tabulated-list-column-width "Version" 13)
    (let ((longest-archive-name (apply 'max (mapcar 'length (mapcar 'car package-archives)))))
      (sanityinc/set-tabulated-list-column-width "Archive" longest-archive-name))))

(add-hook 'package-menu-mode-hook 'sanityinc/maybe-widen-package-menu-columns)


(provide 'init-elpa)
