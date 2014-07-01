;;; -*- lexical-binding: t -*-

(menu-bar-mode -1)
(tool-bar-mode -1)
(set-scroll-bar-mode 'left)

;; start emacsclient server

(server-start)

;;; melpa.milkbox.net
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(setq package-enable-at-startup nil)
(package-initialize)

;;; globalne

(setq default-tab-width 4)

; font - terminus
;(set-default-font "-xos4-terminus-medium-*-*-*-14-*-*-*-*-*-*-2")
;(set-default-font "-misc-monaco-*-*-*--14-*-*-*-*-*-iso8859-2")
(set-default-font "Consolas-9")
;(set-default-font "Envy Code R-11")
;(set-default-font "inconsolata-11")
;(set-default-font "Consolas-11")
;(set-default-font "Terminus-9")
;(add-to-list 'default-frame-alist '(font . "Terminus-13"))
(add-to-list 'default-frame-alist '(font . "Consolas-9"))

; global colouring
(global-font-lock-mode)
(column-number-mode 'nil) ; like it

; oc
(add-to-list 'load-path "/home/mjanczyk/.emacs.d")

;;; prevent tramp changing remote file permissions
(setq backup-by-copying t
		backup-directory-alist
		'(("." . "~/.saves")))


(load-theme 'zenburn
	    t                           ; treat as safe
	    nil                         ; enable
	    )

(setq max-lisp-eval-depth 1000)

;(if window-system
;    (color-theme-zenburn)
;  (color-theme-dark-laptop))

(global-linum-mode)

;; cc-mode
(setq c-basic-offset 4)

;; default browser
(setq browse-url-browser-function 'w3m-browse-url)

;; Obsługa okien - skróty; tylko w X-windows?
(windmove-default-keybindings)
(defun ignore-error-wrapper (fn)
  "Funtion return new function that ignore errors.
   The function wraps a function with `ignore-errors' macro."
  (let ((fn fn))
    (lambda ()
      (interactive)
      (ignore-errors
        (funcall fn)))))
(global-set-key [s-left] (ignore-error-wrapper 'windmove-left))
(global-set-key [s-right] (ignore-error-wrapper 'windmove-right))
(global-set-key [s-up] (ignore-error-wrapper 'windmove-up))
(global-set-key [s-down] (ignore-error-wrapper 'windmove-down))
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<up>") 'shrink-window)
(global-set-key (kbd "S-C-<down>") 'enlarge-window)

(apply '(lambda () (print 1)) ())

;;; remove 'write mail' keybinding
(global-unset-key (kbd "C-x m"))

;;; add find-file-in-project keybinding
(global-set-key (kbd "C-x f") 'find-file-in-project)
(setq ffip-patterns
      '("*.html" "*.org" "*.txt" "*.md" "*.el" "*.clj" "*.py" "*.rb" "*.js" "*.pl"
	"*.sh" "*.erl" "*.hs" "*.ml" "*.java" "*.jsp"))


;; config automatyczny
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(c-default-style (quote ((c-mode . "my-cc-style") (c++-mode . "my-cc-style") (java-mode . "java") (awk-mode . "awk") (other . "gnu"))))
 '(canlock-password "1fffe3899287c24dc3ae100c0d1058c5a830d31d")
 '(case-fold-search t)
 '(current-language-environment "UTF-8")
 '(custom-safe-themes (quote ("11d069fbfb0510e2b32a5787e26b762898c7e480364cbc0779fe841662e4cf5d" "2ed05ad19fa69927c7e19abd73465dbee92ae6b89b24cbfd33d6c12b64568e5a" default)))
 '(default-input-method "rfc1345")
 '(global-font-lock-mode t nil (font-lock))
 '(gnus-treat-display-smileys nil)
 '(gnus-treat-fill-long-lines t)
 '(gnus-treat-wash-html nil)
 '(haskell-program-name "ghci \"+.\"")
 '(inhibit-startup-screen t)
 '(js2-basic-offset 4)
 '(js2-bounce-indent-p t)
 '(js2-cleanup-whitespace t)
 '(js2-mode-indent-ignore-first-tab t)
 '(max-lisp-eval-depth 1000)
 '(minimap-always-recenter t)
 '(minimap-recenter-type (quote free))
 '(minimap-width-fraction 0.23)
 '(mlint-programs (quote ("mlint" "glnxa64/mlint" "/home/matlab/bin/glnx86/mlint")))
 '(quack-default-program "racket")
 '(quack-fontify-style nil)
 '(quack-programs (quote ("plt-r6rs" "racket" "bigloo" "csi" "csi -hygienic" "gosh" "gsi" "gsi ~~/syntax-case.scm -" "guile" "kawa" "mit-scheme" "mred -z" "mzscheme" "mzscheme -il r6rs" "mzscheme -il typed-scheme" "mzscheme -M errortrace" "mzscheme3m" "mzschemecgc" "rs" "scheme" "scheme48" "scsh" "sisc" "stklos" "sxi")))
 '(quack-smart-open-paren-p nil)
 '(safe-local-variable-values (quote ((erlang-indent-level . 2)))))

;;; Licz słowa.

;;; Final version: while
(defun count-words-region (beginning end)
  "Print number of words in the region."
  (interactive "r")
  (message "Counting words in region ... ")

;;; 1. Set up appropriate conditions.
  (save-excursion
    (let ((count 0))
      (goto-char beginning)

;;; 2. Run the while loop.
      (while (and (< (point) end)
                  (re-search-forward "\\w+\\W*" end t))
        (setq count (1+ count)))

;;; 3. Send a message to the user.
      (cond ((zerop count)
             (message
              "The region does NOT have any words."))
            ((= 1 count)
             (message
              "The region has 1 word."))
            (t
             (message
              "The region has %d words." count))))))

;;; C mode hook
(c-add-style "my-cc-style" 
	     '("cc-mode"
	       (c-offsets-alist . ((innamespace . [0])))))

(defun my-c-mode-hook ()
  ;; indent with spaces only
  (c-set-style "my-cc-style")
  (setq indent-tabs-mode nil))

(defun my-cc-mode-hook ()
  (c-set-style "my-cc-style")
  (setq indent-tabs-mode nil))

(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-cc-mode-hook)

(require 'auto-complete-clang-async)

(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/soft/emacs-clang-complete-async/clang-complete")
  (setq ac-sources '(ac-source-clang-async))
  (ac-clang-launch-completion-process))

(defun my-ac-config ()
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
  ;; (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(my-ac-config)

;;; HideShow minor mode, Highlight-symbol-mode

(setq highlight-symbol-idle-delay 0)

(defun enable-show-trailing-whitespace ()
  (setq show-trailing-whitespace t))

(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'c-mode-common-hook 'highlight-symbol-mode)
(add-hook 'c-mode-common-hook 'highlight-parentheses-mode)
(dolist (x '(emacs-lisp lisp java perl sh python erlang haskell))
  (let ((target-hook (intern (concat (symbol-name x) "-mode-hook"))))
    (add-hook target-hook 'hs-minor-mode)
    (add-hook target-hook 'highlight-symbol-mode)
    (add-hook target-hook 'highlight-parentheses-mode)
    (add-hook target-hook 'enable-show-trailing-whitespace)))
;;; haskell-mode-hook indentation
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)

;;; map hide-show mode keybindings
(setq hs-minor-mode-map
      (let ((map (make-sparse-keymap)))
	(define-key map (kbd "C-c @ h")    'hs-hide-block)
	(define-key map (kbd "C-c @ s")    'hs-show-block)
	(define-key map (kbd "C-c @ H")    'hs-hide-all)
	(define-key map (kbd "C-c @ S")    'hs-show-all)
	(define-key map (kbd "C-c @ l")    'hs-hide-level)
	(define-key map (kbd "C-c @ c")    'hs-toggle-hiding)
	(define-key map [(shift mouse-2)]  'hs-mouse-toggle-hiding)
	map))

(add-hook 'hs-minor-mode-hook
	  (lambda ()
	    ))

; ;;; DISTEL - erlang mode++

;(add-to-list 'load-path
; 	     (car (file-expand-wildcards "/opt/erlang/r15b03/lib/erlang/lib/tools-*/emacs")))
;(setq erlang-root-dir "/opt/erlang/r15b03/lib/erlang")
;(setq exec-path (cons "/opt/erlang/r15b03/lib/erlang/bin" exec-path))
;(require 'erlang-start)
;
;(add-to-list 'load-path "/home/mjanczyk/soft/distel-lmilewski/elisp")
;(require 'distel)
;(distel-setup)

;;; Erlang mode hook
(add-hook 'erlang-mode-hook 'my-erlang-mode-hook)
; 
(defun my-erlang-mode-hook ()
  (erlang-extended-mode t)
  ;; indent with spaces only
  (setq indent-tabs-mode nil)
  (setq show-trailing-whitespace t)
  ;; when starting an Erlang shell in Emacs, default in the node name
  (setq inferior-erlang-machine-options '("-sname" "emacs"))
  (define-key erlang-mode-map (kbd "C-c C-g") 'uncomment-region))

;; A number of the erlang-extended-mode key bindings are useful in the shell too
(defconst distel-shell-keys
 '(("\C-\M-i"   erl-complete)
   ("\M-?"      erl-complete)
   ("\M-."      erl-find-source-under-point)
   ("\M-,"      erl-find-source-unwind)
   ("\M-*"      erl-find-source-unwind)
   )
 "Additional keys to bind when in Erlang shell.")

(add-hook 'erlang-shell-mode-hook
         (lambda ()
           ;; add some Distel bindings to the Erlang shell
           (dolist (spec distel-shell-keys)
             (define-key erlang-shell-mode-map (car spec) (cadr spec)))))

;;; indent whole region
(defun indent-buffer ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))


(global-set-key "%" 'match-paren)
(defun match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
	((looking-at "\\s\)") (forward-char 1) (backward-list 1))
	(t (self-insert-command (or arg 1)))))

;;; js2-mode

(add-hook 'js2-mode-hook 'my-js2-mode-hook)

(defun my-js2-mode-hook ()
  (setq indent-tabs-mode nil)
  (setq indent-line-function 'insert-tab)
  (setq show-trailing-whitespace t)
  (setq tab-width 4)
  (define-key js2-mode (kbd "C-c C-g") 'uncomment-region))

(defun my-js-mode-hook ()
  (setq show-trailing-whitespace t)
  (setq indent-tabs-mode nil))

(add-hook 'js-mode-hook 'my-js-mode-hook)

;;; crappy-jsp-mode
;; (require 'crappy-jsp-mode)
;; (add-to-list 'auto-mode-alist '("\\.jsp\\'" . crappy-jsp-mode))

;;; web-mode
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;;; ------------------------------------------------------------
;;; django-html-mumamo-mode django-mode django-mode-hook
;;; ------------------------------------------------------------

(autoload 'django-html-mumamo-mode "~/.emacs.d/nxhtml/autostart.el")
;;(setq auto-mode-alist
;;      (append '(("\\.html?$" . django-html-mumamo-mode)) auto-mode-alist))
(setq mumamo-background-colors nil) 
;; (add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

;;; https://gist.github.com/tkf/3951163
;; Workaround the annoying warnings:
;; Warning (mumamo-per-buffer-local-vars):
;; Already 'permanent-local t: buffer-file-name
(when (string< "24.1" (format "%d.%d" emacs-major-version emacs-minor-version))
  ;; (and (equal emacs-major-version 24)
  ;;		   (equal emacs-minor-version 2))
  (eval-after-load "mumamo"
	'(setq mumamo-per-buffer-local-vars
		   (delq 'buffer-file-name mumamo-per-buffer-local-vars))))

(defun my-django-mode-hook ()
  (setq indent-tabs-mode nil))
(add-hook 'django-mode-hook 'my-django-mode-hook)

;;; ------------------------------------------------------------
;;; ------------------------------------------------------------
