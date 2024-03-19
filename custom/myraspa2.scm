(define-module (myraspa2)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system gnu)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages compression))

(define-public myraspa2
  (package
    (name "myraspa2")
    (version "2.0.48")
    (source
      (origin
        (method url-fetch)
        (uri (string-append
          "https://github.com/iRASPA/RASPA2/archive/refs/tags/v"
          version
          ".zip"))
        (sha256 (base32 "10qgimx8vaxsffwbdg13i6n37g5kxa2808wx28jvwl6f0vpzx4i5"))))
    (native-inputs
     (list automake autoconf-2.68 unzip))
    (inputs
     (list libtool))
    (build-system gnu-build-system)
    (arguments 
     `(#:phases 
        (modify-phases %standard-phases
          (add-after 'unpack 'autoconfiguration
            (lambda* (#:key outputs inputs native-inputs #:allow-other-keys)
              ; Invokes automake suite before actual build
              (mkdir-p "m4")
              (invoke "aclocal")
              (invoke "autoreconf" "-i")
              (invoke "automake" "--add-missing")
              (invoke "autoconf")
            )
          )
        )
       #:tests? #f))
    (home-page "https://iraspa.org/raspa/")
    (synopsis "RASPA is a software package for simulating adsorption and diffusion of molecules in flexible nanoporous materials.")
    (description "RASPA is a software package for simulating adsorption and diffusion of molecules in flexible nanoporous materials. The code implements the latest state-of-the-art algorithms for Molecular Dynamics and Monte Carlo in various ensembles including symplectic/measure-preserving integrators, Ewald summation, Configurational-Bias Monte Carlo, Continuous Fractional Component Monte Carlo, Reactive Monte Carlo, and Baker’s minimization. Applications of RASPA include computing coexistence properties, adsorption isotherms for single and multiple components, self- and collective diffusivities, reaction systems, and visualization.
")
    (license license:gpl3+)))
myraspa2