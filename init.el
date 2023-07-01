;; use-package (dont touch)
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents)) ; allows .emacs.d/ nuke
(unless (package-installed-p 'use-package) (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; visuals
(setq-default echo-keystrokes 0.1)
(global-display-line-numbers-mode t) (menu-bar--display-line-numbers-mode-visual)
(setq visible-bell 1)

;; packages (stick to one line)
(use-package magit :config (setq magit-diff-refine-hunk (quote all)))
(use-package vertico :config (vertico-mode 1))
(use-package consult)
(use-package popper :bind ("C-`" . popper-toggle-latest))
(use-package auto-dim-other-buffers :init (auto-dim-other-buffers-mode))
(use-package evil :config (evil-mode 1))
(use-package dashboard :config (dashboard-setup-startup-hook))
(use-package embark :bind ("M-o" . embark-act)) ; mx + mo
(use-package embark-consult)
(use-package org-roam :config (setq org-roam-directory "~/Dropbox/roam2/") (org-roam-db-autosync-mode))

;; showing file tags when 'finding' node
(setq org-roam-node-display-template (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))
(use-package corfu			; autocomplete
  :after orderless
  :custom
  (corfu-quit-at-boundary nil)
  (corfu-quit-no-match t)
  (corfu-cycle t)
  (corfu-auto t)
  :init (global-corfu-mode))

;; global keybinds
(global-set-key (kbd "C-c /") 'consult-line)
(global-set-key (kbd "C-s") 'save-buffer)
(global-set-key (kbd "C-c c") #'org-roam-dailies-capture-today)
(global-set-key (kbd "C-c r") 'recentf-open-files)

;; hooks
(add-hook 'org-mode-hook 'org-indent-mode)

;; keep init clean
