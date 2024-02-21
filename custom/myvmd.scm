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
  #:use-module (gnu packages bash)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages shells)
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
        (uri (string-append "https://www.ks.uiuc.edu/Research/vmd/vmd-1.9.4/files/alpha/vmd-" version ".src.tar.gz"))
        (sha256 (base32 "0y86hrbr69qbhifrifj6ynq0rahanmpq1q38j3c3d4wnbl68s9yy"))))
    (inputs
     (list 
      tcl
      tk
      netcdf
      fltk
      libpng
      zlib
      python
      python-numpy
      python-wrapper
      perl
      ruby
      tcsh
      bash-minimal
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
          (add-after 'unpack 'post-unpack
            (lambda* (#:key outputs inputs #:allow-other-keys)
              ; VMD works with environment variables, setting them
              (setenv "VMDINSTALLNAME" "vmd")
              (setenv "VMDINSTALLBINDIR" (string-append (assoc-ref outputs "out") "/bin"))
              (setenv "VMDINSTALLLIBRARYDIR" (string-append (assoc-ref outputs "out") "/lib"))
              (setenv "PLUGINDIR" (string-append (assoc-ref outputs "out") "/lib/plugins"))
              (chdir "../vmd-1.9.4a57")
              (invoke "mv" "../plugins" ".")    
              ; Default configure options are of little interest to us
              (substitute* "configure.options"
               (("LINUXAMD64 OPENGL OPENGLPBUFFER FLTK TK ACTC CUDA CXX11 IMD LIBSBALL XINERAMA XINPUT LIBOPTIX LIBOSPRAY LIBTACHYON LIBPNG ZLIB VRPN NETCDF COLVARS TCL PYTHON PTHREADS NUMPY SILENT ICC")
                 "LINUXAMD64 GCC OPENGL OPENGLPBUFFER FLTK TK COLVARS IMD SILENT XINPUT TCL PTHREADS LIBPNG ZLIB NETCDF PYTHON NUMPY XINERAMA"))
            )          
          )
          (add-after 'patch-source-shebangs 'compile-plugins
            (lambda* (#:key outputs inputs #:allow-other-keys)
              (for-each (lambda (f) 
                (substitute* f (("ltcl8.5") "ltcl8.6")))
                  `("./configure" "./plugins/cionize/Makefile.specialbuilds" "./plugins/Make-arch" "./plugins/Make-arch.debug" "./src/Makefile"))
               (for-each (lambda (f) 
                (substitute* f (("ltk8.5") "ltk8.6")))
                  `("configure" "./src/Makefile"))
              (for-each (lambda (f) 
                (substitute* f (("lpython2.[0-9a-z*]") "lpython3.10")))
                  `("configure" "./src/Makefile"))
              (invoke "grep" "ltcl" "configure")
              (chdir "plugins")
              (invoke "make" "TCLLDFLAGS=-ltcl8.6" "LINUXAMD64")
              (invoke "make" "distrib")
              (chdir "..")
            )
          )
          (replace 'configure
            (lambda* (#:key outputs inputs #:allow-other-keys)
              (setenv "PYTHON_INCLUDE_DIR" (string-append (assoc-ref inputs "python") "/include/python3.10"))
              (setenv "PYTHON_LIBRARY_DIR" (string-append (assoc-ref inputs "python") "/lib"))
              (setenv "NUMPY_INCLUDE_DIR" (string-append (assoc-ref inputs "python-numpy") "/lib/python3.10/site-packages/numpy/core/include"))
              (setenv "NUMPY_LIBRARY_DIR" (string-append (assoc-ref inputs "python-numpy") "/lib/python3.10/site-packages/numpy/core/lib"))
              (invoke "./configure")
              (chdir "src")
              (substitute* "Makefile" (("-I../plugins/LINUXAMD64") "-I../plugins/compile/lib_LINUXAMD64"))
              (substitute* "Makefile" (("-L../plugins/LINUXAMD64") "-L../plugins/compile/lib_LINUXAMD64"))
              (substitute* "Makefile" (("/bin/sh") (string-append (assoc-ref inputs "bash-minimal") "/bin/sh")))
              (invoke "make")
              (invoke "make" "install")
            )
          )
          (delete 'validate-runpath)
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
myvmd