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
              ; VMD works with environment varieables, setting them
              (setenv "VMDINSTALLNAME" "vmd")
              (setenv "VMDINSTALLBINDIR" (string-append (assoc-ref outputs "out") "/bin"))
              (setenv "VMDINSTALLLIBRARYDIR" (string-append (assoc-ref outputs "out") "/lib"))
              (setenv "PLUGINDIR" (string-append (assoc-ref outputs "out") "/lib/plugins"))
              (setenv "PYTHON_INCLUDE_DIR" (string-append (assoc-ref inputs "python") "/include/python3.10"))
              (setenv "PYTHON_LIBRARY_DIR" (string-append (assoc-ref inputs "python") "/lib"))
              (setenv "NUMPY_INCLUDE_DIR" (string-append (assoc-ref inputs "python-numpy") "/lib/python3.10/site-packages/numpy/core/include/numpy"))
              (setenv "NUMPY_LIBRARY_DIR" (string-append (assoc-ref inputs "python-numpy") "/lib/python3.10/site-packages/numpy/core/lib"))
              ; Plugins and the main VMD folder are separated and need to be put togehter
              (chdir "../vmd-1.9.4a57")
              (invoke "mv" "../plugins" ".")    
              ; Default configure options are of little interest to us
              (substitute* "configure.options"
               (("LINUXAMD64 OPENGL OPENGLPBUFFER FLTK TK ACTC CUDA CXX11 IMD LIBSBALL XINERAMA XINPUT LIBOPTIX LIBOSPRAY LIBTACHYON LIBPNG ZLIB VRPN NETCDF COLVARS TCL PYTHON PTHREADS NUMPY SILENT ICC")
                 "LINUXAMD64 GCC OPENGL OPENGLPBUFFER FLTK TK COLVARS IMD SILENT XINPUT TCL PTHREADS LIBPNG ZLIB NETCDF PYTHON NUMPY XINERAMA"))
              ; In ./configure, paths are hard coded which needs to be guix-adapted
             ; (invoke "head" "-n" "23" "./configure")
              ; (substitute* "configure"
              ;   (("install_bin_dir=\"/usr/local/bin\"")
              ;    (string-append
              ;     "install_bin_dir=\""
              ;     (assoc-ref outputs "out")
              ;     "/bin\"")))
             ; (substitute* "configure"
             ;   (("install_library_dir=\"/usr/local/lib/.*install_name\"")
             ;    (string-append
             ;     "install_library_dir=\"" (assoc-ref outputs "out")
             ;     "/lib\"")))
            )          
          )
          (add-after 'patch-source-shebangs 'compile-plugins
            (lambda* (#:key outputs inputs #:allow-other-keys)
              (chdir "plugins")
              (invoke "make" "distrib")
              (chdir "..")
            )
          )
          (replace 'configure
            (lambda* (#:key outputs inputs #:allow-other-keys)
              (invoke "./configure")
              (chdir "src")
              (substitute* "Makefile" (("-I../plugins/LINUXAMD64") "-I../plugins/compile/lib_LINUXAMD64"))
              (substitute* "Makefile" (("-L../plugins/LINUXAMD64") "-L../plugins/compile/lib_LINUXAMD64"))
              (substitute* "Makefile" (("/bin/sh") (string-append (assoc-ref inputs "bash-minimal") "/bin/sh")))
              (invoke "head" "-n" "50" "Makefile")
              (invoke "make")
              (invoke "make" "install")
            )
          )
          ; (add-after 'patch-source-shebangs 'compile-plugins
          ;   (lambda* (#:key outputs inputs #:allow-other-keys)

          ;   )
          ; )
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