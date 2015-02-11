;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ~/.emacs.d/init.el - Emacs Configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package Configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Packages sources
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Plugin free config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(menu-bar-mode -1)           ;; Disable menu bar
(setq make-backup-files nil) ;; Disable backup files
(scroll-bar-mode -1)         ;; Disable scroll bars on GUI mode
(setq gdb-many-windows t)    ;; Multiwindow gdb
(setq scroll-step 1)         ;; Vim like smooth scrolling

;; Tabbing options
(setq-default tab-width 4 indent-tabs-mode nil)       ;; Use 4 spaces for tabs
(setq-default c-basic-offset 4 c-default-style "bsd") ;; C-like language options

;; Remember cursor positions
(require 'saveplace)
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)

;; Enter key auto indents like vim
(define-key global-map (kbd "RET") 'newline-and-indent)

;; Mark tabs, trailing white space, long lines
(require 'whitespace)
(setq whitespace-style '(face empty tabs lines-tail trailing))
(global-whitespace-mode t)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Plugin config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load-theme 'monokai t) ;; monokai theme

(require 'evil)
(evil-mode 1)             ;; Enable evil mode
(global-evil-tabs-mode t) ;; Use evil mode tabs


(require 'relative-line-numbers) ;; Relative line numbers
(add-hook 'prog-mode-hook 'relative-line-numbers-mode t)
(add-hook 'prog-mode-hook 'line-number-mode t)
(add-hook 'prog-mode-hook 'column-number-mode t)


;; Speedbar Configuration
(require 'sr-speedbar)
(global-set-key [f12] 'sr-speedbar-toggle) ;; open with F12
(setq sr-speedbar-right-side nil)          ;; Speedbar on left side
(setq sr-speedbar-skip-other-window-p t)   ;; Switch to speed bar after opening


(require 'fill-column-indicator)
(setq fci-rule-column 80)              ;; Mark 80 columns
(add-hook 'prog-mode-hook 'fci-mode t) ;; Enable

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)


(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)

(define-key ggtags-mode-map (kbd "M-,") 'pop-tag-mark)
