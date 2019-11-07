;; Nice emacs starter: https://huytd.github.io/emacs-from-scratch.html

;; Minimal UI
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; start maximized

;; More line informations
;;(global-hl-line-mode +1)  ;; Highlight current line in green
(line-number-mode +1)
(global-display-line-numbers-mode 1)
(column-number-mode t)
(size-indication-mode t)

;; Encoding
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Font and Frame Size
(add-to-list 'default-frame-alist '(font . "hack-12"))
(add-to-list 'default-frame-alist '(height . 24))
(add-to-list 'default-frame-alist '(width . 80))

;; ===== Set standard indent to 4 ====
(setq standard-indent 4)
;; ===== Turn off tab character =====
(setq-default indent-tabs-mode nil)

;; This makes the buffer scroll by only a single line when the up or
;; ========== Line by line scrolling ==========
;; down cursor keys push the cursor (tool-bar-mode) outside the
;; buffer. The standard emacs behaviour is to reposition the cursor in
;; the center of the screen, but this can make the scrolling confusing
(setq scroll-step 1)

;; ========== Support Wheel Mouse Scrolling ==========
(mouse-wheel-mode t)

;; ========== Place Backup Files in Specific Directory ==========
;; Disable backup files
(setq make-backup-files nil) ; stop creating backup~ files
(setq auto-save-default nil) ; stop creating #autosave# files
;; Save all backup file in this directory.
;; (setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;; freaking don't ask me to type out "yes" and "no"
(defalias 'yes-or-no-p 'y-or-n-p)

;; Don't use messages that you don't read
(setq initial-scratch-message "")
(setq inhibit-startup-message t)

;; ===== Make Text mode the default mode for new buffers =====
(setq default-major-mode 'text-mode)

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;; Follow symbolic links
(setq vc-follow-symlinks t)

;; Clean whitespace on save
(add-hook 'before-save-hook 'whitespace-cleanup)

;; ========= Package configs ==========
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("org"   . "http://orgmode.org/elpa/")
                         ("gnu"   . "http://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; ========== Git integration =============
(use-package magit
  :ensure t
  :bind (("C-M-g" . magit-status)))

;; ======== Jump to character ===========
(use-package avy
  :ensure t
  :bind
  ("C-:" . avy-goto-char)
  :config
  (setq avy-background t))

;; http://cachestocaches.com/2015/8/c-completion-emacs/
;; https://oracleyue.github.io/2017/12/04/emacs-init-cc-irony/
;; == irony-mode ==
(use-package irony
  :ensure t
  :defer t
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  :config
  ;; replace the `completion-at-point' and `complete-symbol' bindings in
  ;; irony-mode's buffers by irony-mode's function
  (defun my-irony-mode-hook ()
    (define-key irony-mode-map [remap completion-at-point]
      'irony-completion-at-point-async)
    (define-key irony-mode-map [remap complete-symbol]
      'irony-completion-at-point-async))
  (add-hook 'irony-mode-hook 'my-irony-mode-hook)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )

;; == company-mode ==
(use-package company
  :ensure t
  :defer t
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (use-package company-irony :ensure t :defer t)
  (setq company-idle-delay              0
        company-echo-delay              0
        company-minimum-prefix-length   2
        company-show-numbers            t
        company-tooltip-limit           20
        company-dabbrev-downcase        nil
        company-backends                '((company-irony company-gtags))
        )
  :bind ("C-;" . company-complete-common)
  )

;; ====== Project manager ======
(use-package projectile
  :ensure t
  :diminish projectile-mode
  :bind
  (("C-c p f" . helm-projectile-find-file)
   ("C-c p p" . helm-projectile-switch-project)
   ("C-c p s" . projectile-save-project-buffers))
  :config
  (projectile-mode +1)
)

(use-package helm
  :ensure t
  :defer 2
  :bind
  ("M-x" . helm-M-x)
  ("C-x C-f" . helm-find-files)
  ("M-y" . helm-show-kill-ring)
  ("C-x b" . helm-mini)
  :config
  (require 'helm-config)
  (helm-mode 1)
  (setq helm-split-window-inside-p t
    helm-move-to-line-cycle-in-source t)
  (setq helm-autoresize-max-height 0)
  (setq helm-autoresize-min-height 20)
  (helm-autoresize-mode 1)
  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebind tab to run persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB work in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
)

(use-package helm-projectile
  :ensure t
  :config
  (helm-projectile-on))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
