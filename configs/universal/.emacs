(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(require 'evil)
(require 'company)
(require 'lsp-mode)
(require 'flycheck)
(require 'editorconfig)
(require 'gruber-darker-theme)

(load-theme 'gruber-darker t)
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(set-frame-font "CaskaydiaCove Nerd Font 14" nil t)

(global-display-line-numbers-mode 1)
(setq-default display-line-numbers-type 'relative
              ring-bell-function 'ignore
              show-trailing-whitespace t
              inhibit-startup-message t
              make-backup-files nil
              visible-bell nil
              scroll-margin 3
              fill-column 80)
(editorconfig-mode 1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(evil-mode 1)

(use-package lsp-mode
  :config
  (setq lsp-idle-delay 0.5
        lsp-enable-symbol-highlighting t
        lsp-enable-snippet nil)
  :hook
  (python-mode . lsp)   ;; pip3: python-lsp-server[all]
  (c++-mode . lsp)      ;; clang (clangd)
  (c-mode . lsp)        ;; clang (clangd)
)

(custom-set-variables
  '(package-selected-packages
    '(flycheck company lsp-mode editorconfig evil gruber-darker-theme)))
