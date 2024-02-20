(define-module (myvmd)
  #:use-module (guix)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system cmake)
  #:use-module (guix git-download)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (gnu packages tcl)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages fltk)
  #:use-module (gnu packages image)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages xorg))

(define-public myvmd
  (package
    (name "myvmd")
    (version "1.9.4a57")
    (source
      (origin
        (method url-fetch)
        (uri "https://www.ks.uiuc.edu/Research/vmd/vmd-1.9.4/files/alpha/vmd-1.9.4a57.src.tar.gz")
        (sha256 (base32 "0y86hrbr69qbhifrifj6ynq0rahanmpq1q38j3c3d4wnbl68s9yy"))))
    (inputs
     (list 
      tcl
      tk
      netcdf
      fltk
      libpng
      zlib
      python-numpy
      python-wrapper
      gcc-toolchain-12
      guile-opengl
      libxinerama
      libxi
      libx11
      mesa))
    (build-system gnu-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (add-after 'unpack 'compile-plugins
            (lambda* (#:key outputs inputs #:allow-other-keys)
              (chdir "../vmd-1.9.4a57")
              (invoke "mv" "../plugins" ".")
              (invoke "pwd")
              (chdir )
            )          
          )
          ;(delete 'configure)
          ;(replace 'install
          ;   (lambda* (#:key outputs inputs #:allow-other-keys)
          ;      (let* ((out (assoc-ref outputs "out"))
          ;          (bindir (string-append out "/bin"))  ; not necessary if we only need it as an external library ?
          ;          (incdir (string-append out "/include"))
          ;          (libdir (string-append out "/lib")))
          ;          (install-file "./src/voro++" bindir) ; not necessary if we only need it as an external library ?
          ;           (for-each (lambda (f) (install-file f incdir))
          ;                   (find-files "./src/" "\\.hh"))
          ;          (for-each (lambda (f) (install-file f libdir))
          ;                   (find-files "./src/" "\\.a")))))
        )
        #:tests? #f))
    (home-page "https://www.ks.uiuc.edu/Research/vmd/")
    (synopsis "VMD is a molecular visualization program for displaying, animating, and analyzing
               large biomolecular systems using 3-D graphics and built-in scripting.")
    (description "VMD is designed for modeling, visualization, and analysis of biological systems
                  such as proteins, nucleic acids, lipid bilayer assemblies, etc. It may be used
                  to view more general molecules, as VMD can read standard Protein Data Bank (PDB)
                  files and display the contained structure. VMD provides a wide variety of methods
                  for rendering and coloring a molecule: simple points and lines, CPK spheres and
                  cylinders, licorice bonds, backbone tubes and ribbons, cartoon drawings, and others.
                  VMD can be used to animate and analyze the trajectory of a molecular dynamics (MD)
                  simulation. In particular, VMD can act as a graphical front end for an external MD
                  program by displaying and animating a molecule undergoing simulation on a remote computer.")
    (license license:ncsa)))

;; This allows you to run guix shell -f example.scm.
;; Remove this line if you just want to define a package.
myvmd