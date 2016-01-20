;; ������ �������������
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
(setq imenu-use-popup-menu nil) ;; ������� imenu � ����������

;; Display the name of the current buffer in the title bar
(setq frame-title-format "GNU Emacs: %b")

;; Show-paren-mode settings
(show-paren-mode t) ;; �������� ��������� ��������� ����� {}, [], ()
;;(setq show-paren-style 'expression) ;; �������� ������ ��������� ����� {}, [], ()

;; Electric-modes settings
(electric-pair-mode 1) ;; ������������ {}, [], () � ��������� ������� ������ ������
(electric-indent-mode -1) ;; ��������� ���������� (default in Emacs-24.4)

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
(setq-default indicate-empty-lines t)  ;; ���������� ������ �������� ������� ����� � �������� � ������� ������
(setq-default indicate-buffer-boundaries 'left) ;; ��������� ������ �����

;; Display file size/time in mode line
(setq display-time-24hr-format t) ;; 24-������� ��������� ������ � mode-line
(display-time-mode t) ;; ���������� ���� � mode-line
(size-indication-mode t) ;; ������ ����� � ���������

;; Line wrapping
(setq word-wrap t) ;; ���������� �� ������
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
(setq-default indent-tabs-mode nil)  ;; ��������� ����������� ������� ������� Tab-��
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
(setq scroll-step 4) ;; ����� ���� �� ����� ������

;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)

;; Clipboard settings
;; (setq x-select-enable-clipboard t)

;; End of file newlines
(setq require-final-newline t) ;; �������� ����� ������ ������ � ����� �����
(setq next-line-add-newlines nil) ;; �� ��������� ����� ������ ��� �������� �������

;; Highlight search results
(setq search-highlight t)
(setq query-replace-highlight t)

;; Easy transition between buffer: M-arrow-keys
(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))


;;21-12-2015
;; Delete trailing whitespaces, format buffer and untabify when save buffer
;; (defun format-current-buffer()
;;   (indent-region (point-min)(point-max)))
;; (defun untabify-current-buffer()
;;   (if (not indent-tabs-mode)
;;       (untabify (point-min)(point-max)))
;;   nil)

;; (defun my:space-format-hook()
;;   (add-to-list 'write-file-functions 'format-current-buffer)
;;   (add-to-list 'write-file-functions 'untabify-current-buffer)
;;   (add-to-list 'write-file-functions 'delete-trailing-whitespace))
;; /

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


;; 21-12-2015
;; (add-hook 'c++-mode-hook 'my:space-format-hook)
;; (add-hook 'c-mode-hook 'my:space-format-hook)
;; (add-hook 'lisp-mode-hook 'my:space-format-hook)
;; (add-hook 'emacs-lisp-mode-hook 'my:space-format-hook)
;; /

(setq-default truncate-lines 1)

