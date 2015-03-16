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
(setq scroll-step 1)         ;; Vim like smooth scrolling
(setq gdb-many-windows t)    ;; Multiwindow gdb

;; Enable Line numbers for programming and text
(add-hook 'prog-mode-hook (lambda () (linum-mode 1)))
(add-hook 'text-mode-hook (lambda () (linum-mode 1)))

;; GUI Configuration
(scroll-bar-mode -1)         ;; Disable scroll bars
(tool-bar-mode -1)           ;; Disable the toolbar

;; Tabbing options
(setq-default tab-width 4 indent-tabs-mode nil)       ;; Use 4 spaces for tabs
(setq-default c-basic-offset 4 c-default-style "bsd") ;; C-like language options

;; Remember cursor positions
(require 'saveplace)
(setq save-place-file "~/.emacs.d/saveplace")
(setq-default save-place t)

;; Enter key auto indents like vim
(define-key global-map (kbd "RET") 'newline-and-indent)


;; White space marking
(require 'whitespace)
(setq whitespace-style
      '(face          ;; Display errors using faces
        tabs tab-mark ;; Display tabs with a face and a symbol
        trailing      ;; trailing spaces
        lines         ;; Lines at end of file
        empty))       ;; Empty lines at beginning or end
(global-whitespace-mode t)

;; Map compile mode
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

;; Store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Plugin config
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(load-theme 'monokai t)                               ;; monokai theme

(require 'evil)
(evil-mode 1)                                         ;; Enable evil mode
(define-key evil-normal-state-map (kbd "m") 'evil-ex) ;; map m to evil ex

(require 'key-chord)      ;; jj for escape key in evil mode
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)


(require 'linum-relative) ;; Use relative line numbers

(require 'sr-speedbar) ;; Speedbar Configuration
(global-set-key [f12] 'sr-speedbar-toggle) ;; open with F12
(setq sr-speedbar-right-side nil)          ;; Speedbar on left side
(setq sr-speedbar-skip-other-window-p t)   ;; Switch to speed bar after opening


(require 'fill-column-indicator)
(setq fci-rule-column 80)              ;; Mark 80 columns
(add-hook 'prog-mode-hook 'fci-mode t) ;; Enable in prog mode
(add-hook 'text-mode-hook 'fci-mode t) ;; Enable in text mode


(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))


(require 'ggtags)
(add-hook 'c-mode-common-hook
          (lambda ()
            (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
              (ggtags-mode 1))))

;; Key bindings
(define-key evil-normal-state-map (kbd "C-]") 'ggtags-find-tag-dwim)
(define-key ggtags-mode-map (kbd "C-c g s") 'ggtags-find-other-symbol)
(define-key ggtags-mode-map (kbd "C-c g h") 'ggtags-view-tag-history)
(define-key ggtags-mode-map (kbd "C-c g r") 'ggtags-find-reference)
(define-key ggtags-mode-map (kbd "C-c g f") 'ggtags-find-file)
(define-key ggtags-mode-map (kbd "C-c g c") 'ggtags-create-tags)
(define-key ggtags-mode-map (kbd "C-c g u") 'ggtags-update-tags)


;;(require 'company)
;;(add-hook 'after-init-hook 'global-company-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Language configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq js-indent-level 2) ;; Indent JS with 2 spaces
