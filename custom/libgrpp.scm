(define-module (libgrpp)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system cmake)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gcc))

(define-public libgrpp ;; Optional for CP2K
  (package
    (name "libgrpp")
    (version "1.2.0")
    (source
      (origin
        (method url-fetch)
        (uri "https://github.com/aoleynichenko/libgrpp/archive/refs/heads/main.zip")
        (sha256 (base32 "0gg3qnwjs9pq5c4v5xwwj8jk9sxba5c7lhzxn6b510cmvkqmglb4"))))
    (native-inputs
     (list unzip))
    (inputs
     (list gfortran))
    (build-system cmake-build-system)
    (arguments
      `( 
        #:test-target "test"
        #:tests? #f ; Machine (environment) dependent, compares matrixes with hard-written elements computed 
                    ; on the author's machine, possibly with another version of the code (no obvious traceability).
        #:build-type "Release"
        #:phases
          (modify-phases %standard-phases  
            (add-after 'unpack 'fix-tests
              (lambda* (#:key outputs inputs #:allow-other-keys)
                (substitute* "CMakeLists.txt"
                 (("t KCs") "t KCs Cs K Tl_qz H2O ThO UO2")) ; Because tested executables aren't available for 6 out of 7 tests by default
                (substitute* "CMakeLists.txt"
                 (("WORKING_DIRECTORY ../test") "WORKING_DIRECTORY ../libgrpp-main/test")) ; Because we build by default in "../build" instead of "./build"
              ))
            (replace 'install
             (lambda* (#:key outputs inputs #:allow-other-keys)
                (let* ((out (assoc-ref outputs "out"))
                    (invokde "pwd")
                    (bindir (string-append out "/bin"))
                    (libdir (string-append out "/lib"))
                    (incdir (string-append out "/include")))
                    (install-file "libgrpp/liblibgrpp.a" libdir)
                    (for-each (lambda (f) (install-file f bindir)) ; Exectuables only for test ?
                             (find-files "." "\\.x$"))
                    (for-each (lambda (f) (install-file f incdir))
                             (find-files "../libgrpp-main/libgrpp" "\\.h$")) ; needed ?
            )))
            
          )
      ))
    (home-page "https://github.com/aoleynichenko/libgrpp")
    (synopsis "A library for the evaluation of molecular integrals of the generalized relativistic pseudopotential operator (GRPP) over Gaussian functions.")
    (description "Generalized relativistic pseudopotentials (GRPPs) of atomic cores imply the use of different potentials for atomic electronic shells with different principal quantum numbers. GRPPs give rise to accurate and reliable relativistic electronic structure models of atoms, molecules, clusters and solids. GRPPs readily incorporate the effects of Breit electron–electron interactions and one-loop quantum electrodynamics effects. GRPPs are one of the most precise relativistic Hamiltonians at the moment, allowing one to completely bypass any complicated four-component calculations.")
    (license license:gpl3+)))
libgrpp