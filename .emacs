(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("4af6fad34321a1ce23d8ab3486c662de122e8c6c1de97baed3aa4c10fe55e060" "3b24f986084001ae46aa29ca791d2bc7f005c5c939646d2b800143526ab4d323" "6af55f6f26c0c6f113427d8ce72dea34aa1972b70e650486e6c725abd18bbe91" "12b7ed9b0e990f6d41827c343467d2a6c464094cbcc6d0844df32837b50655f9" "44048f3a208ccfa3286b426a995696871e6403d951b23d7b55a1af850d7aec93" "9cb6358979981949d1ae9da907a5d38fb6cde1776e8956a1db150925f2dad6c1" "b0ab5c9172ea02fba36b974bbd93bc26e9d26f379c9a29b84903c666a5fde837" "40f6a7af0dfad67c0d4df2a1dd86175436d79fc69ea61614d668a635c2cd94ab" default)))
 '(default-input-method "latin-1-prefix")
 '(inhibit-startup-screen t)
 '(org-agenda-files
   (quote
    ("~/org/.notes" "~/org/calendar.org" "~/org/finances.org")))
 '(org-capture-templates
   (quote
    (("j" "Template for a job to do" entry
      (file "~/notes.org")
      "* TODO %?
 %a
")
     ("t" "Template for my thoughts" entry
      (file "~/notes.org")
      ""))))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil)
 '(tooltip-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro for Powerline" :foundry "ADBE" :slant normal :weight normal :height 108 :width normal)))))

