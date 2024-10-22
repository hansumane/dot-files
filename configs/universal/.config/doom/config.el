;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq scroll-margin 3
      doom-theme 'doom-one
      display-line-numbers-type 'relative
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

(set-input-method ; C-\ to switch
  'russian-computer)
(toggle-input-method)

(map! :leader :desc "Sort lines" "k" #'sort-lines)
(map! :leader :desc "No highlight" "j" #'evil-ex-nohighlight)
(map! :leader "c D" #'lsp-find-references)
;; (map! "C-k" 'whitespace-mode)

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
      org-directory "~/Others/Documents/orgfiles"
      org-hide-emphasis-markers t
      org-superstar-itembullet-alist '((?+ . ?➤) (?- . ?✦))
      org-superstar-headline-bullets-list '("◉" "○" "✸" "✿" "○" "✸" "✿"))

(use-package! org-auto-tangle
  :hook (org-mode . org-auto-tangle-mode)
  :config (setq org-auto-tangle-default t))

(use-package! catppuccin-theme
  :init
  (setq catppuccin-flavor 'mocha)
  :config
  (setq doom-theme 'catppuccin))
  ; (catppuccin-reload))

;; (use-package! gruber-darker-theme
;;   :config (setq doom-theme 'gruber-darker))

(use-package! spaceway-theme
  :load-path "~/.config/doom/manual/spaceway"
  :config (setq doom-theme 'spaceway
                evil-normal-state-cursor '(box "#dc322f")
                evil-insert-state-cursor '(bar "#dc322f")
                evil-visual-state-cursor '(hollow "#dc322f")))

(setq-default display-fill-column-indicator-character ?▏)
(defun set-fill-column-from-editorconfig (props)
  "Set `fill-column' from the `max_line_length' property in .editorconfig."
  (let ((max-line-length (gethash 'max_line_length props)))
    (when max-line-length
      (setq fill-column (string-to-number max-line-length)))))
(add-hook 'editorconfig-after-apply-functions #'set-fill-column-from-editorconfig)
(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'text-mode-hook #'display-fill-column-indicator-mode)

;; org-mode settings
;; #+language: ru
;; #+options: num:nil
;; #+setupfile: https://fniessen.github.io/org-html-themes/org/theme-bigblow.setup
;; #+setupfile: https://fniessen.github.io/org-html-themes/org/theme-readtheorg.setup
