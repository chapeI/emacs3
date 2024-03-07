
;; ~ file ~
;; ~ path ~
;; ~ modified ~
;; git
;; lsp
;; ~ emacsmode ~
;; ~ readonly ~
;; less noise on other buffers
;; macros
;; would be nice to have file a different color.

(defun modified-buffer ()
	(if (buffer-modified-p)
			" ✏️ " nil ))

(defun imnotevil ()
 (if (eq evil-state 'emacs)
		" emacs bindings "  ))

(defun ap-file-path ()
(abbreviate-file-name (buffer-file-name)))

(defun read-only-modeline ()
	(if buffer-read-only
			" 🔒 " " "))

(defun lsp-is-on ()
	(if lsp-mode
			"lsp "  "nah"))

(setq mode-line-format
			'(
				(:eval (modified-buffer))
				(:eval (read-only-modeline))
				; (:eval (imnotevil))
				(:eval (propertize (imnotevil) 'face 'match))
				; (:eval (propertize "dbg" 'face 'match))
				; " %b "
	  		(:eval (propertize (ap-file-path) 'face 'white))
				(:eval (when-let (vc vc-mode)
								 '(vc)))
				))

;; above is influenced from james cash YT

;; taken from prots dot files, he has two files.
(defface prot-modeline-indicator-blue-bg
  '((default :inherit (bold prot-modeline-indicator-button))
    (((class color) (min-colors 88) (background light))
     :background "#0000aa" :foreground "white")
    (((class color) (min-colors 88) (background dark))
     :background "#77aaff" :foreground "black")
    (t :background "blue" :foreground "black"))
  "Face for modeline indicators with a background."
  :group 'prot-modeline-faces)

(defvar-local prot-modeline-kbd-macro
    '(:eval
      (when (and (mode-line-window-selected-p) defining-kbd-macro)
        (propertize " KMacro " 'face 'prot-modeline-indicator-blue-bg)))
  "Mode line construct displaying `mode-line-defining-kbd-macro'.
Specific to the current window's mode line.")
(put 'prot-modeline-kbd-macro 'risky-local-variable t)

(defface prot-modeline-indicator-cyan-bg
  '((default :inherit (bold prot-modeline-indicator-button))
    (((class color) (min-colors 88) (background light))
     :background "#006080" :foreground "white")
    (((class color) (min-colors 88) (background dark))
     :background "#40c0e0" :foreground "black")
    (t :background "cyan" :foreground "black"))
  "Face for modeline indicators with a background."
  :group 'prot-modeline-faces)

(defvar-local prot-modeline-narrow
    '(:eval
      (when (and (mode-line-window-selected-p)
                 (buffer-narrowed-p)
                 (not (derived-mode-p 'Info-mode 'help-mode 'special-mode 'message-mode)))
        (propertize " Narrow " 'face 'prot-modeline-indicator-cyan-bg)))
  "Mode line construct to report the multilingual environment.")
(put 'prot-modeline-narrow 'risky-local-variable t)

(setq mode-line-format
			'(
				" START "
				 (:eval (when (buffer-modified-p) 
					 " why " " m🐸 odified "))
				 " END"
				 ))


(setq mode-line-format  ; when modelines complete, run setq-default instead of setq
							`(
								,(propertize " START  " 'face 'dired-broken-symlink )  "   "

								;; " HI WORLD "
								;; ,(propertize " hi world  " 'face 'match )
								;; ,(buffer-name)
								;; ,(format "yo %s :" (buffer-name)						)
								;; ,(propertize (buffer-name) 'face 'match )

								;; (:eval (propertize "test" 'face 'match ))
								;; (:eval (propertize (buffer-name) 'face 'match ))
								evil-mode

								;; prot-modeline-kbd-macro
								;; prot-modeline-narrow

								prot-modeline-evil
								
								; narrow (explicit)
								(:eval
								 (when (and (mode-line-window-selected-p)
														(buffer-narrowed-p)
														(not (derived-mode-p 'Info-mode 'help-mode 'special-mode 'message-mode)))
									 (propertize " Narrow " 'face 'match)))





								;; (:eval (when (mode-line-window-selected-p)
								;; 	"   ACTIVE WINDOW   "))

																				; variables from default modeline
								mode-line-modified
								mode-line-buffer-identification 
								,(vc-mode vc-mode)

								DBG-anoops-modeline-majormode  ; anoops variables, ensure to eval variable and risk for this to work

								"   "
								,(propertize " END " 'face 'dired-broken-symlink )

																				; might not be a bad idea to show original along w yours
                ;; (:propertize
                ;;  ("" mode-line-mule-info mode-line-client mode-line-modified mode-line-remote)
                ;;  display (min-width (5.0)))
                ;; mode-line-frame-identification
								;; mode-line-buffer-identification
								;; "   "
                ;; mode-line-position
								;; (vc-mode vc-mode)  ; not working 
								;; "  "
								;; mode-line-modes    ; minor modes, js use consult
                ;; mode-line-misc-info  ; not working 
								;; mode-line-end-spaces  ; not working 
								))

																				; notes

;; mode-line-format looks cleaner with variables
(defvar-local DBG-anoops-modeline-majormode
		'(:eval (format "BUFFER: %s" (propertize (buffer-name) 'face 'match))))
																				; acknowledge risky
(put ' DBG-anoops-modeline-majormode 'risky-local-variable t)

(defface anoop-face
	'((t :background "red" :foreground "green"))
"comment required, red and green"
	)



																				; non - prot stuff, how i wouldve run it if i didnt rewrite modeline
;; bug, would have to run this explicitly everytime emacs starts up, its doesnt run off the bat in the init file.
(diminish 'lsp-mode '(:propertize " CONNECTED" face '(:foreground "green" )))
