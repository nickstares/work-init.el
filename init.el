(require 'package) ;; You might already have this line
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line
 (defvar mswindows-p (string-match "windows" (symbol-name system-type)))

;; (require 'omnisharp)
;; (add-hook 'csharp-mode-hook 'omnisharp-mode)
;; ;(setq omnisharp-server-executable-path  "/Users/nstares/omnisharp-server/OmniSharp/bin/Debug/OmniSharp.exe")
;; (require 'helm-config)
;; (require 'company)
;; (eval-after-load
;;  'company
;;  '(add-to-list 'company-backends 'company-omnisharp))


(require 'magit-gh-pulls)
(add-hook 'magit-mode-hook 'turn-on-magit-gh-pulls)


(add-to-list 'exec-path "C:/cygwin64/bin/")

(menu-bar-mode -1)
(global-unset-key (kbd "C-x C-r"))
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-m") 'helm-M-x )
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(define-key global-map [menu-bar words] nil)


(setq ring-bell-function 'ignore)



(load-theme 'monokai t)
(when mswindows-p
  (set-face-attribute 'default nil
                      :family "Consolas" :height 100))

(set-scroll-bar-mode nil)
(tool-bar-mode -1)

(global-set-key (kbd "C-k") 'kill-line)
(global-set-key (kbd "C-r") 'isearch-backward)
(global-set-key (kbd "C--") 'undo)


;; AVY

(global-set-key (kbd "M-g e") 'avy-goto-word-0)
(global-set-key (kbd "M-g w") 'avy-goto-word-1)
(global-set-key (kbd "M-g f") 'avy-goto-line)



(defun reset-web-config ()
  (interactive) 
      (eshell-command "cp c:/Users/nstares/Web/Web.config c:/Users/nstares/MosoClub/MosoLite-Prod/MosoLiteWeb/MosoLite.Web/Web.config")
      (message "Web.config reset") t)

(global-set-key (kbd "C-c r w") 'reset-web-config)


(defun new-ticket ()
    (interactive)
    (let ((ticket (read-from-minibuffer "MCLUB- ")))
      (let ((branch (read-from-minibuffer "Release Branch: ")))
	(new-ticket-helper ticket branch)
	)))

(defun new-ticket-helper (ticket branch)
  (eshell-command
   (format "git checkout -b \"MCLUB-%s\" --no-track \"origin/%s\"" ticket branch)))

;; Easy magit status
(define-prefix-command 'magit-map)
(global-set-key (kbd "C-x m ") 'magit-map)
(global-set-key (kbd "C-x m s") 'magit-status)

(defun mosoclub ()
  (interactive)
  (eshell-command "cd c:/Users/nstares/MosoClub/MosoLite-Prod/MosoLiteWeb/MosoLite.Web/")
  (message "Changed directory to MosoClub repo"))


(setq completions '("sand1 - remote"
		    "phgdelmarva - local"
		    "mattweb - sand1 remote" ))


(setq config-files '(("sand1 - remote" . "sand1.config")
		     ("phgdelmarva - local" . "LIS32PHGDELMARVA.config")
		     ("mattweb - sand1 remote" . "mattweb.config")
		     ))


(defun change-web-config()
  (interactive)
  (let ((filename
	 (cdr (assoc (completing-read "config file: " completions)
		     config-files))))
    (eshell-command (format "cp /Users/nstares/Web/%s /Users/nstares/Web/Web.config" filename)))
  (reset-web-config))
  
  (global-set-key (kbd "C-c c w") 'change-web-config)
         


(defun phgde ()
  (interactive)
  (let ((shared "~/MosoClub/MosoLite-Prod/MosoLiteWeb/MosoLite.Web/Content/Shared/"))
    (eshell-command (format "mkdir %s/PHGDE ; mkdir %s/PHGDE/PDFReports" shared shared))))

(defun magit-publish ()
  (interactive)
  (when (yes-or-no-p "Publish this branch? ")
    (eshell-command
     (format "git push -u origin %s" (magit-get-current-branch)))))

(global-set-key (kbd "C-x m p") 'magit-publish)

(setq jiralib-url "https://motionsoft.atlassian.net")

(setq helm-split-window-inside-p t)

(setq ag-executable "C:/Users/nstares/Downloads/ag/ag.exe")

(global-set-key (kbd "C-c j") 'avy-goto-char-2)

(global-unset-key (kbd "C-x o"))
(global-set-key (kbd "C-x o") 'ace-window)

(avy-setup-default)

;; TIM LICATA's C-w
;; C-w.
;; Chromebook has no delete key so I can't M-DEL to kill the previous
;; word. Bash uses C-w to cut up to the last space, so why not do
;; that. Only problem: C-w kills the active region by default, so
;; keep that functionality.
(defun unix-werase-or-kill (arg)
  (interactive "*p")
  (if (use-region-p)
      (kill-region (region-beginning) (region-end))
    (if (eq (key-binding (kbd "M-DEL")) 'paredit-backward-kill-word)
        (paredit-backward-kill-word)
      (backward-kill-word arg))))
(global-set-key (kbd "C-w") 'unix-werase-or-kill)
;; Use C-w in ido minibuffers too.
(add-hook 'ido-setup-hook
          (lambda ()
            (define-key ido-file-completion-map "\C-w" 'ido-delete-backward-word-updir)))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (cider evil web-mode magit-gh-pulls achievements avy helm-ag-r ag org org-jira helm-projectile projectile magit company helm-ag omnisharp helm monokai-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-lead-face ((t (:background "#e52b50" :foreground "white" :height 1.3 :width extra-expanded))))
 '(avy-lead-face-0 ((t (:background "#4f57f9" :foreground "white" :height 1.3)))))
(put 'set-goal-column 'disabled nil)
