(define-module (myvoro)
      #:use-module ((guix licenses) #:prefix license:)
      #:use-module (guix packages)
      #:use-module (guix download)
      #:use-module (guix build-system gnu)
      #:use-module (gnu packages algebra)
      #:use-module (gnu packages compression)
      #:use-module (gnu packages gcc)
      )


(define-public myvoro
  (package
  (name "myvoro")
  (version "0.4.6")
  (source (origin
            (method url-fetch)
	    (uri (string-append "https://math.lbl.gov/voro++/download/dir/voro++-" version ".tar.gz"))
            (sha256
             (base32
              "0zj3xbrqf8sm49yhypy23k3w9786r94kcwm8v803ikp23q3p0ygg"))))
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
                    (install-file "./src/voro++" bindir)))))
      #:tests? #f))
  (inputs
     `(("gcc" ,gcc)                    ; covers for libgcc-s1 ? And libc6 ? And libstdc++6 ?
       ("gzip" ,gzip)))                ; why is this mandatory ? -> Because we pull a .tar.gz ?
  (native-inputs
    `(("bc" ,bc)))
  (synopsis "Voro++, a 3D cell-based Voronoi library")
  (description "Voro++ is a software library for carrying out three-dimensional computations of the Voronoi tessellation. A distinguishing feature of the Voro++ library is that it carries out cell-based calculations, computing the Voronoi cell for each particle individually, rather than computing the Voronoi tessellation as a global network of vertices and edges. It is particularly well-suited for applications that rely on cell-based statistics, where features of Voronoi cells (eg. volume, centroid, number of faces) can be used to analyze a system of particles.")
  (home-page "http://math.lbl.gov/voro++/")
  (license license:gpl2+)))
  myvoro
