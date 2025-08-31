;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

(setq
  scroll-margin 3
  doom-theme 'doom-one
  display-line-numbers-type 'relative
  doom-font (font-spec :family "IosevkaTerm Nerd Font" :size 18 :weight 'medium)
  doom-big-font (font-spec :family "IosevkaTerm Nerd Font" :size 18 :weight 'medium)
  doom-serif-font (font-spec :family "IosevkaTerm Nerd Font" :size 18 :weight 'medium)
  doom-symbol-font (font-spec :family "IosevkaTerm Nerd Font" :size 18 :weight 'medium)
  doom-variable-pitch-font (font-spec :family "IosevkaTerm Nerd Font" :size 18 :weight 'medium)
  org-ellipsis " ▼ "
  org-directory "~/org/"
  org-hide-emphasis-markers t
  ;; FIXME: org-superstar-* things doesn't work anymore
  ;; org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦))
  ;; org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "○" "✸" "✿")
  confirm-kill-emacs nil
  lsp-lens-enable nil)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))
(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(setq c-default-style
  '((java-mode . "java")
    (awk-mode . "awk")
    ;; (c-mode . "gnu")
    (other . "doom")))

(set-input-method ;; C-\ to switch
  'russian-computer)
(toggle-input-method)

(map! :leader :desc "No highlight" "j" #'evil-ex-nohighlight)

(custom-theme-set-faces! 'doom-one
  '(line-number-current-line
     :inherit line-number
     :foreground "#51afef"))

(custom-theme-set-faces! 'doom-ayu-dark
  '(line-number-current-line
     :inherit line-number
     :foreground "#e6b450"))

(custom-theme-set-faces! 'doom-old-hope
  '(line-number-current-line
     :inherit line-number
     :foreground "#fedd38"))

(custom-theme-set-faces! 'doom-oceanic-next
  '(line-number-current-line
     :inherit line-number
     :foreground "#fec061"))

(use-package! whitespace
  :init
  (defun whitespace-mode-switch ()
    (interactive)
    (if whitespace-style
      (setq whitespace-style '())
      (setq whitespace-style '(face tabs tab-mark spaces space-mark indentation trailing)))
    (global-whitespace-mode -1)
    (global-whitespace-mode +1))
  :config
  (setq whitespace-style '())
  (global-whitespace-mode +1)
  (map! :leader :desc "Whitespaces" "k" #'whitespace-mode-switch))

(use-package! catppuccin-theme
  :init (setq catppuccin-flavor 'mocha)
  :config (setq doom-theme 'catppuccin))
  ;; (catppuccin-reload)

(use-package! tree-sitter-langs
  :config
  (setq tree-sitter-load-path
    '("~/.local/share/nvim/site/treesitter/parser/"))
  (setq tree-sitter-major-mode-language-alist
    '((c-mode . c)
      (cpp-mode . cpp)
      (lua-mode . lua)
      (python-mode . python)
      (sh-mode . bash))))

(use-package! tree-sitter
  :after tree-sitter-langs
  :hook ((c-mode cpp-mode lua-mode python-mode sh-mode)
         . tree-sitter-hl-mode))

(use-package! xcscope
  :config
  (setq cscope-option-do-not-update-database t)
  (cscope-setup))

(setq-default display-fill-column-indicator-character ?┃)
(defun set-fill-column-from-editorconfig (props)
  (let ((max-line-length (gethash 'max_line_length props)))
    (when max-line-length
      (setq fill-column (string-to-number max-line-length)))))
(add-hook 'editorconfig-after-apply-functions #'set-fill-column-from-editorconfig)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)

(defun revert-buffer-keep-scale ()
  (interactive)
  (let ((scale text-scale-mode-amount))
    (revert-buffer :ignore-auto :noconfirm)
    (text-scale-set scale)))
(map! :leader :desc "Revert buffer keep scale" "b r" #'revert-buffer-keep-scale)

;; org-mode settings
;; #+language: ru
;; #+options: num:nil
;; #+setupfile: https://fniessen.github.io/org-html-themes/org/theme-bigblow.setup
;; #+setupfile: https://fniessen.github.io/org-html-themes/org/theme-readtheorg.setup
