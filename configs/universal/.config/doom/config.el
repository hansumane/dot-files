;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq scroll-margin 3
      doom-theme 'doom-one
      display-line-numbers-type 'relative
      user-full-name "User" user-mail-address "user@example.com"
      doom-font (font-spec :family "Iosevka Nerd Font" :size 18 :weight 'medium)
      doom-big-font (font-spec :family "Iosevka Nerd Font" :size 18 :weight 'medium)
      doom-serif-font (font-spec :family "Iosevka Nerd Font" :size 18 :weight 'medium)
      doom-symbol-font (font-spec :family "Iosevka Nerd Font" :size 18 :weight 'medium)
      doom-variable-pitch-font (font-spec :family "Iosevka Nerd Font" :size 18 :weight 'medium))
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq c-default-style
    '((java-mode . "java")
      (awk-mode . "awk")
      ;(c-mode . "gnu")
      (other . "doom")))

(map! :leader "k" #'sort-lines)
(map! :leader "j" #'evil-ex-nohighlight)
(map! :leader "c D" #'lsp-find-references)
(set-input-method  ; C-\ to switch
    'russian-computer)
(toggle-input-method)

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

(setq org-ellipsis " ▼ "
      org-directory "~/org/"
      org-hide-emphasis-markers t
      org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦))
      org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "○" "✸" "✿"))
(use-package! org-auto-tangle
    :hook (org-mode . org-auto-tangle-mode)
    :config (setq org-auto-tangle-default t))

;; (use-package! catppuccin-theme
;;     :config
;;     (setq doom-theme 'catppuccin
;;           catppuccin-flavor 'mocha)
;;     (catppuccin-reload))

;; (use-package! gruber-darker-theme
;;     :config (setq doom-theme 'gruber-darker))

;; (use-package! spaceway-theme
;;     :load-path "~/.config/doom/manual/spaceway"
;;     :config (setq doom-theme 'spaceway
;;                   evil-normal-state-cursor '(box "#dc322f")
;;                   evil-insert-state-cursor '(bar "#dc322f")
;;                   evil-visual-state-cursor '(hollow "#dc322f")))

;; org-mode settings
;; #+language: ru
;; #+options: num:nil
;; #+setupfile: https://fniessen.github.io/org-html-themes/org/theme-bigblow.setup
;; #+setupfile: https://fniessen.github.io/org-html-themes/org/theme-readtheorg.setup
