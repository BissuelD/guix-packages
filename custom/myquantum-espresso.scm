(define-module (myquantum-espresso)
  #:use-module (guix)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
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
        (uri 
          (string-append
            "https://gitlab.com/QEF/q-e/-/archive/qe-" 
            version "/q-e-qe-" version ".tar.gz"))
        (sha256 (base32 "0b4p11zz5mfapb9gc3j3r5xii0pnp5mchbpqyinrcsaw67rs1hpd"))))
    (inputs
     (list
      device-xlib
      fftw
      gfortran
      git
      lapack
      libmbd
      openblas
      openmpi
      perl
      python
      wannier90
      wget))
    (build-system cmake-build-system)
    (arguments 
      (list
        #:configure-flags
          #~(list 
              (string-append "-DWANNIER90_ROOT=" (assoc-ref %build-inputs "wannier90"))
              (string-append "-DMBD_ROOT=" (assoc-ref %build-inputs "libmbd"))
              (string-append "-DDEVICEXLIB_ROOT=" (assoc-ref %build-inputs "device-xlib"))
            )
        #:tests? #f ; NEEDS TO DOWNLOAD EXAMPLES ONLINE
        #:phases
        #~(modify-phases %standard-phases
          (add-before 'check 'mpi-setup #$%openmpi-setup)
        )
      )
    )
    (home-page "https://www.quantum-espresso.org/")
    (synopsis " Electronic-structure calculations and materials modeling at the nanoscale. ")
    (description " Quantum ESPRESSO  Is an integrated suite of Open-Source computer codes for electronic-structure calculations and materials modeling at the nanoscale. It is based on density-functional theory, plane waves, and pseudopotentials.")
    (license license:gpl2)))
myquantum-espresso

