; -*-emacs-lisp-*-

; Uniquify differentiates between files in different locations with the same name
(require 'uniquify)
(setq uniquify-buffer-name-style (quote forward))

; Syntax-highlighting for generic files too!
(require 'generic-x)
(global-font-lock-mode 1)

; Programming
(mapc (lambda (mode)
	(add-hook (intern (concat (symbol-name mode) "-mode-hook"))
		  (lambda ()
		    (setq show-trailing-whitespace t) ; highlight trailing whitespace
		    (show-paren-mode 1)               ; highlight matching parens
		    (setq transient-mark-mode t)      ; highlight marked region
		    )))
      '(emacs-lisp lisp python shell c c++)) ; affected language modes

; C language
(setq c-default-style "bsd"
      c-basic-offset 4)

; Mac key support
(if (string= (getenv "TERM_PROGRAM") "Apple_Terminal")
    (progn (global-set-key (kbd "M-[ 5 d") 'backward-word)
	   (global-set-key (kbd "M-[ 5 c") 'forward-word)
	   )
  )

; Coloration
(cond ((not (null window-system))
       (setq initial-frame-alsit '((background-color . "black")
				   (foreground-color . "ghostwhite")))
       (setq default-frame-alist '((background-color . "black")
				   (foreground-color . "ghostwhite")))
       ))


; other useful bindings
(global-set-key [(control x) (control r)] 'revert-buffer)
(global-set-key [(meta g)] 'goto-line)
;;(global-set-key [(meta G)] 'goto-char)
;;(global-set-key [(control c) (control m)] 'compile)
;;(global-set-key [(meta /)] 'hippie-expand)

; better buffer switching
(global-set-key [(control x) (control b)] 'electric-buffer-list)
(windmove-default-keybindings)

;; Customize section below - touch at your own peril
;; This allows user customizations to override DD's defaults

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )
