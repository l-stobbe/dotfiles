;;; init.el --- Modern Emacs setup focused on completion and comfort -*- lexical-binding: t; -*-
;;; Code:
(add-to-list 'load-path "~/.emacs.d/lisp/")
(add-to-list 'load-path "/home/geist/.nix-profile/bin/gforth")
;;; Commentary:
;; 
(autoload 'forth-mode "gforth.el")
(setq auto-mode-alist (cons '("\\.fs\\'" . forth-mode) 
			    auto-mode-alist))
(autoload 'forth-block-mode "gforth.el")
(setq auto-mode-alist (cons '("\\.fb\\'" . forth-block-mode) 
			    auto-mode-alist))
(add-hook 'forth-mode-hook (function (lambda ()
   ;; customize variables here:
   (setq forth-indent-level 4)
   (setq forth-minor-indent-level 2)
   (setq forth-hilight-level 3)
   ;;; ...
)))

;; ------------------------------------------------------
;; 🧱 Basic Settings
;; ------------------------------------------------------

(setq inhibit-startup-message t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
(setq ring-bell-function 'ignore)
(setq use-short-answers t)
(setq recentf-max-saved-items 100)
(setq-default indent-tabs-mode nil)
(setq inferior-lisp-program "/usr/bin/sbcl")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode 1)
(column-number-mode 1)
(save-place-mode 1)
(recentf-mode 1)

;; ------------------------------------------------------
;; 📦 Package Setup
;; ------------------------------------------------------

(require 'package)
(setq package-archives
      '(("gnu"   . "https://elpa.gnu.org/packages/")
        ("melpa" . "https://melpa.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; ------------------------------------------------------
;; 🚀 Install use-package if needed
;; ------------------------------------------------------

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

;; ------------------------------------------------------
;; ⚡ Vertico - Minibuffer UI
;; ------------------------------------------------------

(use-package vertico
  :init (vertico-mode)
  :custom
  (vertico-cycle t)
  (vertico-resize t))

;; 🔍 Orderless - Smart Matching
(use-package orderless
  :custom
  (completion-styles '(orderless))
  (completion-category-defaults nil))

;; 📚 Marginalia - Annotations
(use-package marginalia
  :init (marginalia-mode))

;; 🧠 Corfu - In-buffer Completions
(use-package corfu
  :init (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-cycle t)
  (corfu-preview-current nil)
  (corfu-quit-no-match 'separator)
  (corfu-scroll-margin 5))

;; 🧠 Cape - Extra Completion Backends
(use-package cape
  :ensure t
  :config
  (add-to-list 'completion-at-point-functions #'cape-dabbrev)
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword)
  (add-to-list 'completion-at-point-functions #'cape-symbol))


;; 🌟 Kind Icon - Pretty Icons in Completion Popup
(use-package kind-icon
  :after corfu
  :custom
  (kind-icon-default-face 'corfu-default)
  (kind-icon-use-icons t)
  (kind-icon-blend-background nil)
  (kind-icon-blend-frac 0.08))

;; 🚀 Embark - Contextual Actions
(use-package embark
  :bind
  (("C-." . embark-act)
   ("C-;" . embark-dwim)
   ("C-h B" . embark-bindings))
  :init
  (setq prefix-help-command #'embark-prefix-help-command))

(use-package embark-consult
  :after (embark consult))


;; ------------------------------------------------------
;; 🎨 Optional Theme (can be changed later)
;; ------------------------------------------------------

(load-theme 'ef-trio-light t) ;; or 'modus-vivendi, 'leuven, 'tango-dark, etc.

;; ------------------------------------------------------
;; 🛠️ Development Tweaks
;; ------------------------------------------------------


(setq-default tab-width 2)
(electric-pair-mode 1)
(show-paren-mode 1)

;; Quick keybinding for testing completions manually
(global-set-key (kbd "C-SPC") #'completion-at-point)

;; ------------------------------------------------------
;; ✅ Ready!
;; ------------------------------------------------------

(message "Emacs ready. Completion powered by Vertico + Corfu + Orderless + Cape!")

(provide 'init)

;;; init.el ends here
