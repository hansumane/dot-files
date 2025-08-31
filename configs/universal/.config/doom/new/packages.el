;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; (package! some-package)

;; (package! another-package
;;   :recipe (:host github :repo "username/repo"))

;; (package! this-package
;;   :recipe (:host github :repo "username/repo"
;;            :files ("some-file.el" "src/lisp/*.el")))

;; (package! builtin-package :disable t)

;; (package! builtin-package :recipe (:nonrecursive t))
;; (package! builtin-package-2 :recipe (:repo "myfork/package"))

;; (package! builtin-package :recipe (:branch "develop"))

;; (package! builtin-package :pin "1a2b3c4d5e")

;; (unpin! pinned-package)
;; ...or multiple packages
;; (unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;; (unpin! t)

(package! catppuccin-theme)

(package! tree-sitter)
(package! tree-sitter-langs)

(package! xcscope)

(package! nftables-mode)
