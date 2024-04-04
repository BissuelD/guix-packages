(define-module (pexsi)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages gcc)
  #:use-module (gnu packages mpi)
  #:use-module (gnu packages shells)
  )

(define-public pexsi
  (package
    (name "pexsi")
    (version "2.0.0")
    (source
      (origin
        (method url-fetch)
        (uri "https://bitbucket.org/berkeleylab/pexsi/downloads/pexsi_v2.0.0.tar.gz")
        (sha256 (base32 "07x13jwjfknyah2ds5qzm9d8prw3r7p9x932lil0rgdj64lkrj65"))))
    (inputs
    `(
      ("parmetis" ,mypt-scotch "metis")
      ("pt-scotch" ,mypt-scotch)
      ("metis" ,metis) 
      ("superlu" ,mysuperlu-dist)
      ("gfortran" ,gfortran)
      ("openblas" ,openblas)
      ("lapack" ,lapack)
      ("openmpi" ,openmpi)
     ))
    (build-system cmake-build-system)
    (arguments 
      (list
        #:configure-flags
        #~(list
          ;  (string-append "-DParMETIS_PREFIX=" (assoc-ref %build-inputs "parmetis") "/lib")
           (string-append "-DParMETIS_LIBRARIES=" "-lptscotchparmetisv3")
          ;  (string-append "-DSuperLU_DIST_PREFIX=" (assoc-ref %build-inputs "superlu"))
           (string-append "-DSuperLU_DIST_INCLUDE_DIR=" (assoc-ref %build-inputs "superlu") "/include")
           (string-append "-DSuperLU_DIST_LIBRARIES=" "-lsuperlu")
          )
        #:tests? #f
        #:build-type "Release"
        #:phases 
        #~(modify-phases %standard-phases
              (add-before 'check 'mpi-setup #$%openmpi-setup)
           )))
    (home-page "http://www.pexsi.org/")
    (synopsis "The Pole EXpansion and Selected Inversion (PEXSI) method is a fast method for electronic structure calculation based on Kohn-Sham density functional theory.")
    (description "It efficiently evaluates certain selected elements of matrix functions, e.g., the Fermi-Dirac function of the KS Hamiltonian, which yields a density matrix. It can be used as an alternative to diagonalization methods for obtaining the density, energy and forces in electronic structure calculations. The PEXSI library is written in C++, and uses message passing interface (MPI) to parallelize the computation on distributed memory computing systems and achieve scalability on more than 10,000 processors.")
    (license license:bsd-3)))
pexsi

(define-public pexsi-old
  (package
    (name "pexsi-old")
    (version "0.10.2")
    (source
      (origin
        (method url-fetch)
        (uri (string-append "https://bitbucket.org/berkeleylab/pexsi/downloads/pexsi_v" version ".tar.gz"))
        (sha256 (base32 "17s9gcgcmhacz695lkza7vsjhb7v3z5sjdxm25i0jbjlfqdwf547"))))
    (inputs
    `(
      ("parmetis" ,mypt-scotch "metis")
      ("pt-scotch" ,mypt-scotch)
      ("metis" ,metis) 
      ("superlu-dist" ,superlu-dist)
      ("boost" ,boost)
      ("gfortran" ,gfortran)
      ("openblas" ,openblas)
      ("lapack" ,lapack)
      ("openmpi" ,openmpi)
     ))
    (build-system gnu-build-system)
    (arguments 
      (list 
        #:tests? #t
        #:phases 
          #~(modify-phases %standard-phases 
              (add-before 'check 'mpi-setup #$%openmpi-setup)
              (replace 'configure
                (lambda* (#:key outputs inputs #:allow-other-keys)
                  (invoke "cp" "config/make.inc.linux.gnu" "make.inc")
                  (substitute* "make.inc"
                    (("PEXSI_DIR *=.*pexsi") 
                     (string-append "PEXSI_DIR = " (getenv "TMPDIR") "/pexsi_v0.10.2"))
                    (("DSUPERLU_DIR *=.*2")
                     (string-append "DSUPERLU_DIR = " (assoc-ref inputs "superlu-dist")))
                    (("METIS_DIR *=.*release")
                     (string-append "METIS_DIR = " (assoc-ref inputs "metis")))
                    (("PARMETIS_DIR *=.*release")
                     (string-append "PARMETIS_DIR = " (assoc-ref inputs "parmetis")))
                    (("PTSCOTCH_DIR *=.*release")
                     (string-append "PTSCOTCH_DIR = " (assoc-ref inputs "pt-scotch")))
                    (("LAPACK_DIR *=.*0")
                     (string-append "LAPACK_DIR = " (assoc-ref inputs "lapack")))
                    (("BLAS_DIR *=.*release")
                     (string-append "BLAS_DIR = " (assoc-ref inputs "openblas")))
                    (("GFORTRAN_LIB *=.*8")
                     (string-append "GFORTRAN_LIB = " (assoc-ref inputs "gfortran") "/lib"))
                    (("DSUPERLU_LIB *=.*2.a")
                     (string-append "DSUPERLU_LIB = -L" (assoc-ref inputs "superlu-dist") "/lib" " -lsuperlu")) 
                  )
                )
              )
              (replace 'check
                (lambda* (#:key outputs inputs #:allow-other-keys)
                  ; DO STUFF
                  (invoke "ls")
                )
              )
            )))
    (home-page "http://www.pexsi.org/")
    (synopsis "The Pole EXpansion and Selected Inversion (PEXSI) method is a fast method for electronic structure calculation based on Kohn-Sham density functional theory.")
    (description "It efficiently evaluates certain selected elements of matrix functions, e.g., the Fermi-Dirac function of the KS Hamiltonian, which yields a density matrix. It can be used as an alternative to diagonalization methods for obtaining the density, energy and forces in electronic structure calculations. The PEXSI library is written in C++, and uses message passing interface (MPI) to parallelize the computation on distributed memory computing systems and achieve scalability on more than 10,000 processors.")
    (license license:bsd-3)))
pexsi-old

(define-public mysuperlu-dist
  (package
    (name "mysuperlu-dist")
    (version "6.4.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/xiaoyeli/superlu_dist")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0fa29yr72p4yq5ln4rgfsawmi5935n4qcr5niz6864bjladz4lql"))
       (modules '((guix build utils)))
       (snippet
        ;; Replace the non-free implementation of MC64 with a stub
        '(begin
           (make-file-writable "SRC/mc64ad_dist.c")
           (call-with-output-file "SRC/mc64ad_dist.c"
             (lambda (port)
               (display "
#include <stdio.h>
#include <stdlib.h>
void mc64id_dist(int *a) {
  fprintf (stderr, \"SuperLU_DIST: non-free MC64 not available.  Aborting.\\n\");
  abort ();
}
void mc64ad_dist (int *a, int *b, int *c, int *d, int *e, double *f, int *g,
              int *h, int *i, int *j, int *k, double *l, int *m, int *n) {
  fprintf (stderr, \"SuperLU_DIST: non-free MC64 not available.  Aborting.\\n\");
  abort ();
}\n" port)))
           (substitute* "SRC/util.c"    ;adjust default algorithm
             (("RowPerm[[:blank:]]*=[[:blank:]]*LargeDiag_MC64;")
              ;; TODO: set to "LargeDiag_AWPM" once combinatorial-blas has
              ;; general (i.e. non-square) processor-grid support.
              ; "RowPerm = LargeDiag_AWPM;"))
              "RowPerm = NOROWPERM;"))
           #t))
       (patches (search-patches "superlu-dist-scotchmetis.patch"
                                "superlu-dist-awpm-grid.patch"))))
    (build-system cmake-build-system)
    (native-inputs
     (list tcsh))
    (inputs
     `(("gfortran" ,gfortran)
       ("blas" ,openblas)
       ("lapack" ,lapack)
       ("combblas" ,combinatorial-blas)))
    (propagated-inputs
     `(("mpi" ,openmpi)                 ;headers include MPI heades
       ("parmetis" ,mypt-scotch "metis")
       ("pt-scotch" ,mypt-scotch)))
    (arguments
     `(#:parallel-tests? #f     ;tests use MPI and OpenMP
       #:configure-flags (list "-DBUILD_SHARED_LIBS:BOOL=YES"
                               "-DTPL_ENABLE_COMBBLASLIB=YES"
                               "-DTPL_BLAS_LIBRARIES=-lopenblas"
                              ; "-DTPL_ENABLE_INTERNAL_BLASLIB=ON"
                              "-DTPL_LAPACK_LIBRARIES=-llapack"
                               (string-append "-DTPL_PARMETIS_LIBRARIES="
                                              (string-join
                                               '("ptscotchparmetisv3" "ptscotch" "ptscotcherr"
                                                 "scotchmetisv3" "scotch" "scotcherr")
                                               ";"))
                               (string-append "-DTPL_PARMETIS_INCLUDE_DIRS="
                                              (assoc-ref %build-inputs "parmetis")
                                              "/include")
                               "-DTPL_ENABLE_COMBBLASLIB=ON"
                               (string-append "-DTPL_COMBBLAS_INCLUDE_DIRS="
                                              (assoc-ref %build-inputs "combblas")
                                              "/include/CombBLAS;"
                                              (assoc-ref %build-inputs "combblas")
                                              "/include/BipartiteMatchings")
                               "-DTPL_COMBBLAS_LIBRARIES=CombBLAS"
                              ;  "-DMPIEXEC_MAX_NUMPROCS=4"
                          )
       #:phases
       (modify-phases %standard-phases
         (add-before 'configure 'set-c++-standard
           (lambda _
             (substitute* "CMakeLists.txt"
               ;; AWPM headers require C++14
               (("CMAKE_CXX_STANDARD 11") "CMAKE_CXX_STANDARD 14")))
         )
	       (add-before 'check 'mpi-setup ,%openmpi-setup)
         (add-before 'check 'omp-setup
           (lambda _ (setenv "OMP_NUM_THREADS" "1") #t)
         )
         (replace 'check 
          (lambda  _(invoke "make" "-j1" "test") #t)
         )
        )))
    (home-page (package-home-page superlu))
    (synopsis "Parallel supernodal direct solver")
    (description
     "SuperLU_DIST is a parallel extension to the serial SuperLU library.
It is targeted for distributed memory parallel machines.  SuperLU_DIST is
implemented in ANSI C, and MPI for communications.")
    (license license:bsd-3)))

; (define-public mysuperlu-dist
;   (package
;     (name "mysuperlu-dist")
;     (version "7.2.0")
;     (source
;       (origin
;         (method url-fetch)
;         (uri (string-append "https://github.com/xiaoyeli/superlu_dist/archive/v"
;                             version ".tar.gz"))
;         (sha256 (base32 "134b8srn5xqs9gkh9mrg5vqxra5p02bsw4b5rv4k306qlgc0pdi0"))))
;     (inputs
;     `(("pt-scotch" ,mypt-scotch)
;       ("parmetis" ,mypt-scotch "metis")
;       ("gfortran" ,gfortran)
;       ("openblas" ,openblas)
;       ("lapack" ,lapack)
;       ("openmpi" ,openmpi)
;      )
;     )
;     (build-system cmake-build-system)
;     (arguments 
;       (list 
;         #:configure-flags
;         #~(list 
;             (string-append "-DTPL_PARMETIS_LIBRARIES="
;               (string-join
;                 '("ptscotchparmetisv3" "ptscotch" "ptscotcherr"
;                   "scotchmetisv3" "scotch" "scotcherr")
;                 ";"))
;             (string-append "-DTPL_PARMETIS_INCLUDE_DIRS=" 
;                            (assoc-ref %build-inputs "parmetis") "/include")
;             "-DBUILD_SHARED_LIBS=yes"
;             "-DTPL_ENABLE_LAPACKLIB=yes"
;             "-DCMAKE_INSTALL_PREFIX=."
;           )
;         #:build-type "Release"
;         #:phases 
;           #~(modify-phases %standard-phases 
;               (add-before 'check 'mpi-setup #$%openmpi-setup)
;               (add-after 'unpack 'patch-envs
;                 (lambda* (#:key outputs inputs #:allow-other-keys)
;                   (setenv "PARMETIS_ROOT" (assoc-ref inputs "parmetis"))
;                   (setenv "PARMETIS_BUILD_DIR" (string-append (getenv "PARMETIS_ROOT") "/lib"))
;                 )              
;               )
;             )))
;     (home-page "https://portal.nersc.gov/project/sparse/superlu/superlu_dist_code_html/")
;     (synopsis "SuperLU_DIST contains a set of subroutines to solve a sparse linear system A*X=B.")
;     (description "It uses Gaussian elimination with static pivoting (GESP). Static pivoting is a technique that combines the numerical stability of partial pivoting with the scalability of Cholesky (no pivoting), to run accurately and efficiently on large numbers of processors.

; SuperLU_DIST is a parallel extension to the serial SuperLU library. It is targeted for the distributed memory parallel machines. SuperLU_DIST is implemented in ANSI C, with OpenMP for on-node parallelism and MPI for off-node communications. We are actively developing GPU acceleration capabilities.")
;     (license license:bsd-3)))
mysuperlu-dist

(define-public mypt-scotch
  (package
    (inherit pt-scotch)
    (name "mypt-scotch")
    (propagated-inputs
     (list openmpi))                              ;headers include MPI headers
    (arguments
     (substitute-keyword-arguments (package-arguments scotch)
       ((#:configure-flags flags ''())
        ''("-DBUILD_SHARED_LIBS=YES" "-DBUILD_PTSCOTCH=ON"
          ;  "-DINTSIZE=64"
          ))
       ((#:phases phases '%standard-phases)
        `(modify-phases ,phases
           (add-before 'check 'mpi-setup
             ,%openmpi-setup)))))
    (synopsis "Programs and libraries for graph algorithms (with MPI)")))