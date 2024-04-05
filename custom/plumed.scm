(define-module (plumed)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages base)
  #:use-module (gnu packages compression)
  ; #:use-module (gnu packages elf)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages python)
  #:use-module (myvmd))

; *** PLUMED has been installed ***

; Install prefix : /gnu/store/xsy8p58vgn3fj8lk28jfx9jridz5i4j0-plumed-2.9.0
; Full name      : plumed

; Setup your environment
; - Ensure this is in your execution path         : /gnu/store/xsy8p58vgn3fj8lk28jfx9jridz5i4j0-plumed-2.9.0/bin
; - Ensure this is in your include path           : /gnu/store/xsy8p58vgn3fj8lk28jfx9jridz5i4j0-plumed-2.9.0/include
; - Ensure this is in your library path           : /gnu/store/xsy8p58vgn3fj8lk28jfx9jridz5i4j0-plumed-2.9.0/lib
; - Ensure this is in your PKG_CONFIG_PATH path   : /gnu/store/xsy8p58vgn3fj8lk28jfx9jridz5i4j0-plumed-2.9.0/lib/pkgconfig
; For runtime binding:
; - Set this environment variable                 : PLUMED_KERNEL=/gnu/store/xsy8p58vgn3fj8lk28jfx9jridz5i4j0-plumed-2.9.0/lib/libplumedKernel.so

; To create a tcl module that sets all the variables above, use this one as a starting point:
; /gnu/store/xsy8p58vgn3fj8lk28jfx9jridz5i4j0-plumed-2.9.0/lib/plumed/modulefile


; see (for patchelf) :
; https://gricad-gitlab.univ-grenoble-alpes.fr/bouttiep/gricad_guix_packages/-/blob/master/common/absuite.scm

(define-public plumed
  (package
    (name "plumed")
    (version "2.9.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/plumed/plumed2.git")
              (recursive? #f)
              (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256 (base32 "0ybhc0ggxy7kzv59hsh0khyl2bbnfa6r8ck2qidqiw3lzzsvkgy8"))))
    (native-inputs
     (list patch))
    (inputs
     (list
        fftw
        gfortran
        lapack 
        myvmd ; comes with tcl ; seems like I can't load it 
        openmpi
        openblas
        ; patch
        ; patchelf
        perl
        python-wrapper
        zlib
      ))
    (build-system gnu-build-system)
    (arguments 
        (list 
            #:configure-flags #~(list 
                                 (string-append "--prefix=" (assoc-ref %outputs "out"))
                                ;  (string-append "LDFLAGS=\"-L" (assoc-ref %build-inputs "myvmd") "lib/plugins/LINUXAMD64/molfile\"")
                                ;  (string-append "CPPFLAGS=\"-I" (assoc-ref %build-inputs "myvmd") "lib/plugins/LINUXAMD64/molfile\"")
                                                          ; " -I" (assoc-ref %build-inputs "myvmd") "lib/plugins/LINUXAMD64/molfile")
                                )
            #:test-target "check"
            #:tests? #f
            #:phases 
              #~(modify-phases %standard-phases 
                    (add-before 'check 'mpi-setup #$%openmpi-setup)
                    (add-after 'install 'add-to-runpath
                      (lambda* (#:key inputs #:allow-other-keys)
                        ; (setenv "PLUMED_KERNEL" (string-append (assoc-ref %outputs "out") "/lib/libplumedKernel.so"))
                        ; (setenv "LIBRARY_PATH" (string-append (assoc-ref %outputs "out") "/lib" ":" (getenv "LIBRARY_PATH")))
                        (invoke (which "tcl") (string-append (assoc-ref %outputs "out") "/lib/plumed/modulefile"))
                      )
                    )
                    ; (delete 'strip)
                )))
    (home-page "https://www.plumed.org/")
    (synopsis "The community-developed PLUgin for MolEcular Dynamics")
    (description "PLUMED is an open-source, community-developed library that provides a wide range of different methods, which include: enhanced-sampling algorithms, free-energy methods, tools to analyze the vast amounts of data produced by molecular dynamics (MD) simulations.
These techniques can be used in combination with a large toolbox of collective variables that describe complex processes in physics, chemistry, material science, and biology.")
    (license license:gpl3)))

;; This allows you to run guix shell -f guix-packager.scm.
;; Remove this line if you just want to define a package.
plumed