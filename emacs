(require 'package) 
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; Enable backup files.
(setq make-backup-files t)

(setq delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;; Save all backup file in this directory.
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))
(setq auto-save-file-name-transforms `((".*" "~/.emacs_backups/" t)))

(setq linum-format "%4d \u2502 ")
(setq indent-tabs-mode nil)

(defun my-c-mode-hook ()
  (setq c-basic-offset 4)
  (setq c-default-style "linux")
  (cscope-minor-mode)
  )
(add-hook 'c-mode-hook 'my-c-mode-hook)

(define-globalized-minor-mode my-linum-mode linum-mode
  (lambda () (linum-mode 1)))

(my-linum-mode 1)

(define-globalized-minor-mode my-window-numbering-mode window-numbering-mode
  (lambda () (window-numbering-mode 1)))

(my-window-numbering-mode 1)
