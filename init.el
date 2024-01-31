(setq-default echo-keystrokes 0.1)
(setq visible-bell 1)
(load-theme 'whiteboard)
(tool-bar-mode -1)
(menu-bar-mode -1)
(winner-mode 1)

; prots preview-files packages
(setq dired-preview-delay 0.1)

;; restore sessions, be more like tmux
(setq desktop-path '("~/"))
(desktop-save-mode 1)

;; numbered lines
(global-display-line-numbers-mode t) (menu-bar--display-line-numbers-mode-visual)

;; global truncating lines
(set-default 'truncate-lines t)
(setq truncate-partial-width-windows nil)

;; packages (trying to stick to one line)
(use-package magit :config (setq magit-diff-refine-hunk (quote all)) (global-git-gutter-mode 1)) ; show git difference to a word level
(use-package vertico :config (vertico-mode 1) (vertico-reverse-mode 1))
(use-package marginalia :init (marginalia-mode))
(use-package consult)
(use-package popper :init (popper-mode) :bind ("C-`" . popper-toggle-latest))
(use-package auto-dim-other-buffers :init (auto-dim-other-buffers-mode))
(use-package evil :init (setq evil-want-keybinding nil) :config (evil-mode 1))
(use-package evil-collection :after evil :config (evil-collection-init))
(use-package evil-surround :config (global-evil-surround-mode 1))
(use-package which-key :config (which-key-mode 1))
(use-package embark :bind ("M-o" . embark-act)) ; mx + mo
(use-package embark-consult)
(use-package dired :ensure nil :custom ((dired-listing-switches "-agho --group-directories-first")))
(use-package org :config (setq org-hide-emphasis-markers t))
; (use-package emojify :hook (after-init . global-emojify-mode))
(use-package org-roam
  :custom
  (org-roam-directory "~/Dropbox/roam/")
  :config
  (setq org-roam-node-display-template
	(concat "${title:*} "		; show filetags on org-roam-find-node
		(propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

; autocomplete
(use-package corfu
  :after orderless
  :custom
  (corfu-quit-at-boundary nil)
  (corfu-quit-no-match t)
  (corfu-cycle t)
  (corfu-auto t)
  :init (global-corfu-mode))

;; global keybinds
(global-set-key (kbd "C-c /") 'consult-line)
(global-set-key (kbd "C-x C-s") 'save-buffer)
(global-set-key (kbd "C-c c") #'org-roam-dailies-capture-today)
(global-set-key (kbd "C-<tab>") 'switch-to-buffer)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key (kbd "C--") (lambda () (interactive) (evil-window-decrease-width 5)))
(define-key evil-normal-state-map (kbd "C-=") (lambda () (interactive) (evil-window-increase-width 6)))
(global-set-key (kbd "C-s") 'er/expand-region)

;; hooks
(add-hook 'org-mode-hook 'org-indent-mode)   ; can this be added in org config?

;; adding powershell theme to eshell
(use-package eshell :config (eshell-git-prompt-use-theme 'powerline))

(defun AP-up-directory-in-minibuffer (path)
  "Move up a directory in PATH without affecting the kill buffer."
  (interactive "p")
  (if (string-match-p "/." (minibuffer-contents))
      (let ((end (point)))
	    (re-search-backward "/.")
	    (forward-char)
	    (delete-region (point) end))))

(global-set-key (kbd "C-6") 'AP-up-directory-in-minibuffer)

;; for dired moving files to other open window
(setq dired-dwim-target t)

;; use-package (dont touch below this, new code goes above this line)
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents)) ; allows .emacs.d/ nuke
(unless (package-installed-p 'use-package) (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; keep init clean delete anything that autogenerates below
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(completion-ignored-extensions
	 '(".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".dfsl" ".pfsl" ".d64fsl" ".p64fsl" ".lx64fsl" ".lx32fsl" ".dx64fsl" ".dx32fsl" ".fx64fsl" ".fx32fsl" ".sx64fsl" ".sx32fsl" ".wx64fsl" ".wx32fsl" ".fasl" ".ufsl" ".fsl" ".dxl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo"))
 '(org-tags-exclude-from-inheritance nil)
 '(package-selected-packages
	 '(emmet-mode evil-surround flycheck git-gutter eshell-git-prompt web-mode lsp-mode anki-editor anki-connect org-drill expand-region vertico use-package popper org-roam orderless magit evil emojify embark-consult dashboard corfu auto-dim-other-buffers))
 '(tab-width 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
