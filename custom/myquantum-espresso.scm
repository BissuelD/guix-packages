(define-module (myquantum-espresso)
  #:use-module (guix)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages python)
  #:use-module (gnu packages perl)
  
  #:use-module (gnu packages wget)
  #:use-module (gnu packages version-control))

(define-public myquantum-espresso
  (package
    (name "myquantum-espresso")
    (version "7.3")
    (source
      (origin
        (method url-fetch)
        (uri "https://gitlab.com/QEF/q-e/-/archive/qe-7.3/q-e-qe-7.3.tar.gz")
        (sha256 (base32 "0b4p11zz5mfapb9gc3j3r5xii0pnp5mchbpqyinrcsaw67rs1hpd"))))
    (inputs
     (list
      fftw
      gfortran
      git
      lapack
      ; hdf5
      openblas
      openmpi
      perl
      python
      wget))
    (build-system gnu-build-system)
    (arguments 
      (list
        ;#:configure-flags #~(list "--enable-silent-rules")
        ;#:test-target "run-tests"
        #:tests? #f
        #:phases
        #~(modify-phases %standard-phases
          (add-before 'check 'mpi-setup #$%openmpi-setup)
           (add-before 'configure 'allow-git-externals
             (lambda* (#:key outputs inputs #:allow-other-keys)
              (setenv "NOPROXY" "localhost,github.com,gitlab.com")
              (invoke "cat" "../environment-variables")
             )
           )
          (replace 'build
            (lambda* (#:key outputs inputs #:allow-other-keys)
              (invoke "make" "all")
            )
          )  
        )
      )
    )
    (home-page "https://www.quantum-espresso.org/")
    (synopsis " Electronic-structure calculations and materials modeling at the nanoscale. ")
    (description " Quantum ESPRESSO  Is an integrated suite of Open-Source computer codes for electronic-structure calculations and materials modeling at the nanoscale. It is based on density-functional theory, plane waves, and pseudopotentials.")
    (license license:gpl2)))
myquantum-espresso