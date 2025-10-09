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
(global-set-key (kbd "C-c c") 'calendar)
(setq calendar-latitude 32.1)
(setq calendar-longitude 34.8)
(setq calendar-location-name "Petah Tikva, Israel")
