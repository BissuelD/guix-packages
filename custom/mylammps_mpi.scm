(define-module (custom mylammps_mpi)
      #:use-module ((guix licenses) #:prefix license:)
      #:use-module (guix packages)
      #:use-module (guix download)
      #:use-module (guix utils)
      #:use-module (guix build utils)
      #:use-module (guix build-system cmake)
      #:use-module (guix build-system gnu)
      #:use-module (gnu packages)
      #:use-module (gnu packages base) ;; new one
      #:use-module (gnu packages algebra)
      #:use-module (gnu packages image-processing)
      #:use-module (gnu packages image)
      #:use-module (gnu packages graphics)
      #:use-module (gnu packages maths)
      #:use-module (gnu packages mpi)
      #:use-module (gnu packages cmake) ;; new one
      #:use-module (gnu packages python)
      #:use-module (gnu packages python-xyz)
      #:use-module (gnu packages compression)
      #:use-module (gnu packages commencement)
      #:use-module (gnu packages gcc)
      #:use-module (gnu packages vim) ;; new one
      #:use-module (gnu packages pkg-config)
      #:use-module (gnu packages video)
      #:use-module (gnu packages llvm)
      ;#:use-module (gnu packages ssh) ;; newer one
      #:use-module (gnu packages multiprecision))


(define-public n2p2-lib
 (package
    (name "n2p2-lib")
    (version "2.1.4")
    (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/CompPhysVienna/n2p2/archive/refs/tags/v" version ".tar.gz"))
            (sha256
             (base32
              "1vql7awa9yq795bxkgq4izlzx83m8rz9f1k675znmlafmw4jqrzi"))))
    (build-system gnu-build-system)
      (arguments
        `(#:phases
         (modify-phases %standard-phases
          (add-after 'unpack 'post-unpack
            (lambda* (#:key outputs inputs #:allow-other-keys)
              (chdir "./src")
              (substitute* "makefile.gnu"
                (("PROJECT_EIGEN=/usr/include/eigen3")
                 (string-append "PROJECT_EIGEN="
                                (assoc-ref inputs "eigen") "/include/eigen3")))
              (substitute* "makefile.gnu"
                (("-lblas")
                 (string-append "-L"
                                (assoc-ref inputs "openblas") "/lib -lopenblas")))))
           (delete 'configure)
           (delete 'check)
           (replace 'build
             (lambda _
               (invoke "make" "MODE=shared")))
           (replace 'install
             (lambda* (#:key outputs inputs #:allow-other-keys)
                (let* ((out (assoc-ref outputs "out"))
                    (bindir (string-append out "/bin"))
                    (libdir (string-append out "/lib"))
                    (incdir (string-append out "/include")))
                    (for-each (lambda (f) (install-file f libdir))
                             (find-files "../lib/" "."))
                    (for-each (lambda (f) (install-file f incdir))
                             (find-files "../include/" "."))))))))
    (inputs
    `(("openmpi" ,openmpi)
      ("gsl" ,gsl)
      ("openblas" ,openblas)
      ("eigen" ,eigen)))
  (synopsis "Classical molecular dynamics simulator")
  (description "LAMMPS is a classical molecular dynamics simulator designed to run efficiently on parallel computers.  LAMMPS has potentials for solid-state materials (metals, semiconductors), soft matter (biomolecules, polymers), and coarse-grained or mesoscopic systems.  It can be used to model atoms or, more generically, as a parallel particle simulator at the atomic, meso, or continuum scale.")
  (home-page "http://lammps.sandia.gov/")
  (license license:gpl2+)))


