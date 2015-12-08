;; Начало инициализации
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives
               '("melpa-stable" . "http://stable.melpa.org/packages/") t)
  (package-initialize))

;; My name and email
(setq user-full-name "%user-name%")
(setq user-mail-address "%user-mail%")

;; (add-to-list 'load-path "/home/rhexo/.emacs.d/badger-theme")
;; (add-to-list 'load-path "/home/rhexo/.emacs.d/colorsarenice-theme")
;; ;; load-theme
;; (load-theme 'wombat t)
;; (require 'colorsarenice-dark-theme)

;; Dired
(require 'dired)
(setq dired-recursive-deletes 'top)


;; Imenu
(require 'imenu)
(setq imenu-auto-rescan t)
(setq imenu-use-popup-menu nil) ;; Диалоги imenu в минибуфере

;; Display the name of the current buffer in the title bar
(setq frame-title-format "GNU Emacs: %b")

;; Show-paren-mode settings
(show-paren-mode t) ;; Включить выделения выражений между {}, [], ()
;;(setq show-paren-style 'expression) ;; Выделить цветом выражения между {}, [], ()

;; Electric-modes settings
(electric-pair-mode 1) ;; Автозакрытие {}, [], () с переводом курсора внутрь скобок
(electric-indent-mode -1) ;; Отключить индентацию (default in Emacs-24.4)

;; Delete selection
(delete-selection-mode t)

;; Disable GUI components
(tooltip-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
;;(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; Linum plugin
(require 'linum)
(line-number-mode t)
(global-linum-mode t)
(column-number-mode t)
(setq linum-format "  %d ")

;; Fringe settings
(setq-default indicate-empty-lines t)  ;; Отсутствие строки выделить глифами рядом с полоской с номером строки
(setq-default indicate-buffer-boundaries 'left) ;; Индикация только слева

;; Display file size/time in mode line
(setq display-time-24hr-format t) ;; 24-часовой временной формат в mode-line
(display-time-mode t) ;; показывать часы в mode-line
(size-indication-mode t) ;; размер файла в процентах

;; Line wrapping
(setq word-wrap t) ;; переносить по словам
(global-visual-line-mode t)

;; IDO plugin
(require 'ido)
(ido-mode t)
(icomplete-mode t)
(ido-everywhere t)
(setq ido-virtual-buffer t)
(setq ido-enable-flex-matching t)

;; Syntax highlighting
(require 'font-lock)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; Indent settings
(setq-default indent-tabs-mode nil)  ;; Отключить возможность ставить отступы Tab-ом
(setq-default tab-width 2)
(setq-default c-basic-offset 2)
(setq-default standard-indent 2)
(setq-default lisp-body-indent 2)
(global-set-key (kbd "RET") 'newline-and-indent)

;; Scrolling settings
(setq scroll-step 4) ;; вверз вниз по одной строке

;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)

;; Clipboard settings
;; (setq x-select-enable-clipboard t)

;; End of file newlines
(setq require-final-newline t) ;; Добавить новую пустую строку в конце файла
(setq next-line-add-newlines nil) ;; Не добавлять новую строку при смещении курсора

;; Highlight search results
(setq search-highlight t)
(setq query-replace-highlight t)

;; Easy transition between buffer: M-arrow-keys
(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))


;; Delete trailing whitespaces, format buffer and untabify when save buffer
(defun format-current-buffer()
  (indent-region (point-min)(point-max)))
(defun untabify-current-buffer()
  (if (not indent-tabs-mode)
      (untabify (point-min)(point-max)))
  nil)

(defun my:space-format-hook()
  (add-to-list 'write-file-functions 'format-current-buffer)
  (add-to-list 'write-file-functions 'untabify-current-buffer)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))


;; org-mode configure
(require 'org)

;; the following lines are always needed. Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)

;; (global-set-key "\C-cc" 'org-capture)
;; (global-set-key "\C-cb" 'org-iswitchb)
(setq org-log-done t)

(setq org-replace-disputed-keys)

;; agenda global files configure
(setq org-agenda-files( list "~/ydisk/proj/websnap/websnap.blup.org"
                             "~/ydisk/proj/app-lib/orgmode-instr.org"))

(add-hook 'org-mode-hook
          (lambda() (define-key org-mode-map (kbd "<f7>") 'org-insert-heading)))


(add-hook 'c++-mode-hook 'my:space-format-hook)
(add-hook 'c-mode-hook 'my:space-format-hook)
(add-hook 'lisp-mode-hook 'my:space-format-hook)
(add-hook 'emacs-lisp-mode-hook 'my:space-format-hook)

(setq-default truncate-lines 1)

;; .h as .hpp.open in c++ mdoe.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Display full pathname for files
(add-hook 'find-file-hooks
          '(lambda ()
             (setq mode-line-buffer-identification 'buffer-file-truename)))

(require 'yasnippet)
(yas-global-mode 1)


(require 'irony)
;; Setups irony-mode
(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)
(add-hook 'objc-mode-hook 'irony-mode)

(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; setups company-mode
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

;; Has a bug : variable void reference for irony--working-directory
;; (add-to-list 'load-path "/home/rhexo/.emacs.d/company-irony-c-headers")
;; (require 'company-irony-c-headers)

;; setups company-irony
(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))
;; (eval-after-load 'company
;;   '(add-to-list 'company-backends '(company-irony-c-headers company-irony)))

(add-hook 'c-mode-hook
          (lambda() (define-key c-mode-map (kbd "C-c TAB") 'irony-completion-at-point-async)))
(add-hook 'c++-mode-hook
          (lambda() (define-key c++-mode-map (kbd "C-c TAB") 'irony-completion-at-point-async)))

;; Bookmarks settings
(require 'bookmark)
(setq bookmark-save-flag t) ;; автоматически сохранять закладки в файл
(when (file-exists-p (concat user-emacs-directory "bookmarks"))
  (bookmark-load bookmark-default-file t)) ;; попытаться найти и открыть файл с закладками
(global-set-key (kbd "<f3>") 'bookmark-set) ;; создать закладку
(global-set-key (kbd "<f4>") 'bookmark-jump) ;; прыгнуть на закладку по F4
(global-set-key (kbd "<f5>") 'bookmark-bmenu-list) ;; открыть список закладок
(setq bookmark-default-file (concat user-emacs-directory "bookmarks")) ;; хранить закадки в файле bookmarks

;; install from github repo
;; git clone https://github/bbatsov/projectile.git
;;
;; projectile setup
(add-to-list 'load-path "/home/rhexo/.emacs.d/projectile")

(require 'projectile)
(projectile-global-mode)

(require 'helm-projectile)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(setq projectile-switch-project-action 'helm-projectile)

(setq projectile-tags-command "/usr/local/bin/exctags -Re -f \"%s\" %s")

;;(load "setup-helm.el")
(require 'helm-config)
;; (require 'helm-gtags)

(global-set-key (kbd "C-M-x") 'helm-M-x)

;; (setq
;;  helm-gtags-ignore-case t
;;  helm-gtags-auto-update t
;;  helm-gtags-use-input-at-cursor t
;;  helm-gtags-pulse-at-cursor t
;;  helm-gtags-prefix-key "\C-cg"
;;  helm-gtags-suggested-key-mapping t
;;  helm-gtags-path-style 'relative)

;; (add-hook 'c-mode-hook 'helm-gtags-mode)
;; (add-hook 'c++-mode-hook 'helm-gtags-mode)
;; (add-hook 'asm-mode-hook 'helm-gtags-mode)


;;Настраиваем  cmake-project-mode

(add-to-list 'load-path "/home/rhexo/.emacs.d/emacs-cmake-project")
(require 'cmake-project)

(defun maybe-cmake-project-hook ()
  (if (file-exists-p "CMakeLists.txt") (cmake-project-mode)))

(add-hook 'c-mode-hook 'maybe-cmake-project-hook)
(add-hook 'c++-mode-hook 'maybe-cmake-project-hook)

;; default build directory for cmake build
(setq cmake-project-default-build-dir-name "build/")

;; Enable cmake mode (syntax highlite for CMakeLists.txt)
(autoload 'cmake-mode "/home/rhexo/.emacs.d/cmake-mode.el" t)

(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))

;; setup cmake-ide
;; (cmake-ide-setup)
;; (setq cmake-ide-dir "/build")


(require 'compile)
(require 'cc-mode)
;; Binding compile futures
(add-hook 'c-mode-hook
          (lambda() (define-key c-mode-map (kbd "C-c c") 'compile)))
(add-hook 'c++-mode-hook
          (lambda() (define-key c++-mode-map (kbd "C-c c") 'compile)))
;; cmake-project
(add-hook 'c++-mode-hook
          (lambda() (define-key c++-mode-map (kbd "C-c m") 'cmake-project-configure-project)))


;; Disable backup/autosave files
(setq make-backup-file nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)
(setq backup-directory-alist '((".*" . "~/.Trash")))



;; js-mode
(add-to-list 'load-path "/home/rhexo/.emacs.d/js3-mode")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-directory ((t (:foreground "color-75" :width normal))))
 '(eshell-ls-directory ((t (:inherit font-lock-function-name-face))))
 '(font-lock-builtin-face ((t (:foreground "color-142"))))
 '(font-lock-constant-face ((t (:foreground "color-100"))))
 '(font-lock-function-name-face ((t (:inherit font-lock-builtin-face))))
 '(font-lock-keyword-face ((t (:foreground "color-142"))))
 '(font-lock-preprocessor-face ((t (:foreground "color-60"))))
 '(font-lock-string-face ((t (:foreground "color-221"))))
 '(font-lock-type-face ((t (:foreground "color-221"))))
 '(helm-selection ((t (:background "color-237" :distant-foreground "black"))))
 '(helm-selection-line ((t (:inherit highlight :background "color-237" :distant-foreground "black"))))
 '(helm-visible-mark ((t (:background "color-235"))))
 '(link ((t (:foreground "color-68" :underline t))))
 '(minibuffer-prompt ((t (:foreground "color-172"))))
 '(org-agenda-structure ((t (:foreground "color-69"))))
 '(outline-1 ((t (:foreground "color-178"))))
 '(outline-2 ((t (:foreground "color-142"))))
 '(outline-3 ((t (:foreground "color-94"))))
 '(outline-4 ((t (:foreground "color-64"))))
 '(region ((t (:background "color-237")))))
