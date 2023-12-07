(define-module (myvesta)
    #:use-module ((guix licenses) #:prefix license:)
    #:use-module (guix download)
    #:use-module (guix packages)
    #:use-module (guix profiles)
    #:use-module (gnu packages base)
    #:use-module (gnu packages compression)
    #:use-module (gnu packages elf)
    #:use-module (gnu packages fontutils)
    #:use-module (gnu packages gcc)
    #:use-module (gnu packages gl)
    #:use-module (gnu packages glib)
    #:use-module (gnu packages gtk)
    #:use-module (gnu packages llvm)
    #:use-module (gnu packages xorg)
    #:use-module (nonguix build-system binary)
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
  (build-system binary-build-system)
  ; switch build system ? -- OK (nonguix binary-buld-system)
  ; include patchelf and/or patchelf-plan ? (included in ^)
  (arguments
   `(
    #:strip-binaries? #f 
    #:patchelf-plan 
     (let ((libs '("cairo"
                   ;"fontconfig"
                   "gcc"
                   "gdk-pixbuf"
                   "glib"
                   "glibc"
                   "glu"
                   "gtk+" 
                   "libomp"
                   "libx11"
                   "libxxf86vm"
                   "mesa"
                   "pango")))
     `(("libVESTA.so" ,libs)
       ("VESTA"       ,libs)
       ("VESTA-core"  ,libs)
       ("VESTA-gui"   ,libs)
       ("madel"       ,libs)))
    ;#:validate-runpath? #f
    #:install-plan '(
      ("." "bin")
    )))
  (native-inputs (list patchelf))
  (inputs
   (list  cairo
          ;fontconfig
    (list gcc "lib")
          gdk-pixbuf
          glib
          glibc
          glu
          gtk+
          libomp
          libx11
          libxxf86vm
          mesa
          pango)
  )
  (synopsis "VESTA - Visualization for Electronic and STructural Analysis.")
  (description "VESTA is a 3D visualization program for structural models, volumetric data such as electron/nuclear densities, and crystal morphologies.")
  (home-page "https://jp-minerals.org/vesta/en/")
  (license license:bsd-3)))
  myvesta