(define-module (myfreefem)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages flex)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages base)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages graphics)
  #:use-module (gnu packages image-processing)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages perl))

(define-public myfreefem
  (package
    (name "myfreefem")
    (version "4.14")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/FreeFem/FreeFem-sources.git")
              (recursive? #f)
              (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256 (base32 "0q1817slryrh8cvqhaj9gf6779wbah398a5ybrqgm4vlxx3zhj1j"))))
    (native-inputs
     (list 
        automake
        autoconf
        m4
        unzip))
    (inputs
     `(("bison" ,bison)
       ("petsc-openmpi" ,petsc-openmpi)
       ("flex" ,flex)
       ("gfortran" ,gfortran)
       ("patch" ,patch)
       ("freeglut" ,freeglut)
       ("fftw" ,fftw)
       ; ("lapack" ,lapack) ; can be commented ?
       ("openblas" ,openblas)
       ("openmpi" ,openmpi)
       ("libtool" ,libtool)
       ; ("gsl" ,gsl) ; can be commented ?
       ; ("mumps" ,mumps) ; can be commented ?
       ("metis" ,metis) 
       ("perl" ,perl)
       ("hdf5" ,hdf5)
       ("hdf5-parallel-openmpi" ,hdf5-parallel-openmpi)
       ("scalapack" ,scalapack)
       ("suitesparse" ,suitesparse)
       ("suitesparse-umfpack" ,suitesparse-umfpack)
       ("slepc-openmpi" ,slepc-openmpi)
       ("zlib" ,zlib)
       ; ("vtk" ,vtk) ; can be commented ?
       ("pt-scotch" ,pt-scotch)
       ("parmetis" ,pt-scotch "metis")
       ("superlu" ,superlu)
      ))
    (build-system gnu-build-system)
    (arguments 
      (list 
        #:configure-flags 
          #~(list "-enable-optim"
                  (string-append "--prefix="
                                 (assoc-ref %outputs "out"))
                  (string-append "--with-petsc=" 
                                 (assoc-ref %build-inputs "petsc-openmpi")
                                 "/lib")
                  (string-append "--with-slepc-include=-I" 
                                 (assoc-ref %build-inputs "slepc-openmpi")
                                 "/include")
                  (string-append "--with-slepc-ldflags=-L" 
                                 (assoc-ref %build-inputs "slepc-openmpi")
                                 "/lib")
                  (string-append "--with-scotch-include=-I" 
                                 (assoc-ref %build-inputs "parmetis")
                                 "/include")
                  (string-append "--with-scotch-ldflags=-L" 
                                 (assoc-ref %build-inputs "parmetis")
                                 "/lib")
                  (string-append "--with-superlu-include=-I" 
                                 (assoc-ref %build-inputs "superlu")
                                 "/include")
                  (string-append "--with-superlu-ldflags=-L" 
                                 (assoc-ref %build-inputs "superlu")
                                 "/lib")
            )
        #:test-target "check"
        #:tests? #f ; https://github.com/FreeFem/FreeFem-sources/issues/298
                    ; As far as I can tell, testvtk.edp is the only one failing.
        #:phases 
          #~(modify-phases %standard-phases 
              (add-before 'check 'mpi-setup #$%openmpi-setup)
              (add-before `configure `autoconfig
                (lambda* (#:key inputs #:allow-other-keys)
                  (invoke "autoreconf" "-i")
                )
              )
            )))
    (home-page "https://freefem.org/")
    (synopsis " FreeFEM is a popular 2D and 3D partial differential equations (PDE) solver used by thousands of researchers across the world.")
    (description " It allows you to easily implement your own physics modules using the provided FreeFEM language. FreeFEM offers a large list of finite elements, like the Lagrange, Taylor-Hood, etc., usable in the continuous and discontinuous Galerkin method framework. ")
    (license license:gpl3)))
myfreefem