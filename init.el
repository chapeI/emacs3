
(load-theme 'leuven)
(setq-default echo-keystrokes 0.1)
(setq visible-bell 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(winner-mode 1)
(savehist-mode 1)   ; see recent mx commands
(global-display-line-numbers-mode t) (menu-bar--display-line-numbers-mode-visual) ;; numbered lines
(setq desktop-path '("~/")) (desktop-save-mode 1) ;; restore sessions, be more like tmux
(set-default 'truncate-lines t) (setq truncate-partial-width-windows nil) ;; global truncating lines
(setq dired-dwim-target t)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

(use-package magit :config (setq magit-diff-refine-hunk (quote all)) (global-git-gutter-mode 1)) ; show git difference to a word level
(use-package marginalia :init (marginalia-mode))
(use-package vertico
	:init
	(vertico-mode nil)
	(vertico-multiform-mode 1)

	;; mx in vertico changes to unobstrusive in the following code,
	;; toggle obstrusive <-> normal w m-V
	;; note: ANOOP manually changed vertico-multiform-map in vertico-multiform.el
	;; (defvar-keymap vertico-multiform-map
	;;   "M-V" #'vertico-multiform-vertical ;; anoop manually changed TO "M-v"
	;;   "M-U" #'vertico-multiform-unobtrusive)

	:custom
	;; Configure the display per command. ;; Use a buffer with indices for imenu ;; and a flat (Ido-like) menu for M-x.
	(vertico-multiform-commands
	 '((consult-imenu buffer indexed)
	   (execute-extended-command unobtrusive)
	   (switch-to-buffer unobtrusive)
	   (consult-line buffer)
	   ))

	;; Configure the display per completion category. ;; Use the grid display for files and a buffer ;; for the consult-grep commands.
	(vertico-multiform-categories
	 '((file grid)
	   (consult-grep buffer))))

(use-package popper :init (popper-mode) (popper-echo-mode) :bind ("C-`" . popper-toggle-latest)
	; popper-display-popup-at-bottom was changed
	:config ; example of .. i forget, how popper plays nicely with display-alist?
	(setq popper-reference-buffers
				'(
					"^\\*ielm\\*"
					)
	))

;; corfu means autocomplete
(use-package corfu :init (global-corfu-mode) :custom (corfu-auto t))
(defun corfu-move-to-minibuffer ()
  (interactive)
  (pcase completion-in-region--data
    (`(,beg ,end ,table ,pred ,extras)
     (let ((completion-extra-properties extras)
           completion-cycle-threshold completion-cycling)
       (consult-completion-in-region beg end table pred)))))
(keymap-set corfu-map "<tab>" #'corfu-move-to-minibuffer)
(add-to-list 'corfu-continue-commands #'corfu-move-to-minibuffer)

(use-package auto-dim-other-buffers :init (auto-dim-other-buffers-mode))  ;; JAKE B :config (evil-set-initial-state 'pdf-view-mode 'motion)
(use-package evil
	:init
	(setq evil-want-keybinding nil)
	:config
	(evil-mode 1)
	(global-set-key (kbd "C--") (lambda () (interactive) (evil-window-decrease-width 5)))
	(define-key evil-normal-state-map (kbd "C-=") (lambda () (interactive) (evil-window-increase-width 6))))
(use-package evil-collection :after evil :config (evil-collection-init))
(use-package evil-surround :config (global-evil-surround-mode 1))
(use-package which-key :init (which-key-mode))
(use-package embark :bind ("M-o" . embark-act)) ; mxmo
(use-package embark-consult)
(use-package dired :ensure nil :custom ((dired-listing-switches "-agho --group-directories-first")))

(use-package consult
	:bind
	("C-s" . consult-line)
	("C-<tab>" . consult-buffer-other-window)
	:config
	(recentf-mode 1))

(use-package org
	:config
	(setq org-hide-emphasis-markers t)
	(add-hook 'org-mode-hook 'org-indent-mode)
	(setq org-agenda-files '("~/Dropbox/roam/daily")))

(use-package org-roam
  :custom
  (org-roam-directory "~/Dropbox/roam/")
  :config
  (setq org-roam-node-display-template
				(concat "${title:*} "		; show filetags on org-roam-find-node
								(propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
	:bind
	("C-c c" . org-roam-dailies-capture-today))
																				; (use-package emojify :hook (after-init . global-emojify-mode))
(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package eshell :config (eshell-git-prompt-use-theme 'powerline))
(use-package dired-preview :custom (dired-preview-delay 0.1))
(use-package mode-line-bell :config (mode-line-bell-mode 1))
(use-package projectile
  :init
  (projectile-mode +1)
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map)))

;; AP ELISP
(defun ap/switch-buffers-from-mx-if-mx-was-accidently-clicked ()
  "c-tab in m-x, runs <switch-to-buffer> instead of <file-cache-minibuffer-complete>"
  (interactive)
  (insert "switch to buffer")
	(run-with-timer 0.1 nil 'vertico-exit))
(defun my-mx-hook ()
  (local-set-key (kbd "<C-tab>") 'ap/switch-buffers-from-mx-if-mx-was-accidently-clicked))
(add-hook 'minibuffer-setup-hook 'my-mx-hook)

;; use-package (DONT TOUCH BELOW THIS, ANY NEW CODE GOES ABOVE THIS)
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
