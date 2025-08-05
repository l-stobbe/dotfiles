;;; init.el --- Modern Emacs setup focused on completion and comfort -*- lexical-binding: t; -*-

;;; Commentary:
;; Emacs configuration with
;; - Modern completion: Vertico + Corfu + Orderless + Prescient + Cape
;; - Useful UI and behavior tweaks

;;; Code:
(use-package bqn-mode
  :ensure t
  :mode "\\.bqn\\'"
  :hook (bqn-mode . bqn-electric-indent-mode))

(use-package haskell-mode)
(use-package sweeprolog)
(use-package magit)
;; ------------------------
;; Load paths for local elisp
;; ------------------------
(add-to-list 'load-path "~/.emacs.d/lisp/")


;; ------------------------
;; Basic Emacs Settings
;; ------------------------
(setq inhibit-startup-message t
      make-backup-files nil
      auto-save-default nil
      create-lockfiles nil
      ring-bell-function 'ignore
      use-short-answers t
      recentf-max-saved-items 100
      indent-tabs-mode nil
      inferior-lisp-program "/usr/bin/sbcl")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(column-number-mode 1)
(save-place-mode 1)
(recentf-mode 1)

;; ------------------------
;; Package Archives & use-package setup
;; ------------------------
(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
				("nongnu" . "https://elpa.nongnu.org/nongnu/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ------------------------
;; Completion Framework Setup
;; ------------------------

;; Vertico - Minibuffer Completion UI
(use-package vertico
  :init (vertico-mode)
  :custom
  (vertico-cycle t)
  (vertico-resize t))

;; Orderless - Flexible and smart matching style
(use-package orderless
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil))

;; Prescient - Sort by frequency and recency + save history
(use-package prescient
  :config
  (prescient-persist-mode 1))

;; Vertico-Prescient - Integrate prescient sorting with Vertico
(use-package vertico-prescient
  :after (vertico prescient)
  :config
  (vertico-prescient-mode 1))

;; Corfu - In-buffer completion popup
(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.05)
  (corfu-cycle t)
  (corfu-preview-current nil)
  (corfu-quit-no-match 'separator)
  (corfu-scroll-margin 5)
  :config
  (global-corfu-mode))

;; Corfu-Prescient - Integrate prescient sorting with Corfu
(use-package corfu-prescient
  :after (corfu prescient)
  :config
  (corfu-prescient-mode 1))

;; Marginalia - Rich annotations in minibuffer completions
(use-package marginalia
  :init (marginalia-mode))

;; Kind Icon - Pretty icons in Corfu popup
(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  (kind-icon-use-icons t)
  (kind-icon-blend-background nil)
  (kind-icon-blend-frac 0.08))

;; ------------------------
;; Embark - Contextual actions and better minibuffer UX
;; ------------------------
(use-package embark
  :bind (("C-." . embark-act)
         ("C-;" . embark-dwim)
         ("C-h B" . embark-bindings))
  :init (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult))

;; ------------------------
;; UI and Development tweaks
;; ------------------------
(setq-default tab-width 2)
(electric-pair-mode 1)
(show-paren-mode 1)

;; Convenient manual trigger for completion-at-point
(global-set-key (kbd "C-SPC") #'completion-at-point)

;; Load preferred theme
(load-theme 'ef-dream t)

;; ------------------------
;; Startup message
;; ------------------------
(message "Emacs ready. Completion powered by Vertico + Corfu + Orderless + Prescient + Cape!")

(provide 'init)
;;; init.el ends here
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("59c36051a521e3ea68dc530ded1c7be169cd19e8873b7994bfc02a216041bf3b"
     "36c5acdaf85dda0dad1dd3ad643aacd478fb967960ee1f83981d160c52b3c8ac"
     default))
 '(j-console-cmd "jconsole")
 '(package-selected-packages
   '(bqn-mode cape cider corfu-prescient ef-themes elixir-mode
              embark-consult erlang forth-mode general haskell-mode
              j-mode kind-icon magit marginalia orderless relint sly
              sweeprolog uiua-mode vertico-prescient vterm which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

