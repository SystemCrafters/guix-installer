;; Generate a bootable image (e.g. for USB sticks, etc.) with:
;; $ guix system image -t iso9660 installer.scm

(define-module (nongnu system install)
  #:use-module (gnu image)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu system)
  #:use-module (gnu system install)
  #:use-module (gnu system image)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages mtools)
  #:use-module (gnu packages package-management)
  #:use-module (nongnu packages linux)
  #:use-module (guix)
  #:use-module (guix channels)
  #:export (installation-os-nonfree))

(define my-channels
  (eval (read (open-input-file "./channels.scm")) (current-module)))

(define my-nonguix
  (guix-for-channels my-channels))

(current-guix-package my-nonguix)

(define %my-services
  (modify-services (operating-system-user-services installation-os)
    (guix-service-type config =>
                       (guix-configuration
                        (inherit config)
                        (guix my-nonguix)
                        (substitute-urls
                         (append
                          (list "https://substitutes.nonguix.org")
                          %default-substitute-urls))
                        (authorized-keys
                         (append (list
                                  (local-file "./signing-key.pub"))
                                 %default-authorized-guix-keys))))))

(define installation-os-nonfree
  (operating-system
    (inherit installation-os)
    (kernel linux)
    (firmware (list linux-firmware))

    ;; Add the 'net.ifnames' argument to prevent network interfaces
    ;; from having really long names.  This can cause an issue with
    ;; wpa_supplicant when you try to connect to a wifi network.
    (kernel-arguments '("quiet" "modprobe.blacklist=radeon" "net.ifnames=0"))

    (services
     (cons*
      ;; Include the channel file so that it can be used during installation
      (simple-service 'channel-file etc-service-type
                      (list `("channels.scm" ,(local-file "channels.scm"))))
      %my-services))

    ;; Add some extra packages useful for the installation process
    (packages
     (append (list git curl stow vim emacs-no-x-toolkit my-nonguix)
             (operating-system-packages installation-os)))))

installation-os-nonfree
;; (image
;;        (inherit efi-disk-image)
;;        (format 'iso9660)
;;        (size (* 3 1024 1024))
;;        (operating-system installation-os-nonfree))

;; Local Variables:
;; geiser-scheme-implementation: "guix repl"
;; End:
