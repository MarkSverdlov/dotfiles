(add-to-list 'load-path "~/.emacs.d/openwith")
(require 'openwith)
(setq openwith-associations
    (list
     (list (openwith-make-extension-regexp
            '("pdf"))
           "zathura"
           '(file))
     (list (openwith-make-extension-regexp
            '("mail"))
           "thunderbird"
           '(file))
     ))
(openwith-mode 1)
(setq org-refile-use-outline-path 'file)
