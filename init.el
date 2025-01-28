(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'load-path "/home/geist/.ghcup/bin/ghc")
(add-to-list 'load-path "/home/geist/.cargo/bin/uiua")
(add-to-list 'load-path "/usr/bin/elixir-ls")
(add-to-list 'load-path "/usr/lib/elixir-ls/language_server.sh")
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(desktop-save-mode 1)

(use-package paren
  :ensure nil
  :config
  (show-paren-mode +1))





;; Do not show the startup screen.
(setq inhibit-startup-message t)

;; Disable tool bar, menu bar, scroll bar.
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(electric-pair-mode 1)



(use-package elpy)
(elpy-enable)
(use-package doom-themes)

(use-package doom-modeline)
(doom-modeline-mode 1)
(use-package helpful)
(use-package which-key)
(which-key-mode)
(use-package magit)
(use-package pdf-tools)
(use-package ef-themes)

(use-package projectile)
(use-package tldr) 

(use-package anzu)
(use-package eshell-prompt-extras)
(use-package symbols-outline)
(use-package elfeed)
  ;; Enable rich annotations using the Marginalia package
(use-package marginalia
  ;; Bind `marginalia-cycle' locally in the minibuffer.  To make the binding
  ;; available in the *Completions* buffer, add it to the
  ;; `completion-list-mode-map'.
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init section is always executed.
  :init

  ;; Marginalia must be activated in the :init section of use-package such that
  ;; the mode gets enabled right away. Note that this forces loading the
  ;; package.
  (marginalia-mode))

  ;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  ;; (setq vertico-cycle t)
  )




;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; Optionally use the `orderless' completion style.
(use-package orderless
  :init
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (setq orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch)
  ;;       orderless-component-separator #'orderless-escapable-split-on-space)
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

(use-package corfu
  ;; Optional customizations
   :custom
  ;; (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
   (corfu-auto t)                 ;; Enable auto completion
  ;; (corfu-separator ?\s)          ;; Orderless field separator
  ;; (corfu-quit-at-boundary nil)   ;; Never quit at completion boundary
  ;; (corfu-quit-no-match nil)      ;; Never quit, even if there is no match
  ;; (corfu-preview-current nil)    ;; Disable current candidate preview
  ;; (corfu-preselect 'prompt)      ;; Preselect the prompt
  ;; (corfu-on-exact-match nil)     ;; Configure handling of exact matches
  ;; (corfu-scroll-margin 5)        ;; Use scroll margin

  ;; Enable Corfu only for certain modes.
  ;; :hook ((prog-mode . corfu-mode)
  ;;        (shell-mode . corfu-mode)
  ;;        (eshell-mode . corfu-mode))

  ;; Recommended: Enable Corfu globally.  This is recommended since Dabbrev can
  ;; be used globally (M-/).  See also the customization variable
  ;; `global-corfu-modes' to exclude certain modes.
  :init
  (global-corfu-mode))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(doom-one))
 '(custom-safe-themes
   '("88f7ee5594021c60a4a6a1c275614103de8c1435d6d08cc58882f920e0cec65e" default))
 '(exec-path
   '("/usr/local/sbin" "/usr/local/bin" "/usr/bin" "/usr/lib/jvm/default/bin" "/usr/bin/site_perl" "/usr/bin/vendor_perl" "/usr/bin/core_perl" "/usr/lib/emacs/29.4/x86_64-pc-linux-gnu" "/home/geist/.nix-profile/bin/uiua"))
 '(package-selected-packages
   '(idris-mode elixir-mode lsp-mode racket-mode sicp org-link-beautify org-tag-beautify zig-mode org-roam company-plisp plisp-mode uiua-mode geiser-chicken geiser cider lfe-mode general modaled nezburn-theme hc-zenburn-theme zenburn-theme gruvbox-theme catppuccin-theme smart-mode-line-atom-one-dark-theme haskell-mode geiser-guile sly-repl-ansi-color sly guix doom-themes pdf-tools magit poetry vertico use-package orderless marginalia ef-themes corfu))
 '(plisp-documentation-directory "/usr/lib/picolisp/doc/"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(desktop-read)
