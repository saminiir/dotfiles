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

(require 'org)
(setq org-directory "~/Dropbox/org")
(setq org-default-notes-file (concat org-directory "/notes.org"))
(add-to-list 'org-agenda-files (expand-file-name "~/Dropbox/org/"))
(setq org-refile-targets '((org-agenda-files :maxlevel . 2)))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; EasyPG
(require 'epa-file)
(epa-file-enable)
(setq epa-file-name-regexp "\\.\\(gpg\\|asc\\|org\\)$")
(epa-file-name-regexp-update)