(require 'package) ;; You might already have this line
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line

;; diary integration is supposed to be nice
(setq org-agenda-include-diary t)

;; smooth scrolling
(setq smooth-scroll-mode t)
(setq scroll-step 1
      scroll-conservatively 10000 )

;; annoying, broken validate thing in org export that I don't understand
(setq org-html-validation-link nil)

;; NeoTree
(setq-default neo-smart-open t)
(setq neo-theme 'nerd)
(global-set-key "\C-x\C-n" 'neotree-toggle)

;; never close Emacs on accident
(global-set-key "\C-x\C-c" nil)

;; updates .zshrc to emacs
(let ((path (shell-command-to-string ". ~/.zshrc; echo -n $PATH")))
  (setenv "PATH" path)
  (setq exec-path 
        (append
         (split-string-and-unquote path ":")
         exec-path)))

;; flyspell-issue-message-flag apparently causes an enormous slowdown!
(setq flyspell-issue-message-flag nil)

(load-library "abbrev")
(load-library "pabbrev")
(load-library "smartparens")
(load-library "smartparens-config")
(load-library "org-bullets")
(require 'typo)
(require 'abbrev)
(require 'pabbrev)
(require 'smartparens)
(require 'smartparens-config)

(require 'org-bullets)
(setq org-bullets-bullet-list
      '("◇" "◎" "⚫" "○" "►"))
(setq org-todo-keywords '((sequence "☛ TODO(t)" "|" "✔ DONE(d)")
			  (sequence "⚑ WAITING(w)" "|")
			  (sequence "|" "✘ CANCELED(c)")))

(font-lock-add-keywords 'org-mode
                        '(("^ +\\([-*]\\) "
                           (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

;; smartparens completions
(sp-pair "«" "»" :insert "C-x C-c <")
(sp-pair "“" "”" :insert "C-x C-c \"")

;; ido
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-filename-at-point 'guess)

;; after 
(add-hook 'after-init-hook
	  (lambda ()
	    (desktop-save-mode t)
	    ;; (load-theme 'tango-plus t)
	    ;; (load-theme 'flatui t)
	    (load-theme 'gandalf t)
	    ;; (load-theme 'meacupla-theme t)
	    ;; (load-theme 'zenburn t))
	    ;; (load-theme 'labburn t)
	    ;; (load-theme 'white-board t)
	    ;; (load-theme 'anti-zenburn t)
	    ;; (set-cursor-color "#5f615c")
	    (ido-mode t)
	    (typo-change-language "English")
	    t))

;; is kind of neat, automatic saving and so forth.
(setq version-control t)
;; (setq kept-new-versions 2)
;; (setq kept-old-versions 2)

;;org-mode stuff
;;(require 'org)
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook
	  (lambda ()
	    (flyspell-mode t)
	    (set-fill-column 82)
	    (org-indent-mode t)
	    ;; TIL one can setq.  Also, C-hv for search var
	    (setq org-pretty-entities t)
	    (auto-fill-mode t)
	    (abbrev-mode t)
	    (pabbrev-mode t)
	    (smartparens-mode t)
	    (org-bullets-mode)

	    ;; yeah, I think typo totally fucknig sucksf
	    ;; (typo-mode t) 
	    ;; (typo-change-language "English")
	    t))

(add-hook 'emacs-lisp-mode-hook
	  (lambda()
	    ;; (abbrev-mode t)
	    (pabbrev-mode t)
	    (smartparens-strict-mode t)
	    t))

;; elisp mode for these files
(add-to-list 'auto-mode-alist '(".emacs" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("emacsdesk" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("emacstop" . emacs-lisp-mode))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js3-mode))
(add-hook 'js3-mode-hook
	  (lambda ()
	    (pabbrev-mode t)
	    t))

;; org-mode grobals
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; keyboard switch
(global-set-key (kbd "C-=") 'flyspell-mode)
(global-set-key (kbd "C-+") 'typo-mode)
(global-set-key (kbd "\C-ci") 'fd-switch-dictionary)
(global-set-key (kbd "C-c i") 'cycle-ispell-languages)

;; gnus news list
;; ?????????????????

;; set-mark
(global-set-key (kbd "\C-cm") 'set-mark-command)

;; abbrev manipulation
(global-set-key (kbd "M-\\") 'pabbrev-expand)
(define-key minibuffer-local-map (kbd "M-\\") 'pabbrev-expand)
(define-key pabbrev-mode-map (kbd "M-SPC") 'pabbrev-expand-maybe)

(defun pabbrev-suggestions-ido (suggestion-list)
  "Use ido to display menu of all pabbrev suggestions."
  (when suggestion-list
    (pabbrev-suggestions-insert-word pabbrev-expand-previous-word)
    (pabbrev-suggestions-insert-word
     (ido-completing-read "Completions: " (mapcar 'car suggestion-list)))))

(defun pabbrev-suggestions-insert-word (word)
  "Insert word in place of current suggestion, with no attempt to kill pabbrev-buffer."
  (let ((point))
    (save-excursion
      (let ((bounds (pabbrev-bounds-of-thing-at-point)))
	(progn
	  (delete-region (car bounds) (cdr bounds))
	  (insert word)
	  (setq point (point)))))
    (if point
	(goto-char point))))

(fset 'pabbrev-suggestions-goto-buffer 'pabbrev-suggestions-ido)

(let ((langs '("american" "francais" "german")))
  (setq lang-ring (make-ring (length langs)))
  (dolist (elem langs) (ring-insert lang-ring elem)))

(defun cycle-ispell-languages ()
  (interactive)
  (let ((lang (ring-ref lang-ring -1)))
    (ring-insert lang-ring lang)
    (ispell-change-dictionary lang)))

;; ;; ispell global
;; ;; (global-set-key "\C-ci" 'ispell-region)
;; (defun fd-switch-dictionary()
;;   (interactive)
;;   (let* ((dic ispell-current-dictionary)
;;     	 (change (if (string= dic "francais") "english" "francais")))
;;     (ispell-change-dictionary change)
;;     (message "Dictionary switched from %s to %s" dic change)
;;     ))


;; sonic-pi goodies
(add-to-list 'load-path "~/.sonic-pi.el/")
(load-library "sonic-pi")
(require 'sonic-pi)
(setq sonic-pi-path "~/sonic-pi/") ; Must end with "/"

;; Optionally define a hook
(add-hook 'sonic-pi-mode-hook
          (lambda ()
            ;; This setq can go here instead if you wish
            (setq sonic-pi-path "~/sonic-pi/") ; Must end with "/"
            (define-key ruby-mode-map "\C-c\C-b" 'sonic-pi-stop-all)
	    (define-key ruby-mode-map "\C-c\C-c" 'sonic-pi-send-buffer)))

(message "init finish")