(define-public kim-api
  (package
    (name "kim-api")
    (version "2.3.0")
    (source (origin
      (method url-fetch)
      (uri (string-append "https://s3.openkim.org/kim-api/kim-api-" version ".txz"))
      (sha256
        (base32
          "14gr2hn8d5ii6wzcdaqcs5k36ybj2rfr2rzfya8mfqn0zfw3nrwk"))))
    (build-system cmake-build-system)
    (arguments
      `(#:configure-flags
        (list
          "-DCMAKE_BUILD_TYPE=Release"
          (string-append "-DCMAKE_INSTALL_PREFIX=" (assoc-ref %outputs "out")))
        #:phases
        (modify-phases %standard-phases
          (delete 'validate-runpath)
          (add-after 'unpack 'post-unpack
            (lambda* (#:key outputs inputs version #:allow-other-keys)
              (invoke "tar" "xf" (string-append "kim-api-" ,version ".tar"))
              (mkdir-p "./build")
              (chdir "./build")
              (setenv "FC" (which "gfortran"))
            )
          )
          (replace 'configure
            (lambda* (#:key inputs outputs configure-flags #:allow-other-keys)
                     (let ((out (assoc-ref outputs "out")))
                       (apply invoke "cmake" (string-append "../kim-api-" ,version ) configure-flags)
                     )
            )
          )
        )
        #:tests? #f
       )
    )
    ;; TODO how to install make (and others?) as a propagated-input if required to install user models?
    (propagated-inputs
      `(("tar" ,tar)
        ("gfortran" ,gfortran-toolchain)
        ("cmake" ,cmake)
    ;;    ("make" ,make)
        ("xxd" ,xxd)
        ("pkg-config" ,pkg-config)
        ("gcc-toolchain" ,gcc-toolchain-11)))
    (synopsis "Open Knowledgebase of Interatomic Models")
    (description "OpenKIM is a curated repository of interatomic potentials and analytics for making classical molecular simulations of materials reliable, reproducible, and accessible.")
    (home-page "https://openkim.org/")
    (license license:lgpl2.1+)))



