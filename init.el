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




(menu-bar-mode -1)
(global-unset-key (kbd "C-x C-r"))
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-b") 'helm-buffers-list)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(define-key global-map [menu-bar words] nil)


(setq ring-bell-function 'ignore)

;; (defun load-directory (directory)
;;   "Load recursively all `.el' files in DIRECTORY."
;;   (dolist (element (directory-files-and-attributes directory nil nil nil))
;;     (let* ((path (car element))
;;            (fullpath (concat directory "/" path))
;;            (isdir (car (cdr element)))
;;            (ignore-dir (or (string= path ".") (string= path ".."))))
;;       (cond
;;        ((and (eq isdir t) (not ignore-dir))
;;         (load-directory fullpath))
;;        ((and (eq isdir nil) (string= (substring path -3) ".el"))
;;         (load (file-name-sans-extension fullpath)))))))
;; (load-directory "~/.emacs.d/config")




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

(defun magit-publish ()
  (interactive)
  (when (yes-or-no-p "Publish this branch? ")
    (eshell-command
     (format "git push -u origin %s" (magit-get-current-branch)))))

(global-set-key (kbd "C-x m p") 'magit-publish)

(setq jiralib-url "https://motionsoft.atlassian.net")

(setq helm-split-window-inside-p t)

(setq ag-executable "C:/Users/nstares/Downloads/ag/ag.exe")

(global-set-key (kbd "C-c j") 'avy-goto-word-1)

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


;; (require 'helm-ag-r)


;; (setq helm-ag-r-option-list
;;       '("-S -U --hidden"
;;         "-S -U -l"))

;; helm-ag-r-current-file -- search from current file
;; helm-ag-r-from-git-repo -- search from git repository
;; helm-ag-r-shell-history -- search shell history
;; helm-ag-r-git-logs -- search git logs
;; helm-ag-r-google-contacts-list -- show your google-contacts



;;;;;;;;;; ORG-JIRA ;;;;;;;;;;;;;;
;; (define-key org-jira-map (kbd "C-c pg") 'org-jira-get-projects)
;; (define-key org-jira-map (kbd "C-c ib") 'org-jira-browse-issue)
;; (define-key org-jira-map (kbd "C-c ig") 'org-jira-get-issues)
;; (define-key org-jira-map (kbd "C-c ih") 'org-jira-get-issues-headonly)
;; (define-key org-jira-map (kbd "C-c iu") 'org-jira-update-issue)
;; (define-key org-jira-map (kbd "C-c iw") 'org-jira-progress-issue)
;; (define-key org-jira-map (kbd "C-c in") 'org-jira-progress-issue-next)
;; (define-key org-jira-map (kbd "C-c ia") 'org-jira-assign-issue)
;; (define-key org-jira-map (kbd "C-c ir") 'org-jira-refresh-issue)
;; (define-key org-jira-map (kbd "C-c iR") 'org-jira-refresh-issues-in-buffer)
;; (define-key org-jira-map (kbd "C-c ic") 'org-jira-create-issue)
;; (define-key org-jira-map (kbd "C-c ik") 'org-jira-copy-current-issue-key)
;; (define-key org-jira-map (kbd "C-c sc") 'org-jira-create-subtask)
;; (define-key org-jira-map (kbd "C-c sg") 'org-jira-get-subtasks)
;; (define-key org-jira-map (kbd "C-c cu") 'org-jira-update-comment)
;; (define-key org-jira-map (kbd "C-c wu") 'org-jira-update-worklogs-from-org-clocks)
;; (define-key org-jira-map (kbd "C-c tj") 'org-jira-todo-to-jira)
;; (define-key org-jira-map (kbd "C-c if") 'org-jira-get-issues-by-fixversion)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (magit-gh-pulls achievements avy helm-ag-r ag org org-jira helm-projectile projectile magit company helm-ag omnisharp helm monokai-theme))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-lead-face ((t (:background "#e52b50" :foreground "white" :height 1.3 :width extra-expanded))))
 '(avy-lead-face-0 ((t (:background "#4f57f9" :foreground "white" :height 1.3)))))
