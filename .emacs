
(add-to-list 'load-path "~/.emacs.d")

;; git clone https://github.com/purcell/emacs.d.git
(require 'init)

(when (>= emacs-major-version 24)
  (require 'package)
  (package-initialize)
  (add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
  )

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'github)


;;--------------------
;; Indentation setup
;;-------------------

(setq-default indent-tabs-mode nil) ; never use tab characters for indentation
(setq tab-width 2 ; set tab-width
      c-default-style "stroustrup" ; indent style in CC mode
      js-indent-level 2 ; indentation level in JS mode
      css-indent-offset 2) ; indentation level in CSS mode


(require 'ido)
(ido-mode t)

(require-package 'yasnippet)
(yas-global-mode 1)

;; где лежат сниппеты
(setq yas-snippet-dirs
      '("~/.emacs.d/snippets" ))

(require-package 'autopair)
(autopair-global-mode)

;;; Web-mode
(require-package 'web-mode)

;; с какими файлами ассоциировать web-mode
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))

;; настройка отступов
(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)

;; сниппеты и автозакрытие парных скобок
(setq web-mode-extra-snippets '(("erb" . (("name" . ("beg" . "end"))))
                                ))
(setq web-mode-extra-auto-pairs '(("erb" . (("open" "close")))
                                  ))

;; подсвечивать текущий элемент
(setq web-mode-enable-current-element-highlight t)

;; JS

(require-package 'json-mode)
(require-package 'js2-mode)
(require-package 'ac-js2)
(require-package 'coffee-mode)

(require-package 'tern)
(require-package 'tern-auto-complete)

(add-hook 'js-mode-hook (lambda () (tern-mode t)))
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

