;; Начало инициализации
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list 'package-archives
	     '("melpa-stable" . "http://stable.melpa.org/packages/") t)
  (package-initialize))

;; My name and email
(setq user-full-name "%user-name%")
(setq user-mail-address "%user-mail%")

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
(setq show-paren-style 'expression) ;; Выделить цветом выражения между {}, [], ()

;; Electric-modes settings
(electric-pair-mode 1) ;; Автозакрытие {}, [], () с переводом курсора внутрь скобок
(electric-indent-mode -1) ;; Отключить индентацию (default in Emacs-24.4)

;; Delete selection
(delete-selection-mode t)

;; Disable GUI components
(tooltip-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)

;; Disable backup/autosave files
(setq make-backup-file nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)

;; Linum plugin
(require 'linum)
(line-number-mode t)
(global-linum-mode t)
(column-number-mode t)
;; (setq linum-format "  %d")

;; Fringe settings
(fringe-mode '(8 . 0)) ;; Ограничить текст только слева
(setq-default indicate-empty-lines t)  ;; Отсутствие строки выделить глифами рядом с полоской с номером строки
(setq-default indicate-buffer-boundaries 'left) ;; Индикация только слева

;; Display file size/time in mode line
(setq display-time-24hr-format t) ;; 24-часовой временной формат в mode-line
(display-time-mode t) ;; показывать часы в mode-line
(size-indication-mode t) ;; размер файла в процентах

;; Line wrapping
(setq word-wrap t) ;; переносить по словам
(global-visual-line-mode t)


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
 '(font-lock-function-name-face ((t (:foreground "color-69"))))
 '(minibuffer-prompt ((t (:foreground "yellow")))))
