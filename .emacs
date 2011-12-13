;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; path
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defconst my-elisp-directory "~/.emacs.d/elisp" "The directory for my elisp file.")

(dolist (dir (let ((dir (expand-file-name my-elisp-directory)))
               (list dir (format "%s%d" dir emacs-major-version))))
  (when (and (stringp dir) (file-directory-p dir))
    (let ((default-directory dir))
      (add-to-list 'load-path default-directory)
      (normal-top-level-add-subdirs-to-load-path))))


;; install-elisp のコマンドを使える様にする。
(require 'install-elisp)
;; Elisp ファイルの場所指定。
(setq install-elisp-repository-directory "~/.emacs.d/elisp/")

;; auto-complete
(require 'auto-complete)
(global-auto-complete-mode t)

;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/elisp/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; window
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Localeに合わせた環境の設定
(set-locale-environment nil)

;; scroll-bar right
(set-scroll-bar-mode 'right)

;; delete menubar
(menu-bar-mode nil)
;; delete toolbar
(tool-bar-mode nil)

;; color
(if window-system (progn

  ;; 文字の色の設定
  (add-to-list 'default-frame-alist '(foreground-color . "white"))
  ;; 背景色の設定
  (add-to-list 'default-frame-alist '(background-color . "black"))
  ;; カーソルの色の設定
  (add-to-list 'default-frame-alist '(cursor-color . "white"))
  ;; マウスポインタの色の設定
  (add-to-list 'default-frame-alist '(mouse-color . "white"))
  ;; モードラインの文字の色の設定
  (set-face-foreground 'modeline "black")
  ;; モードラインの背景色の設定
  (set-face-background 'modeline "white")
  ;; 選択中のリージョンの色の設定
  (set-face-background 'region "Blue")
  ;; モードライン（アクティブでないバッファ）の文字色の設定
  (set-face-foreground 'mode-line-inactive "black")
  ;; モードライン（アクティブでないバッファ）の背景色の設定
  (set-face-background 'mode-line-inactive "white")

))

;; font
(set-default-font "Inconsolata-11")
(set-face-font 'variable-pitch "Inconsolata-11")
(set-fontset-font (frame-parameter nil 'font)
                  'japanese-jisx0208
                  '("Takaoゴシック" . "unicode-bmp")
)

;; elscreen
(load "elscreen" "ElScreen" t)

;; anything
(require 'anything-startup)

;; 対応する括弧を光らせる。
(show-paren-mode 1)

;;; 画像ファイルを表示
(auto-image-file-mode t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; key bind
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; delete
(define-key global-map (kbd "C-h") 'delete-backward-char)

;; undo
(define-key global-map (kbd "C-/") 'undo)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; php-mode
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(require 'php-mode)

(defun php-mode-hook-func ()
  (c-set-style "gnu")
  (setq tab-width 8)
  (setq indent-tabs-mode nil)
  (setq show-trailing-whitespace t)
  (setq c-basic-offset 2)
  (c-set-offset 'arglist-intro '+)
  (c-set-offset 'arglist-close 0)
  (c-set-offset 'statement-cont 'c-lineup-math)
  (flymake-mode 1)
  (langrich-mode 1))

(add-hook 'php-mode-hook 'php-mode-hook-func)

(add-to-list 'auto-mode-alist '("\\.ctp\\'" . php-mode))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;
;;; others
;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; scratch-logを残す
(require 'scratch-log)

;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)
;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)
