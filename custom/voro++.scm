(define-module (custom myvoro++)
      #:use-module ((guix licenses) #:prefix license:)
      #:use-module (guix packages)
      #:use-module (guix download)
;;    #:use-module (guix utils)
;;    #:use-module (guix build utils)
;;    #:use-module (guix build-system cmake)
      #:use-module (guix build-system gnu)
;;    #:use-module (gnu packages)
;;    #:use-module (gnu packages base) ;; new one
;;    #:use-module (gnu packages algebra)
;;    #:use-module (gnu packages image-processing)
;;    #:use-module (gnu packages image)
;;    #:use-module (gnu packages graphics)
;;    #:use-module (gnu packages maths)
;;    #:use-module (gnu packages mpi)
;;    #:use-module (gnu packages cmake) ;; new one
;;    #:use-module (gnu packages python)
;;    #:use-module (gnu packages python-xyz)
;;    #:use-module (gnu packages compression)
;;    #:use-module (gnu packages commencement)
      #:use-module (gnu packages gcc)
;;    #:use-module (gnu packages vim) ;; new one
;;    #:use-module (gnu packages pkg-config)
;;    #:use-module (gnu packages video)
;;    #:use-module (gnu packages llvm)
;;    #:use-module (gnu packages multiprecision)
      )


(define-public myvoro++
  (package
  (name "myvoro++")
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
        ;;(add-after 'unpack 'post-unpack
          ;;(lambda* (#:key outputs inputs #:allow-other-keys)))
        (replace 'configure
          (lambda* (#:key inputs outputs #:allow-other-keys)
            (let ((out (assoc-ref outputs "out")))
              (apply invoke "make")))))
      #:tests? #f))
  (inputs
     (("gcc" ,gcc)                    ; covers for libgcc-s1 ? And libc6 ? And libstdc++6 ?
    ;;("pkg-config" ,pkg-config)      ; why is it mandatory ?
      ("gzip" ,gzip)))                ; why is this mandatory ? -> Because we pull a .tar.gz ?
  (native-inputs
    `(("bc" ,bc)))
  (synopsis "Voro++, a 3D cell-based Voronoi library")
  (description "Voro++ is a software library for carrying out three-dimensional computations of the Voronoi tessellation. A distinguishing feature of the Voro++ library is that it carries out cell-based calculations, computing the Voronoi cell for each particle individually, rather than computing the Voronoi tessellation as a global network of vertices and edges. It is particularly well-suited for applications that rely on cell-based statistics, where features of Voronoi cells (eg. volume, centroid, number of faces) can be used to analyze a system of particles.")
  (home-page "http://math.lbl.gov/voro++/")
  (license license:gpl2+)))
  myvoro++
