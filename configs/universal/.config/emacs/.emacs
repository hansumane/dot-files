;; Before Startup

(set-frame-font "IosevkaTerm Nerd Font 18" nil t)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

;; Packages

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; (use-package evil ;; Basic Vim Bindings for Emacs
;;   :ensure t
;;   :demand t
;;   :init (setq evil-want-C-u-scroll t
;;               evil-want-integration t
;;               evil-want-keybinding nil
;;               evil-undo-system 'undo-redo)
;;   :bind (("<escape>" . keyboard-escape-quit))
;;   :config (evil-mode t))
;;
;; (use-package evil-collection ;; Vim Bindings for various Emacs modes
;;   :after evil
;;   :ensure t
;;   :init (setq evil-want-integration t)
;;   :config (evil-collection-init))
;;
;; (use-package evil-nerd-commenter ;; g c to Comment
;;   :after (evil evil-collection)
;;   :ensure t
;;   :config (evilnc-default-hotkeys)
;;   (define-key evil-visual-state-map (kbd "g c") 'evilnc-comment-operator))

(use-package catppuccin-theme ;; Theme
  :ensure t
  :init (setq catppuccin-flavor 'mocha)
  :config (load-theme 'catppuccin :no-confirm))

(use-package editorconfig ;; File Formatting from .editorconfig
  :ensure t
  :hook prog-mode ;; (editorconfig-mode t)
  :config
  (setq-default display-fill-column-indicator-character ?┃)
  (defun set-fill-column-from-editorconfig (props)
    (let ((max-line-length (gethash 'max_line_length props)))
      (if (and max-line-length (not (string-empty-p max-line-length)))
        (let ((max-length-number (string-to-number max-line-length)))
          (when (> max-length-number 0)
            (set-fill-column max-length-number))))))
  (add-hook 'editorconfig-after-apply-functions #'set-fill-column-from-editorconfig)
  (add-hook 'prog-mode-hook #'display-fill-column-indicator-mode))

(use-package orderless ;; Fuzzy
  :ensure t
  :config (setq completion-styles (cons 'orderless completion-styles)))

(use-package vertico ;; Better than ido and ivy
  :after orderless
  :ensure t
  :config (vertico-mode t))

(use-package corfu ;; Corfu: Completion Overlay Region FUnction
  :after orderless
  :ensure t
  :init (global-corfu-mode t)
  :custom ((corfu-auto t)
           (corfu-auto-prefix 2)
           (corfu-cycle t)
           (corfu-preview-current nil)))

(use-package cape ;; File, Buffer, etc suggestions for Corfu
  :after (vertico corfu)
  :ensure t
  :custom ((cape-dabbrev-check-other-buffers t)
           (cape-dabbrev-downcase nil))
  :init
  (add-to-list 'completion-at-point-functions 'cape-dabbrev)
  (add-to-list 'completion-at-point-functions 'cape-file)
  (add-to-list 'completion-at-point-functions 'cape-keyword))

(use-package marginalia ;; MiniBuffer Annotations
  :after cape
  :ensure t
  :init (marginalia-mode t))

(use-package project
  :ensure t
  :config
  (defvar my/project-root-markers
    '(".project_root" ".luarc.json" "compile_flags.txt" "pyrightconfig.json"))
  (cl-defstruct (my/project (:constructor my/project-create))
    root)
  (cl-defmethod project-root ((project my/project))
    (my/project-root project))
  (defun my/project-try-root (dir)
    (let ((root (seq-some
                  (lambda (marker)
                    (locate-dominating-file dir marker))
                  my/project-root-markers)))
      (when root
        (my/project-create :root root))))
  (add-hook 'project-find-functions #'my/project-try-root))

(use-package which-key ;; Shows Keybinding Descriptions
  :ensure t
  :config (which-key-mode t))

(use-package ibuffer ;; Better buffer list
  :ensure t
  :init
  (defun my/buffer/kill ()
    (interactive)
    (kill-this-buffer))
  (defun my/buffer/revert-keep-scale ()
    (interactive)
    (let ((scale text-scale-mode-amount))
      (revert-buffer :ignore-auto :noconfirm)
      (text-scale-set scale)))
  :bind (("C-x b" . ibuffer)
         ("C-x C-b" . ibuffer)
         ("C-x k" . my/buffer/kill)
         ("C-c r" . my/buffer/revert-keep-scale)))

(use-package flymake ;; Diagnostics
  :ensure t
  :hook prog-mode
  :bind ("C-c l x" . flymake-show-buffer-diagnostics))

(require 'ls-lisp)
(setq ls-lisp-dirs-first t
      ls-lisp-use-insert-directory-program nil)

(use-package git-gutter :ensure t) ;; Shows Git Diff for Buffer File
(use-package vterm :ensure t) ;; Terminal
(use-package magit :ensure t) ;; Git
(use-package rg :ensure t) ;; Ripgrep finder

;; Languages

(setq-default c-default-style
  '((java-mode . "java")
    (awk-mode . "awk")
    ((c-mode c-ts-mode) . "kernel")
    (other . "bsd")))

(use-package rust-mode :ensure t)
;; (use-package lua-mode :ensure t)

(setq treesit-language-source-alist ;; <M-x> treesit-install-language-grammar <CR> {lang}
  '((c "https://github.com/tree-sitter/tree-sitter-c")
    (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
    (rust "https://github.com/tree-sitter/tree-sitter-rust")
    (python "https://github.com/tree-sitter/tree-sitter-python")
    (lua "https://github.com/tjdevries/tree-sitter-lua")))

(setq major-mode-remap-alist ;; NOTE: these are different modes with different hooks
  '((c-mode . c-ts-mode)
    (cpp-mode . cpp-ts-mode)
    (rust-mode . rust-ts-mode)
    (python-mode . python-ts-mode)))

(use-package xcscope ;; Cscope Tags
  :ensure t
  :custom (cscope-option-do-not-update-database t)
  :hook ((c-ts-mode c++-ts-mode) . cscope-minor-mode)
  :config (cscope-setup))

(use-package tree-sitter-langs
  :ensure t
  :config
  (setq tree-sitter-load-path
    '("~/.emacs.d/tree-sitter/"))
  (setq tree-sitter-major-mode-language-alist
    '((c-ts-mode . c)
      (c++-ts-mode . cpp)
      (rust-ts-mode . rust)
      (python-ts-mode . python)
      (lua-mode . lua))))

(use-package tree-sitter
  :after tree-sitter-langs
  :ensure t
  :hook ((c-ts-mode c++-ts-mode rust-ts-mode lua-mode)
         . tree-sitter-hl-mode))

;; LSP

;; (use-package lsp-mode
;;   :ensure t
;;   :init (setq lsp-keymap-prefix "C-c l")
;;   :hook ((c-ts-mode . lsp-deferred)
;;          (c++-ts-mode . lsp-deferred)
;;          (rust-ts-mode . lsp-deferred)
;;          (lsp-mode . lsp-enable-which-key-integration))
;;   :commands (lsp lsp-deferred)
;;   :config (setq
;;             lsp-lens-enable nil
;;             lsp-inlay-hints-mode nil
;;             lsp-enable-on-type-formatting nil
;;             lsp-enable-indentation nil))
;;
;; (use-package lsp-ui
;;   :after lsp-mode
;;   :ensure t)

(use-package eglot
  :ensure t
  :hook ((c-ts-mode . eglot-ensure)
         (c++-ts-mode . eglot-ensure)
         (rust-ts-mode . eglot-ensure)
         (python-ts-mode . eglot-ensure)
         (lua-mode . eglot-ensure))
  :custom ((eglot-autoreconnect t)
           (eglot-autoshutdown t)
           (eglot-ignored-server-capabilities
             '(:inlayHintProvider :documentOnTypeFormattingProvider))))

;; Other Settings

(set-input-method ;; C-\ to switch
  'russian-computer)
(toggle-input-method)

;; Emacs Settings

(use-package emacs
  :bind (("C-c k" . whitespace-mode))
  :custom
  (auto-save-default nil)
  (auto-save-list-file-prefix nil)
  (column-number-mode t)
  (delete-selection-mode nil)
  (display-line-numbers-type 'relative)
  (fill-column 80)
  (global-display-line-numbers-mode t)
  (global-git-gutter-mode t)
  (indent-tabs-mode nil)
  (inhibit-startup-screen t)
  (make-backup-files nil)
  (menu-bar-mode nil)
  (pop-up-windows t)
  (ring-bell-function 'ignore)
  (scroll-bar-mode nil)
  (scroll-conservatively 1)
  (scroll-margin 2)
  (switch-to-buffer-in-dedicated-window 'pop)
  (tool-bar-mode nil)

  ;; org-mode
  (org-startup-truncated nil)
  (org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))

  ;; Corfu for Emacs 30+ (Disable Ispell completion function, try `cape-dict` instead)
  (text-mode-ispell-word-completion nil))

;; Custom File

;; use M-x customize-variable RET <variable>
(setq custom-file "~/.emacs.custom.el")
(load-file custom-file)