(define-public mylammps_mpi
  (package
  (name "mylammps_mpi")
  (version "patch_2Jul2021")
  (source (origin
            (method url-fetch)
            (uri (string-append "https://github.com/lammps/lammps/archive/refs/tags/" version ".tar.gz"))
            (sha256
             (base32
              "0mzagwvrk97pyqjlpqpb487887xffc5na5l70k00k26yvfi8rpag"))))
  (build-system cmake-build-system)
  (arguments
   `(#:configure-flags
      (list
      "-DPKG_COMPRESS=yes"       ;; in most, was already here
      "-DPKG_DIFFRACTION=yes"    ;; in most, was already here
      "-DPKG_DPD-BASIC=yes"      ;; in most, was already here
      "-DPKG_EFF=yes"            ;; in most, was already here
      "-DPKG_KSPACE=yes"         ;; in most, was already here
      "-DPKG_MANYBODY=yes"       ;; in most, was already here
      "-DPKG_MC=yes"             ;; in most, was already here
      "-DPKG_MEAM=yes"           ;; in most, was already here
      "-DPKG_MISC=yes"           ;; in most, was already here
      "-DPKG_MOLECULE=yes"       ;; in most, was already here
      "-DPKG_PHONON=yes"         ;; in most, was already here
      "-DPKG_REAXFF=yes"         ;; in most, was already here
      "-DPKG_RIGID=yes"          ;; in most, was already here
      "-DPKG_USER-MISC=yes"      ;; not included in most but was there
      "-DPKG_ML-RANN=yes"        ;; not included in most but was there
      "-DPKG_ML-HDNNP=yes"       ;; not included in most but was there
      "-DDOWNLOAD_N2P2=no"       ;; because we built it earlier
      ;; Additions to support more kind of computations.  ;;
      ;; It is also a nice exercice with new dependances. ;;
      "-DPKG_KIM=yes"
      "-DDOWNLOAD_KIM=no"
      "-C ../cmake/presets/most.cmake"                      ; manually added by DB
      "-DPKG_VORONOI=no"                                    ; for now, adding it later
      "-D LAMMPS_MACHINE=mpi"                               ; manually added by DB
      "-D BUILD_MPI=yes"                                    ; manually added by DB
      ;; End of the additions ... for now ;) ;;
      (string-append "-DN2P2_DIR=" (assoc-ref %build-inputs "n2p2-lib"))
      (string-append "-DCMAKE_INSTALL_PREFIX=" (assoc-ref %outputs "out")))
      #:phases
      (modify-phases %standard-phases
        (add-after 'unpack 'post-unpack
          (lambda* (#:key outputs inputs #:allow-other-keys)
            (mkdir-p "./build")
            (chdir "./build")))
        (replace 'configure
          (lambda* (#:key inputs outputs configure-flags #:allow-other-keys)
            (let ((out (assoc-ref outputs "out")))
              (apply invoke "cmake" "../cmake" configure-flags)))))
      #:tests? #f))
  (inputs
    `(("python" ,python-wrapper)      ; not sure it is mandatory as we don't build the python utilitaries
      ("gfortran" ,gfortran)          ; why is it mandatory ? -> Used for a few examples and maybe interfacing ?
      ("gcc" ,gcc)                    ; covers for libgcc-s1 ? And libc6 ? And libstdc++6 ?
      ("pkg-config" ,pkg-config)      ; why is it mandatory ?
      ("zlib" ,zlib)                  ; covers for zlib1g
      ("libomp" ,libomp)              ; covers for libgomp1
      ("zstd" ,zstd)                  ; covers for zstd (and libzstd1 ?)
      ("fftw" ,fftw)                  ; covers for libfftw3-double3
      ;; Not sure if it is already covered
      ;;    > libgcc-s1
      ;;    > libc6
      ;;    > libstdc++6
      ;;    > libzstd1
      ;;    > openmpi-bin
      ;;    > libopenmpi-dev
      ;;    > mpi-default-bin
      ;; Mandatory stuff to add to support previous additions. ;;
      ;;    > liblapack3 ? -> Maybe not necessary to link it, present in maths.scm.
      ;;                      But then why not the same for fftw (in algebra.scm) ?
      ;;    > libkimapi-dev ?   -> not built with "most" option.
      ("kim-api" ,kim-api)
      ;;    > openkim-models ?  -> not built with "most" option. Not needed ???
      ;;    > libevent-2.1.7 ?
      ;;    > libexpat1 ?
      ;;    > libhwloc15 ?
      ;;    > libltdl7 ?
      ;;    > libvoro++1 ?
      ;;    > rsync ?
      ;;    > libudev1 ?
      ;;    > eigen ?
      ("eigen" ,eigen)
      ;;    > libreadline8 ?
      ;;    > valgring ?
      ;;    > gdb ?
      ;;    > autossh
      ;("mpich", mpich) ; necessary for parallel run to avoid ssh/rsh errors ?
      ;; End of the additions ... for now ;) ;;
      ("n2p2-lib" ,n2p2-lib)          ; Because we don't build it manually on the fly, although I think
                                      ; it can easily be worked around. Not done because it is slower ?
                                      ; or less reproducible ? (more likely)
      ("openmpi" ,openmpi)            ; covers for openmpi-bin ? libopenmpi-dev ? mpi-default-bin ?
      ("ffmpeg" ,ffmpeg)              ; covers for ffmpeg
      ("libpng" ,libpng)              ; covers for libpng-dev
      ("libjpeg" ,libjpeg-turbo)      ; covers for libjpeg-dev
      ("hdf5" ,hdf5)                  ; covers for hdf5-tools
      ("gzip" ,gzip)))                ; why is this mandatory ? -> Because we pull a .tar.gz ?
  (native-inputs
    `(("bc" ,bc)))
  (synopsis "Classical molecular dynamics simulator")
  (description "LAMMPS is a classical molecular dynamics simulator designed to run efficiently on parallel computers.  LAMMPS has potentials for solid-state materials (metals, semiconductors), soft matter (biomolecules, polymers), and coarse-grained or mesoscopic systems.  It can be used to model atoms or, more generically, as a parallel particle simulator at the atomic, meso, or continuum scale.")
  (home-page "http://lammps.sandia.gov/")
  (license license:gpl2+)))
  mylammps_mpi
