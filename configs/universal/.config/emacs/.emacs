;; Before Startup

(set-frame-font "IosevkaTerm Nerd Font 18" nil t)
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
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  :bind (("<escape>" . keyboard-escape-quit))
  :config (evil-mode t))

(use-package evil-collection ;; Vim Bindings for various Emacs modes
  :after evil
  :ensure t
  :init (setq evil-want-integration t)
  :config (evil-collection-init))

(use-package zenburn-theme ;; Theme
  :ensure t
  :config (load-theme 'zenburn :no-confirm))

(use-package git-gutter ;; Shows Git Diff for Buffer File
  :ensure t)

(use-package editorconfig ;; File Formatting from .editorconfig
  :ensure t
  :config (editorconfig-mode 1))

(use-package ivy ;; Better ido Replacement
  :ensure t
  :config (ivy-mode 1))

(use-package which-key ;; Shows Keybinding Descriptions
  :ensure t
  :config (which-key-mode))

(use-package evil-nerd-commenter ;; g c to Comment
  :after (evil evil-collection)
  :ensure t
  :config
  (evilnc-default-hotkeys)
  (define-key evil-visual-state-map (kbd "g c") 'evilnc-comment-operator))

(use-package company ;; Completion and Suggestions
  :ensure t
  :hook prog-mode
  :config (setq company-minimum-prefix-length 2))

(use-package flymake ;; Diagnostics
  :ensure t
  :hook prog-mode)

(use-package xcscope ;; Cscope Tags
  :after (evil evil-collection)
  :ensure t
  :config
  (setq cscope-option-do-not-update-database t)
  (cscope-setup)
  (add-hook 'cscope-list-entry-hook
    (lambda ()
      (define-key evil-normal-state-local-map (kbd "q") 'quit-window)))
  (define-key evil-visual-state-map (kbd "SPC k") 'evil-ex-sort)
  (define-key evil-normal-state-map (kbd "C-c g") 'cscope-find-global-definition)
  (define-key evil-normal-state-map (kbd "C-c C-r") 'cscope-find-functions-calling-this-function)
  (define-key evil-normal-state-map (kbd "C-c C-g") 'cscope-find-global-definition-no-prompting))

;; Languages

(setq-default c-default-style
  '((java-mode . "java")
    (awk-mode . "awk")
    ((c-mode c-ts-mode) . "kernel")
    (other . "bsd")))

(use-package rust-mode :ensure t)

(setq treesit-language-source-alist ;; <M-x> treesit-install-language-grammar <CR> {lang}
  '((c "https://github.com/tree-sitter/tree-sitter-c")
    (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
    (rust "https://github.com/tree-sitter/tree-sitter-rust")))

(setq major-mode-remap-alist ;; NOTE: these are different modes with different hooks
  '((c-mode . c-ts-mode)
    (cpp-mode . cpp-ts-mode)
    (rust-mode . rust-ts-mode)))

;; LSP

(use-package eglot
  :ensure t
  :init
  :hook ((c-ts-mode c++-ts-mode rust-ts-mode) . eglot-ensure))

;; Keybinds

(define-key evil-normal-state-map (kbd "C-k") 'whitespace-mode)
(define-key evil-normal-state-map (kbd "SPC j") 'evil-ex-nohighlight)
(define-key evil-visual-state-map (kbd "SPC k") 'evil-ex-sort)

(define-key evil-normal-state-map (kbd "SPC c") 'kill-buffer)
(define-key evil-normal-state-map (kbd "SPC l x") 'flymake-show-buffer-diagnostics)
(define-key evil-normal-state-map (kbd "SPC l a") 'eglot-code-actions)
(define-key evil-normal-state-map (kbd "SPC l r") 'eglot-rename)

;; Other Settings

(set-input-method ;; C-\ to switch
  'russian-computer)
(toggle-input-method)

;; Custom File

;; use M-x customize-variable RET <variable>
(setq custom-file "~/.emacs.custom.el")
(load-file custom-file)
