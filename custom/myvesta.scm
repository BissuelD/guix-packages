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
    #:use-module (gnu packages java)
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
  (arguments
   `(
    #:strip-binaries? #f 
    #:patchelf-plan 
     (let ((libs '("at-spi2-core"
                   "cairo"
                   "fontconfig-minimal"
                   "gcc"
                   "gdk-pixbuf"
                   "glib"
                   "glibc"
                   "glu"
                   "gtk+" 
                   "libomp"
                   "libx11"
                   "libxtst"
                   "libxxf86vm"
                   "mesa"
                   "openjdk"
                   "pango")))
     `(("libVESTA.so" ,libs)
       ("VESTA"       ,libs)
       ("VESTA-core"  ,libs)
       ("VESTA-gui"   ,libs)
       ("madel"       ,libs)
       ("PowderPlot/libswt-atk-gtk-3346.so"   ,libs)
       ("PowderPlot/libswt-awt-gtk-3346.so"   ,libs)
       ("PowderPlot/libswt-pi-gtk-3346.so"    ,libs)
       ("STRUCTURE_TIDY/structure_tidy"       ,libs)
       ))
    #:validate-runpath? #f
    #:install-plan '(
      ("." "bin")
    )))
  (native-inputs (list patchelf))
  (inputs
   (list  at-spi2-core
          cairo
          fontconfig
    (list gcc "lib")
          gdk-pixbuf
          glib
          glibc
          glu
          gtk+
          gtk+-2
          libomp
          libx11
          libxtst
          libxxf86vm
          mesa
          openjdk
          pango)
  )
  (synopsis "VESTA - Visualization for Electronic and STructural Analysis.")
  (description "VESTA is a 3D visualization program for structural models, volumetric data such as electron/nuclear densities, and crystal morphologies.")
  (home-page "https://jp-minerals.org/vesta/en/")
  (license license:bsd-3)))
  myvesta