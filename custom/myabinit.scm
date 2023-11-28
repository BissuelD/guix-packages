(define-module (myabinit)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system gnu)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
)

(define-public libxc
  (package
    (name "libxc")
    (version "5.1.5")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
         (url "https://gitlab.com/libxc/libxc.git")
         (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32
         "0cy3x2zn1bldc5i0rzislfbc8h4nqgds445jkfqjv0d1shvdy0zn"))))
    (build-system gnu-build-system)
    (native-inputs
     `(("automake" ,automake)
       ("autoconf" ,autoconf)
       ("bash" ,bash)
       ("gfortran" ,gfortran)
       ("libtool" ,libtool)
       ("perl" ,perl)
       ("pkg-config" ,pkg-config)))
    (arguments
     `(#:configure-flags (list "--enable-shared")))
    (home-page "")
    (synopsis "")
    (description "")
    (license license:mpl2.0)))

(define-public myabinit
  (package
  (name "myabinit")
  (version "9.10.1")
  (source (origin
            (method url-fetch)
	    (uri (string-append "https://github.com/abinit/abinit/archive/refs/tags/" version ".tar.gz"))
            (sha256
             (base32
              "16vmiwlq9l7qxxw7f36sc6pvrn1724jywd83pra71f73nyb4sr0b"))))
  (build-system gnu-build-system)
  (arguments
   `(#:phases
      (modify-phases %standard-phases
        (delete 'configure)
        (replace 'install
             (lambda* (#:key outputs inputs #:allow-other-keys)
                (let* ((out (assoc-ref outputs "out"))
                    (bindir (string-append out "/bin"))
                    (incdir (string-append out "/include"))
                    (libdir (string-append out "/lib")))
                    (for-each (lambda (f) (install-file f libdir))
                             (find-files "./src/" "\\.a"))
                    (for-each (lambda (f) (install-file f incdir))
                             (find-files "./src/" "\\.hh"))
                    (install-file "./src/abinit" bindir)))))
      #:tests? #f))
  (inputs
     `(("gcc" ,gcc)
       ("gzip" ,gzip)
       ("gfortran", gfortran)
       ("python", python)
       ("openmpi" ,openmpi)
       ("hdf5" ,hdf5)
       ("fftw" ,fftw)
       ("libxc", libxc)
       ("python-netcdf4",python-netcdf4) ; verify this
       ("openblas" ,openblas)
       ; Wannier90 ---> need to package first
       ))
  (native-inputs
    `(("bc" ,bc)))
  (synopsis "ABINIT is a software suite to calculate the optical, mechanical, vibrational, and other observable properties of materials.")
  (description "Starting from the quantum equations of density functional theory, you can build up to advanced applications with perturbation theories based on DFT, and many-body Green's functions (GW and DMFT). ABINIT can calculate molecules, nanostructures and solids with any chemical composition, and comes with several complete and robust tables of atomic potentials.")
  (home-page "https://www.abinit.org/")
  (license license:gpl2+)))
  myabinit
