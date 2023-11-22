(define-module (myparaview)
    #:use-module ((guix licenses) #:prefix license:)
    #:use-module (guix download)
    #:use-module (guix packages)
    #:use-module (gnu packages compression)
    #:use-module (guix build-system copy)
)

(define-public myparaview
  (package
  (name "myparaview")
  (version "5.12.0-RC1-MPI-Linux-Python3.10-x86_64")
  (source (origin
    (method url-fetch)
	  ;(uri `("https://www.paraview.org/paraview-downloads/download.php?submit=Download&version=v5.12&type=binary&os=Linux&downloadFile=ParaView-" version ".tar.gz"))
    (uri `("https://www.paraview.org/paraview-downloads/"))
    (file-name (string-append "download.php?submit=Download&version=v5.12&type=binary&os=Linux&downloadFile=ParaView-" version ".tar.gz"))
          (sha256
          (base32
            "0phblim3av1l8rjj9n9wdgcgvgm9x4sfyv7y2dg5fpb9vjf8ksgz"))))
  (build-system copy-build-system)
  (arguments
   `(#:install-plan
      `(("bin" "bin")
        ("lib" "lib")
        ("plugins" "plugins")
        ("share" "share"))))
  ;(inputs
  ;   `(("gcc" ,gcc)                    ; covers for libgcc-s1 ? And libc6 ? And libstdc++6 ?
  ;     ("gzip" ,gzip)))                ; why is this mandatory ? -> Because we pull a .tar.gz ?
  ;(native-inputs
  ;  `(("bc" ,bc)))
  (synopsis "ParaView is the world’s leading open source post-processing visualization engine.")
  (description "ParaView is the world’s leading open source post-processing visualization engine. It integrates with your existing tools and workflows, allowing you to build visualizations to analyze data quickly. With its open, flexible, and intuitive user interface, you can analyze extremely large datasets interactively in 3D or programmatically using ParaView’s batch processing.")
  (home-page "https://www.paraview.org/")
  (license license:bsd-3)))
  myparaview