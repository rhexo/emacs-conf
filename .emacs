;; ������ �������������
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
(global-set-key (kbd "RET") 'newline-and-indent)

;; Scrolling settings
(setq scroll-step 1) ;; ����� ���� �� ����� ������

;; Short messages
(defalias 'yes-or-no-p 'y-or-n-p)

;; Clipboard settings
(setq x-select-enable-clipboard t)

;; End of file newlines
(setq require-final-newline t) ;; �������� ����� ������ ������ � ����� �����
(setq next-line-add-newlines nil) ;; �� ��������� ����� ������ ��� �������� �������

;; Highlight search results
(setq search-highlight t)
(setq query-replace-highlight t)

;; Easy transition between buffer: M-arrow-keys
(if (equal nil (equal major-mode 'org-mode))
    (windmove-default-keybindings 'meta))


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
