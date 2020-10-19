;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Daniel Theriault"
      user-mail-address "dan@theriault.codes")


;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq
 doom-theme 'doom-one
 doom-font (font-spec :family "monospace" :size 12)
 doom-variable-pitch-font (font-spec :family "sans" :size 12)
 doom-themes-enable-bold t
 doom-themes-enable-italic t)

(set-face-attribute 'font-lock-comment-face nil :slant 'italic)
(set-face-attribute 'font-lock-function-name-face nil :slant 'italic)
(set-face-attribute 'font-lock-variable-name-face nil :slant 'italic)

;; (set-face-attribute 'font-lock-comment-face nil :slant 'italic)


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; save clipboard contents to killring
(setq save-interprogram-paste-before-kill t)

;; disable windows
(frames-only-mode)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(after! evil
  (setq evil-want-C-u-scroll t)
  (evil-define-command custom-save-and-close (file &optional bang)
    "saves current file and closes the buffer"
    :repeat nil
    (interactive "<f><!>")
    (evil-write nil nil nil file bang)
    (kill-this-buffer))

  (evil-ex-define-cmd "q" 'kill-this-buffer)
  (evil-ex-define-cmd "quit" 'evil-quit)
  (evil-ex-define-cmd "x" 'custom-save-and-close)
  (evil-ex-define-cmd "wq" 'custom-save-and-close))

(map!
 :v
 "<" (lambda ()
       (interactive)
       (evil-shift-left (region-beginning) (region-end))
       (evil-normal-state)
       (evil-visual-restore))
 ">" (lambda ()
       (interactive)
       (evil-shift-right (region-beginning) (region-end))
       (evil-normal-state)
       (evil-visual-restore))
 :nm
 "j" 'evil-next-visual-line
 "k" 'evil-previous-visual-line
 :ni "C-p" 'counsel-find-file)
