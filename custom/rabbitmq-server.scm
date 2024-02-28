(define-module (rabbitmq-server)
  #:use-module (guix)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages)
  #:use-module (guix download)
  #:use-module (guix utils)
  #:use-module (guix build utils)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system rebar)
  #:use-module (gnu packages base) 
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages ruby)
  #:use-module (gnu packages erlang)
  #:use-module (gnu packages elixir)
  #:use-module (gnu packages xml))

(define-public erlang-thoas
  (package
    (name "erlang-thoas")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (hexpm-uri "thoas" version))
       (sha256
        (base32 "0db7s8xpzafj4wj7l1v62frv3dn30gp3bdsgalmb7v1jp62k2xpw"))))
    (build-system rebar-build-system)
    (synopsis "A blazing fast JSON parser and generator in pure Erlang.")
    (description
     "This package provides a blazing fast JSON parser and generator in pure Erlang.")
    (home-page "https://hexdocs.pm/thoas/")
    (license license:gpl3)))

(define-public erlang-recon
  (package
    (name "erlang-recon")
    (version "2.5.3")
    (source
     (origin
       (method url-fetch)
       (uri (hexpm-uri "recon" version))
       (sha256
        (base32 "1mwr6267lwl4p7f8jfk14s4cszxwra6zgf84hkcxz8fldzs86rkc"))))
    (build-system rebar-build-system)
    (synopsis "Diagnostic tools for production use")
    (description "Diagnostic tools for production use")
    (home-page "https://hexdocs.pm/recon/")
    (license license:bsd-4)))

(define-public erlang-credentials-obfuscation
  (package
    (name "erlang-credentials-obfuscation")
    (version "3.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (hexpm-uri "credentials_obfuscation" version))
       (sha256
        (base32 "0rnmrvdqbgadkhkfadlh04nmhsvgzh33jf7psc82fpalsl7cx2kk"))))
    (build-system rebar-build-system)
    (synopsis
     "Helper library that obfuscates sensitive values in process state")
    (description
     "Helper library that obfuscates sensitive values in process state")
    (home-page "https://hexdocs.pm/credentials_obfuscation/")
    (license license:mpl2.0)))


(define-public rabbitmq-server
  (package
    (name "rabbitmq-server")
    (version "3.13.0")
    (source
      (origin
        (method url-fetch)
        (uri (string-append "https://github.com/rabbitmq/rabbitmq-server/archive/refs/tags/v" version ".tar.gz"))
        (sha256 (base32 "0634k04nnp1lirw8643ahac9nqlfzdlmivz33i9qkkqhhdmi05ss"))))
    (inputs
     (list python-simplejson
           erlang
           elixir
           libxslt
           xmlto
           curl
           perl
           python-wrapper
           ruby
           bats
           erlang-thoas
           erlang-recon
           erlang-credentials-obfuscation))
    (build-system gnu-build-system)
    (arguments
   `(#:phases
      (modify-phases %standard-phases
        (delete 'configure)
        (delete 'install)
         (replace 'build
           (lambda _
               (invoke "make" "-j8")))
      )
      #:tests? #f
      )
    )
    (home-page "https://www.rabbitmq.com/")
    (synopsis "RabbitMQ is a widely deployed open source messaging and streaming broker")
    (description "RabbitMQ is a reliable, stable, and mature messaging and streaming broker, which is easy to deploy on cloud environments, on-premises, and on your local machine. With support for many different messaging protocols, it can scale from providing point-to-point messaging all the way up to globally distributed highly-available event streaming with rock-solid reliability.")
    (license license:mpl2.0)))

;; This allows you to run guix shell -f guix-packager.scm.
;; Remove this line if you just want to define a package.
rabbitmq-server