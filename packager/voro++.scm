(define-module (voro++)
  #:use-module (guix)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages gcc))

(define-public voro++
  (package
    (name "voro++")
    (version "0.4.6")
    (synopsis "Voro++, a 3D cell-based Voronoi library")
    (description "Voro++ is a software library for carrying out three-dimensional computations of the Voronoi tessellation. A distinguishing feature of the Voro++ library is that it carries out cell-based calculations, computing the Voronoi cell for each particle individually, rather than computing the Voronoi tessellation as a global network of vertices and edges. It is particularly well-suited for applications that rely on cell-based statistics, where features of Voronoi cells (eg. volume, centroid, number of faces) can be used to analyze a system of particles.")
    (home-page "https://math.lbl.gov/voro++/")
    (source
      (origin
        (method url-fetch)
        (uri "https://math.lbl.gov/voro++/download/dir/voro++-0.4.6.tar.gz")
        (sha256 (base32 "0zj3xbrqf8sm49yhypy23k3w9786r94kcwm8v803ikp23q3p0ygg"))))
    (inputs
     (list gawk gzip gcc-13))
    (build-system gnu-build-system)
    (arguments 
      `(#:phases
         (modify-phases %standard-phases
	         (delete `configure)
	         (delete `install)
	        ;(replace `install
	        ; (invoke "make" "install"))
	   )
        #:tests? #f))
    (license license:gpl3+)))
;; This allows you to run guix shell -f example.scm.
;; Remove this line if you just want to define a package.
voro++
