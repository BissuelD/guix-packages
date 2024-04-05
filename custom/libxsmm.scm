(define-module (libxsmm)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix build-system gnu)
  #:use-module (guix git-download)
  #:use-module (gnu packages gcc))

(define-public libxsmm
  (package
    (name "libxsmm")
    (version "1.17") ;;;; PTHREAD DEPRECATION FIXED IN NEWER COMMITS ? ; NO RELEASE HAS IT WORKING, NEED "UNTAGGED" COMMIT LIKE 03f1da2
    (source
      (origin
        (method git-fetch)
        (uri (git-reference
              (url "https://github.com/libxsmm/libxsmm.git")
              (commit "1.17")))
        (file-name (git-file-name name version))
        (sha256 (base32 "0garfjzhydaqxl3fbbxm0y0nhpim1il58w71zvjx7488cv0asw0x"))))
    (inputs
     (list gfortran))
    (build-system gnu-build-system)
    (arguments
        (list 
            #:tests? #t
            #:phases 
              #~(modify-phases %standard-phases
                    (delete 'configure)
                    (delete 'install)
                    (replace 'build
                      (lambda* (#:key inputs #:allow-other-keys)
                        (invoke "make" "-j" (string-append "PREFIX=" (assoc-ref %outputs "out")) "install")
                      )
                    )
                    (replace 'check
                        (lambda* (#:key inputs #:allow-other-keys)
                        (invoke "make" "-j" "tests")
                      )
                    )
        ))
    )
    (home-page "https://github.com/libxsmm/libxsmm")
    (synopsis "LIBXSMM is a library for specialized dense and sparse matrix operations as well as for deep learning primitives such as small convolutions.")
    (description "The library is targeting Intel Architecture with Intel SSE, Intel AVX, Intel AVX2, Intel AVX‑512 (with VNNI and Bfloat16), and Intel AMX (Advanced Matrix Extensions) supported by future Intel processor code-named Sapphire Rapids. Code generation is mainly based on Just‑In‑Time (JIT) code specialization for compiler-independent performance (matrix multiplications, matrix transpose/copy, sparse functionality, and deep learning). LIBXSMM is suitable for build once and deploy everywhere, i.e., no special target flags are needed to exploit the available performance. ")
    (license license:bsd-3)))
libxsmm