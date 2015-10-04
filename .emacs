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

;; Disable backup/autosave files
(setq make-backup-file nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)

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
(setq scroll-step 1) ;; вверз вниз по одной строке

;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)

;; Clipboard settings
(setq x-select-enable-clipboard t)

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

(add-hook 'c++-mode-hook 'my:space-format-hook)
(add-hook 'c-mode-hook 'my:space-format-hook)
(add-hook 'lisp-mode-hook 'my:space-format-hook)
(add-hook 'emacs-lisp-mode-hook 'my:space-format-hook)

(setq-default truncate-lines 1)

;; Display full pathname for files
(add-hook 'find-file-hooks
          '(lambda ()
             (setq mode-line-buffer-identification 'buffer-file-truename)))

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(require 'yasnippet)
(yas-global-mode 1)

;; Добавляем возможность auto-complete завершать инклюды
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))

(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

;; Bookmarks settings
(require 'bookmark)
(setq bookmark-save-flag t) ;; автоматически сохранять закладки в файл
(when (file-exists-p (concat user-emacs-directory "bookmarks"))
  (bookmark-load bookmark-default-file t)) ;; попытаться найти и открыть файл с закладками
(global-set-key (kbd "<f3>") 'bookmark-set) ;; создать закладку
(global-set-key (kbd "<f4>") 'bookmark-jump) ;; прыгнуть на закладку по F4
(global-set-key (kbd "<f5>") 'bookmark-bmenu-list) ;; открыть список закладок
(setq bookmark-default-file (concat user-emacs-directory "bookmarks")) ;; хранить закадки в файле bookmarks

;; installing from github repo
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


;;Настраиваем  cmake-project-mode

(add-to-list 'load-path "/home/rhexo/.emacs.d/emacs-cmake-project")
(require 'cmake-project)

(defun maybe-cmake-project-hook ()
  (if (file-exists-p "CMakeLists.txt") (cmake-project-mode)))

(add-hook 'c-mode-hook 'maybe-cmake-project-hook)
(add-hook 'c++-mode-hook 'maybe-cmake-project-hook)

;; Enable cmake mode
(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))

(autoload 'cmake-mode "/home/rhexo/.emacs.d/cmake-mode.el" t)


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
 '(helm-selection ((t (:background "color-237" :distant-foreground "black"))))
 '(helm-selection-line ((t (:inherit highlight :background "color-237" :distant-foreground "black"))))
 '(helm-visible-mark ((t (:background "color-235"))))
 '(minibuffer-prompt ((t (:foreground "yellow")))))
