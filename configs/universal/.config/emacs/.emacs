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
;;   :custom ((evil-want-C-d-scroll t)
;;            (evil-want-C-u-scroll t)
;;            (evil-want-integration t)
;;            (evil-want-keybinding nil)
;;            (evil-undo-system 'undo-redo))
;;   :bind (("<escape>" . keyboard-escape-quit)
;;          :map evil-motion-state-map
;;          ("j" . evil-next-visual-line)
;;          ("k" . evil-previous-visual-line))
;;   :config (evil-mode t))
;;
;; (use-package evil-collection ;; Vim Bindings for various Emacs modes
;;   :after evil
;;   :ensure t
;;   :config (evil-collection-init))
;;
;; (use-package evil-nerd-commenter ;; g c to Comment
;;   :after evil-collection
;;   :ensure t
;;   :bind (:map evil-visual-state-map
;;          ("g c" . evilnc-comment-operator))
;;   :config (evilnc-default-hotkeys))

(use-package ef-themes ;; https://protesilaos.com/emacs/ef-themes-pictures
  :ensure t
  ;; :config (load-theme 'ef-owl :no-confirm) ;; dark
  ;; :config (load-theme 'ef-trio-light :no-confirm) ;; light
  )
(use-package modus-themes ;; https://protesilaos.com/emacs/modus-themes-pictures
  :ensure t
  ;; :config (load-theme 'modus-operandi :no-confirm) ;; light
  ;; :config (load-theme 'modus-vivendi-tinted :no-confirm) ;; dark
  )
(use-package catppuccin-theme
  :ensure t
  :init (setq catppuccin-flavor 'mocha)
  :config (load-theme 'catppuccin :no-confirm)
  )

(use-package editorconfig ;; File Formatting from .editorconfig
  :ensure t
  :hook prog-mode ;; (editorconfig-mode t)
  :config
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
  :init (vertico-mode))
  ;; :bind (:map vertico-map
  ;;        ("C-j" . vertico-next)
  ;;        ("C-k" . vertico-previous)))

(use-package corfu ;; Corfu: Completion Overlay Region FUnction
  :after orderless
  :ensure t
  :init (global-corfu-mode t)
  :custom ((corfu-auto t)
           (corfu-auto-prefix 2)
           (corfu-cycle t)
           (corfu-preview-current nil)))
  ;; :bind (:map corfu-map
  ;;        ("C-j" . corfu-next)
  ;;        ("C-k" . corfu-previous)
  ;;        ("C-SPC" . corfu-insert-separator)))

(use-package cape ;; File, Buffer, etc suggestions for Corfu
  :after (vertico corfu)
  :ensure t
  :custom ((cape-dabbrev-check-other-buffers t)
           (cape-dabbrev-downcase nil))
  :init
  (add-to-list 'completion-at-point-functions 'cape-file)
  (add-to-list 'completion-at-point-functions 'cape-dabbrev)
  (add-to-list 'completion-at-point-functions 'cape-keyword))

(use-package marginalia ;; Annotations
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
  (defun my/buffer/kill () (interactive)
    (kill-this-buffer))
  (defun my/buffer/revert-keep-scale () (interactive)
    (let ((scale text-scale-mode-amount))
      (revert-buffer :ignore-auto :noconfirm)
      (text-scale-set scale)))
  :bind (("C-x b" . ibuffer)
         ("C-x C-b" . ibuffer)
         ("C-x k" . my/buffer/kill)
         ("C-c r" . my/buffer/revert-keep-scale))
  :config
  (add-hook 'ibuffer-mode-hook
    (lambda ()
      (add-to-list 'ibuffer-maybe-show-predicates "^\\*Compile-Log\\*$")
      (add-to-list 'ibuffer-maybe-show-predicates "^\\*EGLOT.*events\\*$")
      (add-to-list 'ibuffer-maybe-show-predicates "^\\*Quail Completions\\*$")
      (add-to-list 'ibuffer-maybe-show-predicates "^\\*Native-compile-Log\\*$")
      (add-to-list 'ibuffer-maybe-show-predicates "^\\*Async-native-compile-log\\*$"))))

(use-package flymake ;; Diagnostics
  :ensure t
  :bind (("C-c l x" . flymake-show-buffer-diagnostics)))
         ;; :map evil-normal-state-map
         ;; ("SPC l x" . flymake-show-buffer-diagnostics)))

(use-package ls-lisp
  :ensure nil
  :custom ((ls-lisp-dirs-first t)
           (ls-lisp-use-insert-directory-program nil)))

(use-package dired ;; File manager
  :after ls-lisp
  :ensure nil
  :custom (dired-dwim-target t))

(use-package calendar
  :ensure nil
  :custom (calendar-week-start-day 1))

(use-package git-gutter ;; Shows Git Diff for Buffer File
  :ensure t
  :init (global-git-gutter-mode +1)
  :bind (("C-c g n" . git-gutter:next-hunk)
         ("C-c g p" . git-gutter:previous-hunk)))

(use-package vterm :ensure t) ;; Terminal
(use-package magit :ensure t) ;; Git
(use-package rg :ensure t) ;; RipGrep finder

;; Languages

(setq-default c-default-style
  '((java-mode . "java")
    (awk-mode . "awk")
    ((c-mode c-ts-mode) . "kernel")
    (other . "bsd")))

(use-package rust-mode :ensure t)
(use-package lua-mode :ensure t)

(setq treesit-language-source-alist ;; <M-x> treesit-install-language-grammar <CR> {lang}
  '((c "https://github.com/tree-sitter/tree-sitter-c")
    (cpp "https://github.com/tree-sitter/tree-sitter-cpp")
    (rust "https://github.com/tree-sitter/tree-sitter-rust")
    (lua "https://github.com/tjdevries/tree-sitter-lua")
    (python "https://github.com/tree-sitter/tree-sitter-python")
    (devicetree "https://github.com/joelspadin/tree-sitter-devicetree")))

(setq major-mode-remap-alist ;; NOTE: these are different modes with different hooks
  '(;; (c-mode . c-ts-mode)
    ;; (c++-mode . c++-ts-mode)
    (rust-mode . rust-ts-mode)
    (python-mode . python-ts-mode)))

(use-package xcscope ;; Cscope Tags
  :ensure t
  :custom (cscope-option-do-not-update-database t)
  :hook ((c-mode c-ts-mode c++-mode c++-ts-mode) . cscope-minor-mode)
  :config (cscope-setup))
  ;; (evil-define-key 'normal cscope-list-entry-keymap
  ;;   (kbd "q") 'cscope-bury-buffer))

(use-package tree-sitter-langs
  :ensure t)

(use-package tree-sitter
  :after tree-sitter-langs
  :ensure t
  :hook ((c-mode c-ts-mode c++-mode c++-ts-mode
          rust-ts-mode lua-mode python-ts-mode)
          . tree-sitter-hl-mode)
  :custom ((tree-sitter-major-mode-language-alist
             '((c-mode . c)
               (c-ts-mode . c)
               (c++-mode . cpp)
               (c++-ts-mode . cpp)
               (rust-ts-mode . rust)
               (python-ts-mode . python)
               (lua-mode . lua)))))

;; LSP

(use-package eglot
  :ensure t
  :hook ((c-mode . eglot-ensure) (c-ts-mode . eglot-ensure)
         (c++-mode . eglot-ensure) (c++-ts-mode . eglot-ensure)
         (rust-ts-mode . eglot-ensure)
         (lua-mode . eglot-ensure)
         (python-ts-mode . eglot-ensure))
  :custom ((eglot-autoshutdown t)
           (eglot-autoreconnect t)
           (eglot-ignored-server-capabilities
             '(:inlayHintProvider :documentOnTypeFormattingProvider)))
  :config (add-to-list 'eglot-server-programs
            '((rust-ts-mode rust-mode) .
               ("rust-analyzer" :initializationOptions
                 (:procMacro (:enable t)
                  :check (:command "clippy")
                  :cargo (:buildScripts (:enable t) :features "all"))))))

;; Other Settings

(set-input-method ;; C-\ to switch
  'russian-computer)
(toggle-input-method)

;; Emacs Settings

(use-package emacs
  :bind ("C-c k" . whitespace-mode)
  :custom
  (auto-save-default nil)
  (auto-save-list-file-prefix nil)
  (column-number-mode t)
  (delete-selection-mode nil)
  (display-line-numbers-type 'relative)
  (fill-column 80)
  (global-display-line-numbers-mode t)
  (indent-tabs-mode nil)
  (inhibit-startup-screen t)
  (make-backup-files nil)
  (menu-bar-mode nil)
  (pop-up-windows t)
  (ring-bell-function 'ignore)
  (scroll-bar-mode nil)
  (scroll-conservatively 101)
  (scroll-margin 3)
  (switch-to-buffer-in-dedicated-window 'pop)
  (tool-bar-mode nil)
  (word-wrap t)

  (whitespace-style
    '(face tabs spaces trailing space-before-tab newline indentation
      empty space-after-tab space-mark tab-mark newline-mark))

  ;; org-mode
  (org-startup-truncated nil)
  (org-safe-remote-resources
   '("\\`https://fniessen\\.github\\.io/org-html-themes/org/theme-readtheorg\\.setup\\'"))

  ;; Corfu for Emacs 30+ (Disable Ispell completion function, try `cape-dict` instead)
  (text-mode-ispell-word-completion nil))

;; Custom File: use M-x customize-variable RET <variable>
(setq custom-file "~/.emacs.custom.el")
(load custom-file)
