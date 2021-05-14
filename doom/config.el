;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Daniel Goz"
      user-mail-address "daniel@dgoz.net")

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
(setq doom-font "Fira Mono 14"
      doom-variable-pitch-font "Overpass 14")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

(setq doom-theme 'doom-flatwhite)
;; for dark mode: doom-vibrant, alternate light mode doom-nord-light

;; Determines major mode when scratch buffer is initially opened
(setq doom-scratch-initial-major-mode "org-mode")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Set splash screen images
;; Image taken from https://github.com/jeetelongname/doom-banners
(setq fancy-splash-image "~/dotfiles/doom/cute-demon.png")

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

;; sets auth sources to only use ~/.authinfo file
;; this is primarily for ghub, which is in turn primarily for magit forge
(setq auth-sources '("~/.authinfo"))

(setq evil-snipe-scope 'visible)
(setq evil-snipe-repeat-scope 'whole-buffer)

(setq explicit-shell-file-name (executable-find "fish"))
(setq vterm-shell (executable-find "fish"))

;; ligatures
(setq +ligatures-in-modes '(org-mode))
(setq +ligatures-extras-in-modes '(org-mode))

;; stolen from https://tecosaur.github.io/emacs-config/config.html#better-defaults
(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 window-combination-resize t                      ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                              ; Stretch cursor to the glyph width

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/

;; elfeed configuration
(add-hook! 'elfeed-search-mode-hook 'elfeed-update)

;; autoload jq-mode on jq files
(add-to-list 'auto-mode-alist '("\\.jq$" . jq-mode))

;; mu4e configuration
(after! mu4e
  (setq sendmail-program "/etc/profiles/per-user/dansman805/bin/msmtp"
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail))

(add-load-path! "~/.nix-profile/share/emacs/site-lisp/mu4e")
;; Each path is relative to `+mu4e-mu4e-mail-path', which is ~/.mail by default
(set-email-account! "daniel"
  '((mu4e-sent-folder       . "/daniel/Sent")
    (mu4e-drafts-folder     . "/daniel/Drafts")
    (mu4e-trash-folder      . "/daniel/Trash")
    (mu4e-refile-folder     . "/daniel/Archive")
    (smtpmail-smtp-user     . "daniel@dgoz.net"))
  t)
;; calc configuration
(setq calc-angle-mode 'rad  ; radians are rad
      calc-symbolic-mode t) ; keeps expressions like \sqrt{2} irrational for as long as possible
;; calctex configuration (stolen from https://tecosaur.github.io/emacs-config/config.html#calc-calctex)

(use-package! calctex
  :commands calctex-mode
  :init
  (add-hook 'calc-mode-hook #'calctex-mode)
  :config
  (setq ;; calctex-additional-latex-packages "
;; \\usepackage[usenames]{xcolor}
;; \\usepackage{soul}
;; \\usepackage{adjustbox}
;; \\usepackage{amsmath}
;; \\usepackage{amssymb}
;; \\usepackage{siunitx}
;; \\usepackage{cancel}
;; \\usepackage{mathtools}
;; \\usepackage{mathalpha}
;; \\usepackage{xparse}
;; \\usepack
;; age{arevmath}"
        calctex-additional-latex-macros
        (concat calctex-additional-latex-macros
                "\n\\let\\evalto\\Rightarrow"))
  (defadvice! no-messaging-a (orig-fn &rest args)
    :around #'calctex-default-dispatching-render-process
    (let ((inhibit-message t) message-log-max)
      (apply orig-fn args)))
  ;; Fix hardcoded dvichop path (whyyyyyyy)
  (let ((vendor-folder (concat (file-truename doom-local-dir)
                               "straight/"
                               (format "build-%s" emacs-version)
                               "/calctex/vendor/")))
    (setq calctex-dvichop-sty (concat vendor-folder "texd/dvichop")
          calctex-dvichop-bin (concat vendor-folder "texd/dvichop")))
  (unless (file-exists-p calctex-dvichop-bin)
    (message "CalcTeX: Building dvichop binary")
    (let ((default-directory (file-name-directory calctex-dvichop-bin)))
      (call-process "make" nil nil nil))))

;; keybindings
(map! :leader
      :desc "Mixed-pitch mode"
      "t m" #'mixed-pitch-mode)

(map! :leader
      :desc "Take a screenshot"
      "S" #'screenshot)


(map! :leader
      :desc "Show top level keybinds"
      "h b T" #'tlk/show)
