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

;;(global-set-key (kbd "M-x") 'ido-all-completions)

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

;; 21-12-2015
;;(global-set-key (kbd "RET") 'newline-and-indent)
;; /

(defun indent-buffer ()
  (interactive)
  (save-excursion
    (indent-region   (point-min) (point-max) nil)))
(global-set-key [f12] 'indent-buffer)
;;

;; Scrolling settings
(setq scroll-step 4) ;; вверз вниз по одной строке

;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)

;; End of file newlines
(setq require-final-newline t) ;; Добавить новую пустую строку в конце файла
(setq next-line-add-newlines nil) ;; Не добавлять новую строку при смещении курсора

;; Highlight search results
(setq search-highlight t)
(setq query-replace-highlight t)

;; Easy transition between buffer: M-arrow-keys
(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))

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

(setq-default truncate-lines 1)

;; .h as .hpp.open in c++ mdoe.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Display full pathname for files
(add-hook 'find-file-hooks
          '(lambda ()
             (setq mode-line-buffer-identification 'buffer-file-truename)))

;; Bookmarks settings
(require 'bookmark)
(setq bookmark-save-flag t) ;; автоматически сохранять закладки в файл
(when (file-exists-p (concat user-emacs-directory "bookmarks"))
  (bookmark-load bookmark-default-file t)) ;; попытаться найти и открыть файл с закладками
(global-set-key (kbd "<f7>") 'bookmark-set) ;; создать закладку
(global-set-key (kbd "<f8>") 'bookmark-jump) ;; прыгнуть на закладку по F4
(global-set-key (kbd "<f5>") 'bookmark-bmenu-list) ;; открыть список закладок
(setq bookmark-default-file (concat user-emacs-directory "bookmarks")) ;; хранить закадки в файле bookmarks

;; some buffer futures
(global-set-key (kbd "<f4>") 'previous-buffer) ;; display previous buffer at F4

;; install from github repo
;; git clone https://github/bbatsov/projectile.git
;;
;; projectile setup
(add-to-list 'load-path "~/.emacs.d/projectile")

(require 'projectile)
(projectile-global-mode)

;; (setq helm-projectile-fuzzy-match nil)
;; (setq projectile-regenerate-tags ')

(add-to-list 'load-path "~/.emacs.d/helm-projectile")
(require 'helm-projectile)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(setq projectile-switch-project-action 'helm-projectile)

(add-to-list 'load-path "~/.emacs.d/tags-smoothie")
(require 'tags-smoothie)

(require 'json)

;; activate elpy
(elpy-enable)

;; Fixing a key binding bug in elpy
(define-key yas-minor-mode-map (kbd "C-c k") 'yas-expand)
;; Fixing another key binfing bug in iedit mode
(define-key global-map (kbd "C-c o") 'iedit-mode)
;; C++ futures
;; redefinition of projectile regeneration tags procedure
(defun projectile-regenerate-tags ()
  "Regenerate the project's [e|g]tags. Override function"
  (interactive)
  (let* ((project-root (projectile-project-root))
         (tags-exclude (projectile-tags-exclude-patterns))
         (default-directory project-root)
         (tags-file (expand-file-name projectile-tags-file-name))
         (tags-includes (tags-smoothie-get-files-stream project-root))
         (command (format projectile-tags-command tags-file tags-includes tags-exclude))
         shell-output exit-code)
    (with-temp-buffer
      (setq exit-code
            (call-process-shell-command command nil (current-buffer))
            shell-output (projectile-trim-string
                          (buffer-substring (point-min) (point-max)))))
    (unless (zerop exit-code)
      (error shell-output))
    (visit-tags-table tags-file)))


(defun my-c++-mode-hook ()
  (setq projectile-tags-command "/usr/local/bin/exctags -Re -f \"%s\" --language-force=c++ --format=2 --c-kinds=+pxl-d --extra=+f %s %s")
;; sets search directories for system includes (see defaults in tags-smoothie.el)
  (setq tags-smoothie-search-path
      '("/usr/include/"                    ;; system/include support
        "/usr/local/include/"              ;; local/include support
        "/usr/include/c++/v1/"))           ;; c++ support
;; project directories that will be excluded from overview (see defaults in tags-smoothie.el)
  (setq tags-smoothie-cpp-dir-to-exclude '("/build" "/bin")))
;;  (setq projectile-regenerate-tags 'my-projectile-regenerate-tags)

;; python futures
(defun my-python-mode-hook ()
  (highlight-indentation-mode 0))

(add-hook 'python-mode-hook 'my-python-mode-hook)

(require 'helm-config)
(require 'helm-tags)

(global-set-key (kbd "M-x") 'helm-M-x)

;;Настраиваем  cmake-project-mode
(add-to-list 'load-path "~/.emacs.d/emacs-cmake-project")
(require 'cmake-project)

(defun maybe-cmake-project-hook ()
  (if (file-exists-p "CMakeLists.txt") (cmake-project-mode)))

(add-hook 'c-mode-hook 'maybe-cmake-project-hook)
(add-hook 'c++-mode-hook 'maybe-cmake-project-hook)

;; default build directory for cmake build
(setq cmake-project-default-build-dir-name "build/")

;; Enable cmake mode (syntax highlite for CMakeLists.txt)
(autoload 'cmake-mode "~/.emacs.d/cmake-mode.el" t)

(setq auto-mode-alist
      (append
       '(("CMakeLists\\.txt\\'" . cmake-mode))
       '(("\\.cmake\\'" . cmake-mode))
       auto-mode-alist))


(require 'compile)
(require 'cc-mode)
;; Binding compile futures
(add-hook 'c-mode-hook
          (lambda() (define-key c-mode-map (kbd "C-c C-c") 'compile)))
(add-hook 'c++-mode-hook
          (lambda() (define-key c++-mode-map (kbd "C-c C-c") 'compile)))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c++-mode-hook)

;; cmake-project
(add-hook 'c++-mode-hook
          (lambda() (define-key c++-mode-map (kbd "C-c m") 'cmake-project-configure-project)))


;; Disable backup/autosave files
(setq make-backup-file t)
(setq auto-save-default t)
(setq auto-save-list-file-name t)
(setq backup-directory-alist '((".*" . "~/.Trash")))

(global-set-key (kbd "M-C-w") 'kill-region)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil))))
 '(custom-variable-tag ((t (:foreground "color-243" :weight bold))))
 '(dired-directory ((t (:foreground "color-142" :weight normal))))
 '(ebrowse-root-class ((t (:foreground "color-68" :weight bold))))
 '(eshell-ls-directory ((t (:foreground "color-142" :weight normal))))
 '(eshell-prompt ((t (:foreground "color-142" :weight bold :height 0.6))))
 '(font-lock-builtin-face ((t (:foreground "color-142"))))
 '(font-lock-constant-face ((t (:foreground "color-100" :weight bold))))
 '(font-lock-function-name-face ((t (:inherit font-lock-builtin-face :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "color-142" :height 0.6))))
 '(font-lock-preprocessor-face ((t (:foreground "color-60"))))
 '(font-lock-string-face ((t (:foreground "color-178"))))
 '(font-lock-type-face ((t (:foreground "color-221" :weight bold))))
 '(helm-grep-file ((t (:foreground "brightyellow" :underline t))))
 '(helm-grep-match ((t (:foreground "color-142"))))
 '(helm-match ((t (:foreground "color-142" :width expanded))))
 '(helm-selection ((t (:background "color-237" :distant-foreground "black"))))
 '(helm-selection-line ((t (:inherit highlight :background "color-237" :distant-foreground "black"))))
 '(helm-visible-mark ((t (:background "color-235"))))
 '(link ((t (:foreground "color-68" :underline t))))
 '(minibuffer-prompt ((t (:foreground "color-222"))))
 '(org-agenda-structure ((t (:foreground "color-69"))))
 '(outline-1 ((t (:foreground "color-178"))))
 '(outline-2 ((t (:foreground "color-184"))))
 '(outline-3 ((t (:foreground "color-142"))))
 '(outline-4 ((t (:foreground "color-144"))))
 '(region ((t (:background "color-237")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(elpy-modules (quote (elpy-module-company elpy-module-eldoc elpy-module-flymake elpy-module-pyvenv elpy-module-highlight-indentation elpy-module-yasnippet elpy-module-sane-defaults))))
