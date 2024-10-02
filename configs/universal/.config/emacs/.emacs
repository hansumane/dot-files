'(Before-Startup)

(set-frame-font "Iosevka 14" nil t)
(add-to-list 'default-frame-alist
  '(fullscreen . maximized))

'(Packages)

(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile (require 'use-package))

(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
 (setq evil-want-C-u-scroll t)
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  :config
  (evil-mode t))

(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(use-package gruvbox-theme
  :config
  (load-theme 'gruvbox :no-confirm))

(use-package editorconfig
  :config
  (editorconfig-mode 1))

(use-package smex
  :config
  (smex-initialize))

'(Keybinds)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(evil-ex-define-cmd "E" 'evil-edit)

(define-key evil-motion-state-map "SPC" nil)
(define-key evil-normal-state-map (kbd "C-k") 'whitespace-mode)
(define-key evil-normal-state-map (kbd "SPC j") 'evil-ex-nohighlight)
(define-key evil-visual-state-map (kbd "SPC k") 'evil-ex-sort)

'(Other-settings)

(set-input-method  ; C-\ to switch
  'russian-computer)
(toggle-input-method)

(setq custom-file "~/.emacs.custom.el")
(load-file custom-file)
