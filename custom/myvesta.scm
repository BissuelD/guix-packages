(define-module (myvesta)
    #:use-module ((guix licenses) #:prefix license:)
    #:use-module (guix build-system copy)
    #:use-module (guix download)
    #:use-module (guix packages)
    #:use-module (guix profiles)
    #:use-module (gnu packages compression)
    #:use-module (gnu packages elf)
    #:use-module (gnu packages gcc)
    #:use-module (gnu packages gl)
    #:use-module (gnu packages gtk)
    #:use-module (gnu packages llvm)
)

(define-public myvesta
  (package
  (name "myvesta")
  (version "3.5.8")
  (source (origin
    (method url-fetch)
	  (uri (string-append 
            "https://jp-minerals.org/vesta/archives/"
            version "/VESTA-gtk3.tar.bz2"))
          (sha256
          (base32
            "1y4dhqhk0jy7kbkkx2c6lsrm5lirn796mq67r5j1s7xkq8jz1gkq"))))
  (build-system copy-build-system)
  ; switch build system ?
  ; include patchelf and/or patchelf-plan ?
  (arguments
   `(#:phases 
    (modify-phases %standard-phases
      (add-after `unpack 'check-setup
        (lambda* (#:key inputs #:allow-other-keys)
          (setenv "DT_RUNPATH" (string-append (assoc-ref inputs "gcc") "/lib")))) ; this doesn't seem to work ? VARIABLE ??
      ;(add-after 'unpack 'chmod
	    ;  (lambda* (#:key #:allow-other-keys)
	    ;    (chmod "VESTA" #o755)))
      ;(delete `validate-runpath)
    )
    #:substitutable? #f
    #:install-plan '(
      ("." "bin")
    )))
  (inputs
    `(
      ("gcc" ,gcc)
      ("gtk+" ,gtk+)
      ;("libomp" ,libomp)
      ("mesa-utils" ,mesa-utils)
    ))
  (search-paths
   (list (search-path-specification
  ;        (variable "LD_LIBRARY_PATH")
  ;        (files (list "lib" "lib/catalyst" "lib/mesa" "lib/mpi")))
  ;        (search-path-specification
          (variable "LD_LIBRARY_PATH")
          (files (list "bin" (assoc-ref inputs "gcc"))))))
  (synopsis "VESTA - Visualization for Electronic and STructural Analysis.")
  (description "VESTA is a 3D visualization program for structural models, volumetric data such as electron/nuclear densities, and crystal morphologies.")
  (home-page "https://jp-minerals.org/vesta/en/")
  (license license:bsd-3)))
  myvesta