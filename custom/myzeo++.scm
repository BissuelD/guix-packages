(define-module (myzeo++)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system gnu)
  ; #:use-module (myvoro)
)

(define-public myzeo++
  (package
    (name "myzeo++")
    (version "0.3")
    (source
      (origin
        (method url-fetch)
        (uri (string-append 
          "http://www.zeoplusplus.org/zeo++-"
          version ".tar.gz"))
        (sha256 (base32 "1b7sm6mivdw7x2isd3wcv172ximpjx9cwvyqk5lfv78sianp7nx3"))))
    (build-system gnu-build-system)
    (arguments 
     `(#:phases 
        (modify-phases %standard-phases
          ; (add-after 'unpack 'clean-unnecessary
          ;   (lambda* (#:key inputs #:allow-other-keys)
          ;     (delete-file-recursively "./voro++")
          ;   )
          ; )
          ; (add-before 'build 'patch-voro
          ;   (lambda* (#:key inputs #:allow-other-keys)
          ;     (substitute* "Makefile"
          ;       (("-Ivoro../src")
          ;       (string-append "-I" (assoc-ref inputs "myvoro") "/include")))
          ;     (substitute* "Makefile"
          ;       (("-Lvoro../src")
          ;       (string-append "-L" (assoc-ref inputs "myvoro") "/lib")))
          ;     (invoke "cat" "Makefile")
          ;   )
          ; )
          (add-after 'unpack 'build-voro
            (lambda* (#:key outputs inputs native-inputs #:allow-other-keys)
              ; Builds voro++ before the actual build
              ; Question : I already have a voro++ package, but it is also shipped with this soft.
              ; Should I use the already existing guix voro++ package or use the one shipped here ?
              (chdir "voro++/src")
              (invoke "make")
              (chdir "../..")
            )
          )
          (delete 'configure)
          (replace 'install
            (lambda* (#:key outputs inputs native-inputs #:allow-other-keys)
              (for-each
                (lambda (f) (install-file f (string-append (assoc-ref outputs "out") "/bin")))
                (find-files "." (lambda (file stat) (executable-file? file)))
              )
            )          
          )
        )
       #:tests? #f))
    ; (inputs
    ;  `(("myvoro" ,myvoro)))
    (home-page "http://www.zeoplusplus.org/")
    (synopsis "Zeo++ is a open source software for performing high-throughput geometry-based analysis of porous materials and their voids.")
    (description "The main code provides capabilities to calculate the following: Pore diameters, Surface area and volume, Probe-occupiable volume, Per channel analysis, Pore Size Distribution (PSD), Hologram representations, Stochastic ray approaches, Distance grid calculations, Aid to Molecular Simulations, Structure analysis and File format conversion and visualization aids. The structure of the code makes it particularly well-suited to many problems in physics and materials science, where Voronoi cells can be a useful method of analyzing particle packings. ")
    (license license:bsd-3)))
myzeo++