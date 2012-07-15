(custom-set-variables
 '(inhibit-startup-screen t)
 '(org-modules (quote (org-bbdb org-bibtex org-gnus org-info org-jsinfo org-habit org-irc org-mew org-mhe org-rmail org-vm org-wl org-w3m)))
 '(save-place t nil (saveplace))
 '(scroll-bar-mode nil))

;; Default font...
(set-default-font "Droid Sans Mono Slashed-18")

;; Suppress icon bar.
(tool-bar-mode 0)

;; Saves auto saves in /tmp.
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))
    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; Word wrap by default.
(global-visual-line-mode 1)

;; Colored shell output.
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Turn off stupid alert noise, my god.
(setq ring-bell-function 'ignore)

;; Fontifies my buffer, prettily.
(global-font-lock-mode 1)

;; Delete highlighted text on keypress.
(delete-selection-mode t)

;; Smooth scroll!
(defun smooth-scroll (increment)
  (scroll-up increment) (sit-for 0.05)
  (scroll-up increment) (sit-for 0.02)
  (scroll-up increment) (sit-for 0.02)
  (scroll-up increment) (sit-for 0.05)
  (scroll-up increment) (sit-for 0.06)
  (scroll-up increment))

;; Binds smooth scroll.
(global-set-key [(mouse-5)] '(lambda () (interactive) (smooth-scroll 1)))
(global-set-key [(mouse-4)] '(lambda () (interactive) (smooth-scroll -1)))

;; Keybinds.
(global-set-key [\C-right] 'switch-to-buffer)
(global-set-key "\C-q" 'save-buffers-kill-emacs)
(global-set-key "\C-z" 'undo)
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)
(global-set-key "\C-c_w" 'whitespace-mode)
(global-set-key "\C-c_t" 'whitespace-toggle-options)
(global-set-key "\C-c=w" 'global-whitespace-mode)
(global-set-key "\C-c=t" 'global-whitespace-toggle-options)

;; Color Theme
(add-to-list 'load-path "/Users/cole/.emacs.d/plugins")
(require 'color-theme)
;; (color-theme-initialize)
(load "~/.emacs.d/tomorrow")
(color-theme-tomorrow-night)
(custom-set-faces
)

;; Set tab width to 4 spaces.
(setq indent-tabs-mode t)
(setq-default tab-width 4)

;; Make python-mode indent stupidly.
(add-hook 'python-mode-hook
		  (lambda ()
			(setq indent-tabs-mode t)
			(setq python-indent 4)
			(setq tab-width 4)))

;; fill 'er up
(setq initial-frame-alist
      `((left . 0) (top . 0)
        (width . 237) (height . 65)))

;; Dual screen bro
(split-window-horizontally)

;; git support
(add-to-list 'load-path "~/.emacs.d/git-emacs")
(require 'git-emacs)
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
