;; Before Startup

(set-frame-font "Iosevka 14" nil t)
(add-to-list 'default-frame-alist
  '(fullscreen . maximized))

;; Packages

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(use-package evil ;; Basic Vim Bindings for Emacs
  :ensure t
  :demand t
  :init
  (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  :bind (("<escape>" . keyboard-escape-quit))
  :config (evil-mode t))

(use-package evil-collection ;; Vim Bindings for various Emacs modes
  :after evil
  :ensure t
  :init (setq evil-want-integration t)
  :config (evil-collection-init))

(use-package gruvbox-theme ;; Nice Theme
  :ensure t
  :config (load-theme 'gruvbox :no-confirm))

(use-package git-gutter ;; Shows Git Diff for Buffer File
  :ensure t)

(use-package editorconfig ;; File Formatting from .editorconfig
  :ensure t
  :config (editorconfig-mode 1))

(use-package ivy ;; Better ido Replacement
  :ensure t
  :config (ivy-mode 1))

(use-package evil-nerd-commenter ;; g c to Comment
  :after evil
  :ensure t
  :config
  (evilnc-default-hotkeys)
  (define-key evil-visual-state-map (kbd "g c") 'evilnc-comment-operator))

(use-package company ;; Completion and Suggestions
  :ensure t
  :hook prog-mode)

(use-package eglot ;; Language Server
  :ensure t
  :init
  :hook
  (c-mode . eglot-ensure)
  (c++-mode . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
    '((c-mode c++-mode) .
      ("clangd"
        "-j=3"
        "--background-index"
        "--pch-storage=memory"))))

(use-package which-key ;; Shows Keybinding Descriptions
  :ensure t
  :config (which-key-mode))

;; Keybinds

(define-key evil-normal-state-map (kbd "C-k") 'whitespace-mode)
(define-key evil-normal-state-map (kbd "SPC j") 'evil-ex-nohighlight)
(define-key evil-visual-state-map (kbd "SPC k") 'evil-ex-sort)

;; Other Settings

(set-input-method  ; C-\ to switch
  'russian-computer)
(toggle-input-method)

;; Custom File

;; use M-x customize-variable RET <variable>
(setq custom-file "~/.emacs.custom.el")
(load-file custom-file)
