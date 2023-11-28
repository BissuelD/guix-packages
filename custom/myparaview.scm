(define-module (myparaview)
    #:use-module ((guix licenses) #:prefix license:)
    #:use-module (guix download)
    #:use-module (guix packages)
    #:use-module (gnu packages compression)
    #:use-module (guix build-system copy)
    #:use-module (gnu packages python)
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
  (build-system copy-build-system)
  (arguments
   `(#:phases 
    (modify-phases %standard-phases
	    (add-after 'unpack 'chmod
	      (lambda* (#:key #:allow-other-keys)
	        (chmod "bin/paraview" #o755)))
      (delete `validate-runpath)
    )
    #:substitutable? #f
    #:install-plan '(
      ("bin" "bin")
      ("lib" "lib")
      ("plugins" "plugins")
      ("share" "share")
    )))
  (inputs
     `(
      ("python" ,python)
      ("python-2" ,python-2)
      ))
  ;(native-inputs
  ;  `(("bc" ,bc)))
  (native-search-paths
   (list (search-path-specification
          (variable "LD_LIBRARY_PATH")
          (files (list "lib" "lib/catalyst" "lib/mesa" "lib/mpi")))
          (search-path-specification
          (variable "RUNPATH")
          (files (list "lib" "lib/catalyst" "lib/mesa" "lib/mpi")))))
  (synopsis "ParaView is the world’s leading open source post-processing visualization engine.")
  (description "ParaView is the world’s leading open source post-processing visualization engine. It integrates with your existing tools and workflows, allowing you to build visualizations to analyze data quickly. With its open, flexible, and intuitive user interface, you can analyze extremely large datasets interactively in 3D or programmatically using ParaView’s batch processing.")
  (home-page "https://www.paraview.org/")
  (license license:bsd-3)))
  myparaview