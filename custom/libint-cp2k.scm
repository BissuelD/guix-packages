(define-module (libint-cp2k)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system cmake)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages python))

(define-public libint-cp2k
  (package
    (name "libint-cp2k")
    (version "2.6.0")
    (source
      (origin
        (method url-fetch)
        (uri (string-append "https://github.com/cp2k/libint-cp2k/releases/download/v"
                            version "/libint-v" version "-cp2k-lmax-7.tgz"))
        (sha256 (base32 "0d630xcg7kc6f6sr8n3pnyw0nc4fvxqz2jjxg25f7byvw5awrk9v"))))
    (inputs
     (list eigen boost gfortran python))
    (build-system cmake-build-system)
    (arguments 
      (list #:configure-flags 
            #~(list (string-append "-DCMAKE_INSTALL_PREFIX=" (assoc-ref %outputs "out"))
                    "-DENABLE_FORTRAN=ON")
                    ; "-DBUILD_SHARED_LIBS=ON") ; for CP2K static linking should be enough
            #:test-target "check"
            #:tests? #f ; One variable in tests (LIBINT2_MAX_AM_default1) is not declared (typo ?) -> see if it gets fixed
            #:build-type "Release"))
    (home-page "https://github.com/cp2k/libint-cp2k")
    (synopsis "Libint - a library for the evaluation of molecular integrals of many-body operators over Gaussian functions")
    (description "Libint - a library for the evaluation of molecular integrals of many-body operators over Gaussian functions")
    (license license:gpl3)))
libint-cp2k