(define-public device-xlib
  (package
    (name "device-xlib")
    (version "master") ; Sadly, the specific one needed for Quantum Espresso
    (source
      (origin
        (method url-fetch)
        (uri 
          (string-append
            "https://gitlab.com/max-centre/components/devicexlib/-/archive/master/devicexlib-"
            version ".tar.gz"))
        (sha256 (base32 "18cwkgzrf8mqiz3lzx662ds6l7ykxmhji4ci602sv08p3z4d82p0"))))
    (inputs
     (list openblas lapack gfortran python-wrapper))
    (build-system gnu-build-system)
    (arguments 
      (list
            #:tests? #f
            #:phases #~(modify-phases %standard-phases 
              (replace 'build
                (lambda* (#:key outputs inputs #:allow-other-keys)
                  (invoke "make" "-j16" "all")
                )
              )
              (replace 'install
                (lambda* (#:key outputs inputs #:allow-other-keys)
                  (install-file "src/libdevXlib.a" (string-append (assoc-ref outputs "out") "/lib"))
                  (for-each
                    (lambda (f) (install-file f (string-append (assoc-ref outputs "out") "/include")))
                    (find-files "include" "\\.h$")
                  )
                  (for-each
                    (lambda (f) (install-file f (string-append (assoc-ref outputs "out") "/include")))
                    (find-files "src" "\\.mod$")
                  )
                )
              ) 
            )))
    (home-page "https://gitlab.com/max-centre/components/devicexlib")
    (synopsis " deviceXlib, fortran library wrapping device-oriented routines and utilities")
    (description "deviceXlib is a library that wraps device-oriented routines and utilities, such as device data allocation, host-device data transfers.
deviceXlib supports CUDA language, together with OpenACC and OpenMP programming paradigms.
deviceXlib wraps a subset of functions from Nvidia cuBLAS, Intel oneMKL BLAS and AMD rocBLAS libraries.")
    (license license:gpl3+)))

(define-public wannier90
  (package
    (name "wannier90")
    (version "3.1.0")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/wannier-developers/wannier90.git")
              (commit (string-append "v" version))))
        (file-name (git-file-name name version))
        (sha256 (base32 "1wvvaybzdp58hk8ak3xk6z28198511nk1hqzb19q98ib34ipakg0"))))
    (inputs
     (list gcc gfortran lapack perl python-wrapper))
    (build-system gnu-build-system)
    (arguments
      (list 
        #:tests? #f
        #:phases #~(modify-phases %standard-phases
              (replace 'configure
                (lambda* (#:key outputs inputs #:allow-other-keys)
                  (setenv "DESTDIR" (assoc-ref outputs "out")) ; to define where executables
                  (setenv "PREFIX" "")                         ; and libraries will be installed
                  (invoke "cp" "config/make.inc.gfort" "make.inc")
                )
              )
              (replace 'build
                (lambda* (#:key outputs inputs #:allow-other-keys)
                  (invoke "make" "-j16" "default" "lib")
                )
              )
              (add-before 'install 'install-includes
                (lambda* (#:key outputs inputs #:allow-other-keys)
                  (for-each
                    (lambda (f) (install-file f (string-append (assoc-ref outputs "out") "/include")))
                    (find-files "src/objp" "\\.mod$")
                  )
                  (for-each
                    (lambda (f) (install-file f (string-append (assoc-ref outputs "out") "/include")))
                    (find-files "src/obj" "\\.mod$")
                  )
                )
              )
        )
      ))
    (home-page "https://wannier.org/")
    (synopsis "Wannier90 is an open-source code for generating maximally-localized Wannier functions")
    (description "Wannier90 is an open-source code for generating maximally-localized Wannier functions and using them to compute advanced electronic properties of materials with high efficiency and accuracy.
    Many electronic structure codes have an interface to Wannier90, and there are several post-processing codes that use the output of Wannier90 for further analysis and calculation. A registry of this Wannier software ecosystem can be found on Github.
    The development of Wannier90 is managed on the Wannier developers GitHub site where you will find details of on-going developments. Continuous integration of the code is provided by GitHub Actions.")
    (license license:gpl2)))

  (define-public libmbd
  (package
    (name "libmbd")
    (version "0.12.8")
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/libmbd/libmbd.git")
              (commit version)))
        (file-name (git-file-name name version))
        (sha256 (base32 "1j8hzfi0j2hn0zc5wrxxy1pcdwmwkmcbndxmsqaplr6snc21mmbj"))))
    (inputs
     (list gfortran openblas lapack openmpi python-wrapper))
    (build-system cmake-build-system)
    (arguments
      (list
        #:configure-flags 
          #~(list
            "-B build"
            (string-append "-DCMAKE_INSTALL_PREFIX=" (assoc-ref %outputs "out"))
          )
        #:tests? #t
        #:build-type "Release"
        #:phases #~(modify-phases %standard-phases
          (add-before 'check 'mpi-setup #$%openmpi-setup)
          (add-after 'unpack 'patch-version
            (lambda* (#:key outputs inputs #:allow-other-keys)
              (invoke "sh" "-c" (string-append "echo \"set(VERSION_TAG " "0.12.8" ")\" > cmake/libMBDVersionTag.cmake")) ; using ",version" fails => setting it by hand 
            )
          )
          (replace 'configure
            (lambda* (#:key inputs outputs configure-flags #:allow-other-keys)
              (apply invoke "cmake" configure-flags)
            )
          )
          (replace 'build
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (invoke "make" "-C" "build" "install")
            )
          )
          (replace 'check
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (invoke "ctest" "--test-dir" "./build")
            )
          )
          (delete 'install)
        )
      ))
    (home-page "https://github.com/libmbd/libmbd")
    (synopsis "libMBD implements the many-body dispersion (MBD) method in several programming languages and frameworks.")
    (description "The Fortran implementation is the reference, most advanced implementation, with support for analytical gradients and distributed parallelism, and additional functionality beyond the MBD method itself. It provides a low-level and a high-level Fortran API, as well as a C API. Furthermore, Python bindings to the C API are provided.
The Python/Numpy implementation is intended for prototyping, and as a high-level language reference.
The Python/Tensorflow implementation is an experiment that should enable rapid prototyping of machine learning applications with MBD.
The Python-based implementations as well as Python bindings to the libMBD C API are accessible from the Python package called pyMBD.
libMBD is included in FHI-aims, Quantum Espresso, DFTB+, and ESL Bundle.")
    (license license:mpl2.0)))