;; .h as .hpp.open in c++ mdoe.
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Display full pathname for files
(add-hook 'find-file-hooks
          '(lambda ()
             (setq mode-line-buffer-identification 'buffer-file-truename)))

(require 'yasnippet)
(yas-global-mode 1)

;; setups company-mode
(add-to-list 'load-path "/home/rhexo/.emacs.d/company-mode")
(require 'company)

(add-hook 'after-init-hook 'global-company-mode)

;;(setq company-backends (delete 'company-semantic company-backends))
;;(setq company-backends (delete 'company-clang company-backends))

(add-hook 'c-mode-hook
          (lambda() (define-key c-mode-map (kbd "C-c TAB") 'company-complete)))
(add-hook 'c++-mode-hook
          (lambda() (define-key c++-mode-map (kbd "C-c TAB") 'company-complete)))

;; ;; by default include path
;; (setq company-clang-arguments '("-std=c++11"
;;                                 "-I./include"
;;                                 "-I/usr/include/c++/v1"
;;                                 "-I/usr/include/c++/4.2"
;;                                 "-I/usr/local/include"
;;                                 "-I/usr/local/include/boost"
;;                                 "-I/usr/local/include/mpl"
;;                                 "-I/usr/local/include/asio"
;;                                 ))

;; .dir-locals.el content
;; ((c++-mode . ((eval . (let ((clang-args '("-std=c++11"
;;                                           "-I/usr/include/c++/v1"
;;                                           "-I/usr/include/c++/4.2"
;;                                           "-I/usr/local/include"
;;                                           "-I/usr/local/include/boost"
;;                                           "-I/usr/local/include/mpl"
;;                                           "-I/usr/local/include/asio"
;;                                           "-I./include")))
;;                             (setq company-clang-arguments clang-args))))))



;; ;; 22-12-2015
;; (require 'irony)
;; ;; Setups irony-mode
;; (add-hook 'c++-mode-hook 'irony-mode)
;; (add-hook 'c-mode-hook 'irony-mode)
;; (add-hook 'objc-mode-hook 'irony-mode)

;; (defun my-irony-mode-hook ()
;;   (define-key irony-mode-map [remap completion-at-point]
;;     'irony-completion-at-point-async)
;;   (define-key irony-mode-map [remap complete-symbol]
;;     'irony-completion-at-point-async))
;; (add-hook 'irony-mode-hook 'my-irony-mode-hook)
;; (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; ;; Has a bug : variable void reference for irony--working-directory
;; ;; (add-to-list 'load-path "/home/rhexo/.emacs.d/company-irony-c-headers")
;; ;; (require 'company-irony-c-headers)

;; ;; setups company-irony
;; (eval-after-load 'company
;;   '(add-to-list 'company-backends 'company-irony))
;; ;; (eval-after-load 'company
;; ;;   '(add-to-list 'company-backends '(company-irony-c-headers company-irony)))

;; (add-hook 'c-mode-hook
;;           (lambda() (define-key c-mode-map (kbd "C-c TAB") 'irony-completion-at-point-async)))
;; (add-hook 'c++-mode-hook
;;           (lambda() (define-key c++-mode-map (kbd "C-c TAB") 'irony-completion-at-point-async)))

;; ;; add c++11 support for irony-mode (by default)
;; (setq irony-additional-clang-options '("-std=c++11"))


;; Bookmarks settings
(require 'bookmark)
(setq bookmark-save-flag t) ;; ������������� ��������� �������� � ����
(when (file-exists-p (concat user-emacs-directory "bookmarks"))
  (bookmark-load bookmark-default-file t)) ;; ���������� ����� � ������� ���� � ����������
(global-set-key (kbd "<f3>") 'bookmark-set) ;; ������� ��������
(global-set-key (kbd "<f4>") 'bookmark-jump) ;; �������� �� �������� �� F4
(global-set-key (kbd "<f5>") 'bookmark-bmenu-list) ;; ������� ������ ��������
(setq bookmark-default-file (concat user-emacs-directory "bookmarks")) ;; ������� ������� � ����� bookmarks

;; install from github repo
;; git clone https://github/bbatsov/projectile.git
;;
;; projectile setup
(add-to-list 'load-path "/home/rhexo/.emacs.d/projectile")

(require 'projectile)
(projectile-global-mode)

;; (setq helm-projectile-fuzzy-match nil)
;; (setq projectile-regenerate-tags ')



(require 'helm-projectile)
(setq projectile-completion-system 'helm)
(helm-projectile-on)

(setq projectile-switch-project-action 'helm-projectile)

(setq projectile-tags-command "/usr/local/bin/exctags -Re -f \"%s\" --language-force=c++ %s %s")

(add-to-list 'load-path "/home/rhexo/.emacs.d/tags-smoothie")
(require 'tags-smoothie)

;; sets search directories for system includes (see defaults in tags-smoothie.el)
(setq tags-smoothie-search-path
      '("/usr/include/"                    ;; system/include support
        "/usr/local/include/"              ;; local/include support
        "/usr/include/c++/v1/"))           ;; c++ support

;; project directories that will be excluded from overview (see defaults in tags-smoothie.el)
(setq tags-smoothie-cpp-dir-to-exclude '("/build" "/bin"))

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

;; stop caching
;; (setq projectile-enable-caching nil)

;;(load "setup-helm.el")
(require 'helm-config)
;; (require 'helm-gtags)

(global-set-key (kbd "M-x") 'helm-M-x)

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


;;�����������  cmake-project-mode

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


;; (require 'semantic)
;; (semantic-mode 1)
;; (global-semanticdb-minor-mode 1)
;; (global-semantic-idle-scheduler-mode 1)

;; ;; adds some includes
;; (semantic-add-system-include "/usr/local/include" 'c++-mode)
;; (semantic-add-system-include "/usr/local/include/boost" 'c++-mode)
;; (semantic-add-system-include "/usr/local/include/boost/mpl" 'c++-mode)
;; (semantic-add-system-include "/usr/local/include/boost/asio" 'c++-mode)
;; (semantic-add-system-include "/usr/include/c++/v1" 'c++-mode)
;; (semantic-add-system-include "/usr/include/c++/4.2" 'c++-mode)

;; ;; fast jump to header definition 
;; (global-set-key (kbd "C-c i g") 'semantic-ia-fast-jump)
;; (global-set-key (kbd "C-c i c") 'semantic-ia-describe-class)

;; Disable backup/autosave files
(setq make-backup-file nil)
(setq auto-save-default nil)
(setq auto-save-list-file-name nil)
(setq backup-directory-alist '((".*" . "~/.Trash")))

(global-set-key (kbd "M-C-w") 'kill-region)

;; js-mode
;;(add-to-list 'load-path "/home/rhexo/.emacs.d/js3-mode")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-backends
   (quote
    (company-bbdb company-nxml company-css company-eclim company-xcode company-ropemacs company-cmake company-capf
                  (company-dabbrev-code company-gtags company-etags company-keywords)
                  company-oddmuse company-files company-dabbrev))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-variable-tag ((t (:foreground "color-243" :weight bold))))
 '(dired-directory ((t (:foreground "color-142" :weight normal))))
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
 '(outline-2 ((t (:foreground "color-142"))))
 '(outline-3 ((t (:foreground "color-94"))))
 '(outline-4 ((t (:foreground "color-64"))))
 '(region ((t (:background "color-237")))))
