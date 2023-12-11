(define-module (myparaview)
    #:use-module ((guix licenses) #:prefix license:)
    ;#:use-module (guix build utils)
    #:use-module (guix download)
    #:use-module (guix packages)
    #:use-module (gnu packages compression)
    ;#:use-module (guix build-system copy)
    #:use-module (gnu packages elf)
    #:use-module (gnu packages python)
    #:use-module (nonguix build-system binary)
)

(define-public myparaview
  (package
  (name "myparaview")
  (version "5.12.0-RC1-MPI-Linux-Python3.10-x86_64")
  (source (origin
    (method url-fetch)
	  (uri (string-append 
            "https://www.paraview.org/paraview-downloads/download.php?submit=";))
            "Download&version=v5.12&type=binary&os=Linux&downloadFile=ParaView-";))
            version ".tar.gz"))
    (file-name (string-append name "-" version ".tar.gz"))
          (sha256
          (base32
            "0phblim3av1l8rjj9n9wdgcgvgm9x4sfyv7y2dg5fpb9vjf8ksgz"))))
  (build-system binary-build-system)
  (arguments
   `(
    #:strip-binaries? #f 
    #:patchelf-plan 
     (let ((libs '( ; exemple
                  ; "gcc"
                  ; "glib"
                  ; "glibc"
                  ; "libomp"
                   ;"python-2"
                   "python"))
          )
     `(("bin/*"      ,libs)
       ("bin/paraview-real" ,libs) 
       ))
    #:validate-runpath? #t
    #:install-plan '(
      ("bin" "bin")
      ("lib" "lib")
      ("plugins" "plugins")
      ("share" "share")
    )))
  (native-inputs (list patchelf))
  (inputs
   (list  ; exemple
    ;(list gcc "lib")
    ;      glib
    ;      glibc
    ;      libomp
          ;python-2
          python)
  )
  (synopsis "ParaView is the world’s leading open source post-processing visualization engine.")
  (description "ParaView is the world’s leading open source post-processing visualization engine. It integrates with your existing tools and workflows, allowing you to build visualizations to analyze data quickly. With its open, flexible, and intuitive user interface, you can analyze extremely large datasets interactively in 3D or programmatically using ParaView’s batch processing.")
  (home-page "https://www.paraview.org/")
  (license license:bsd-3)))
  myparaview