(define-module (python-aiida-core)
    #:use-module ((guix licenses) #:prefix license:)
    #:use-module (guix packages)
    #:use-module (guix download)
#:use-module (gnu packages gcc)
#:use-module (guix build-system cargo)
#:use-module (gnu packages crates-io)
#:use-module (gnu packages rust)
#:use-module (gnu packages tree-sitter)
#:use-module (gnu packages rust-apps)
#:use-module (gnu packages chemistry)
#:use-module (gnu packages compression)
#:use-module (gnu packages python)
#:use-module (gnu packages django)
#:use-module (gnu packages openstack)
#:use-module (gnu packages serialization)
#:use-module (gnu packages libffi)
#:use-module (gnu packages python-compression)
#:use-module (gnu packages statistics)
#:use-module (gnu packages xml)
#:use-module (gnu packages graph)
#:use-module (gnu packages jupyter)
#:use-module (gnu packages freedesktop)
#:use-module (gnu packages terminals)
#:use-module (gnu packages python-science)
#:use-module (gnu packages time)
#:use-module (gnu packages python-build)
#:use-module (gnu packages sphinx)
#:use-module (gnu packages version-control)
#:use-module (gnu packages python-crypto)
#:use-module (gnu packages python-check)
#:use-module (gnu packages graphviz)
#:use-module (gnu packages python-web)
#:use-module (gnu packages check)
    #:use-module (guix build-system python)
    #:use-module (guix build-system pyproject)
    #:use-module (gnu packages databases)
    #:use-module (gnu packages python-xyz)
)

(define-public python-aiida-core
  (package
    (name "python-aiida-core")
    (version "2.5.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "aiida_core" version))
       (sha256
        (base32 "1d1kbh8v0g96qa6962vc5qzg9gkss4aggln4gv89812z6p59hn4s"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-aiida-export-migration-tests
                             python-aio-pika
                             python-alembic
                             python-archive-path
                             python-ase
                             python-bpython
                             python-circus
                             python-click
                             python-click-spinner
                             python-coverage
                             python-disk-objectstore
                             python-docstring-parser
                             python-docutils
                             python-flask
                             python-flask-cors
                             python-flask-restful
                             python-graphviz
                             python-gssapi
                             python-importlib-metadata
                             python-ipython
                             python-jedi
                             python-jinja2
                             python-jupyter
                             python-jupyter-client
                             python-kiwipy
                             python-matplotlib
                             python-mypy
                             python-notebook
                             python-numpy
                             python-packaging
                             python-paramiko
                             python-pg8000
                             python-pgsu
                             python-pgtest
                             python-plumpy
                             python-pre-commit
                             python-psutil
                             python-psycopg2-binary
                             python-pyasn1
                             python-pycifrw
                             python-pydantic
                             python-pydata-sphinx-theme
                             python-pymatgen
                             python-pympler
                             python-pymysql
                             python-pyparsing
                             python-pytest
                             python-pytest-asyncio
                             python-pytest-benchmark
                             python-pytest-cov
                             python-pytest-regressions
                             python-pytest-rerunfailures
                             python-pytest-timeout
                             python-memcached
                             python-pytz
                             python-pyyaml
                             python-requests
                             python-seekpath
                             spglib
                             python-sphinx
                             python-sphinx-copybutton
                             python-sphinx-design
                             python-sphinx-intl
                             python-sphinx-notfound-page
                             python-sphinx-sqlalchemy
                            ;  python-sphinxext-rediraffe
                            python-sphinx
                             python-sqlalchemy2
                             python-tabulate
                             python-tomli
                             python-tqdm
                             python-trogon
                             python-types-pyyaml
                             python-upf-to-json
                             python-wrapt))
    (home-page "https://www.aiida.net/")
    (synopsis
     "AiiDA is a workflow manager for computational science with a strong focus on provenance, performance and extensibility.")
    (description
     "AiiDA is a workflow manager for computational science with a strong focus
on provenance, performance and extensibility.")
    (license license:x11)))
    python-aiida-core

(define-public python-aiida-export-migration-tests
  (package
    (name "python-aiida-export-migration-tests")
    (version "0.9.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "aiida-export-migration-tests" version))
       (sha256
        (base32 "0qsydgwafap0dfxav1qhq0x199pvynj29yq63zf238h6xca4qmnj"))))
    (build-system pyproject-build-system)
    (home-page "https://github.com/aiidateam/aiida-export-migration-tests")
    (synopsis "Export archives for migration tests for AiiDA")
    (description "Export archives for migration tests for @code{AiiDA}")
    (license #f)))

(define-public python-aio-pika
  (package
    (name "python-aio-pika")
    (version "9.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "aio_pika" version))
       (sha256
        (base32 "1hgfzrmban0y0ym07dhbfs7cx8w3pf1h6fb2i4rv23xxa07vx6ai"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-aiormq python-setuptools
                             python-typing-extensions python-yarl))
    (home-page "https://github.com/mosquito/aio-pika")
    (synopsis "Wrapper around the aiormq for asyncio and humans")
    (description "Wrapper around the aiormq for asyncio and humans")
    (license #f)))


(define-public python-archive-path
  (package
    (name "python-archive-path")
    (version "0.4.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "archive-path" version))
       (sha256
        (base32 "0l9scd4wf9f16lny0fmxy5sssx2yv5sbm6g291klyslqx81r09vm"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-coverage python-pre-commit python-pytest
                             python-pytest-cov python-flit-core))
    (home-page "https://github.com/aiidateam/archive-path")
    (synopsis
     "A package to provide pathlib like access to zip & tar archives.")
    (description
     "This package provides a package to provide pathlib like access to zip & tar
archives.")
    (license #f)))


(define-public python-ase
  (package
    (name "python-ase")
    (version "3.22.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "ase" version))
       (sha256
        (base32 "0cml5bc57y2s8a9nmii567jv0phjsi2zxb8gg5613c84xaqgck80"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-matplotlib python-numpy python-scipy))
    (native-inputs (list python-pytest python-pytest-mock python-pytest-xdist))
    (home-page "https://wiki.fysik.dtu.dk/ase")
    (synopsis "Atomic Simulation Environment")
    (description "Atomic Simulation Environment")
    (license #f)))


(define-public python-bpython
  (package
    (name "python-bpython")
    (version "0.24")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "bpython" version))
       (sha256
        (base32 "1g9xzl49skghd9q2a8b71gg1n97lfnj9in2kzcmzsj4cgbynywwq"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list
                             python-curtsies
                             python-cwcwidth
                             python-greenlet
                             python-pygments
                             python-pyxdg
                             python-requests
                             python-typing-extensions
                             python-urwid))
    (home-page "https://www.bpython-interpreter.org/")
    (synopsis "")
    (description "")
    (license license:expat)))


(define-public python-circus
  (package
    (name "python-circus")
    (version "0.18.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "circus" version))
       (sha256
        (base32 "1aviikpagmvy1qdar0vmlm8lnrxndw887x2cf9kfv3069qifhg0r"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-coverage
                             python-flake8
                             python-gevent
                             python-mock
                             python-nose2
                             python-psutil
                             python-pyyaml
                             python-pyzmq
                             python-tornado
                             python-tox
                             python-flit-core))
    (home-page "")
    (synopsis
     "Circus is a program that will let you run and watch multiple processes and sockets.")
    (description
     "Circus is a program that will let you run and watch multiple processes and
sockets.")
    (license #f)))


(define-public python-click-spinner
  (package
    (name "python-click-spinner")
    (version "0.1.10")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "click-spinner" version))
       (sha256
        (base32 "1bsxjxp3czm3515vlask7a8vzbl28xyzapk1swjkm5wqfafwzsl7"))))
    (build-system pyproject-build-system)
    (native-inputs (list python-click python-pytest python-six))
    (home-page "https://github.com/click-contrib/click-spinner")
    (synopsis "Spinner for Click")
    (description "Spinner for Click")
    (license license:expat)))


(define-public python-disk-objectstore
  (package
    (name "python-disk-objectstore")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "disk_objectstore" version))
       (sha256
        (base32 "1nvpa7g6kz73ssyx7r5ynd117aq8aybvmak19a1zqli5gs0kl7m6"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-click
                             python-coverage
                             python-h5py
                             python-jinja2
                             python-memory-profiler
                             python-myst-parser
                             python-numpy
                             python-pre-commit
                             python-profilehooks
                             python-psutil
                             python-pytest
                             python-pytest-benchmark
                             python-pytest-cov
                             python-sphinx
                             python-sphinx-panels
                            ;  python-sphinxext-rediraffe
                            python-sphinx
                             python-sqlalchemy2
                             python-tqdm
                             python-flit-core))
    (home-page "")
    (synopsis
     "An implementation of an efficient object store that writes directly on disk.")
    (description
     "An implementation of an efficient object store that writes directly on disk.")
    (license #f)))


(define-public python-jupyter
  (package
    (name "python-jupyter")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "jupyter" version))
       (sha256
        (base32 "0pwf3pminkzyzgx5kcplvvbvwrrzd3baa7lmh96f647k30rlpp6r"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-ipykernel
                             python-ipywidgets
                             python-jupyter-console
                             python-nbconvert
                             python-notebook
                             python-qtconsole))
    (home-page "http://jupyter.org")
    (synopsis
     "Jupyter metapackage. Install all the Jupyter components in one go.")
    (description
     "Jupyter metapackage.  Install all the Jupyter components in one go.")
    (license license:bsd-3)))


(define-public python-kiwipy
  (package
    (name "python-kiwipy")
    (version "0.8.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "kiwipy" version))
       (sha256
        (base32 "0ypmr7cw713z3fispfgr6xpmkinsmqfamlvv60m2rb7s0zx30n32"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-aio-pika
                             python-coverage
                             python-deprecation
                             python-docutils
                             python-ipykernel
                             python-jupyter
                             python-msgpack
                             python-nbsphinx
                             python-pamqp
                             python-pandoc
                             python-pika
                             python-pre-commit
                             python-pylint
                             python-pytest
                             python-pytest-asyncio
                             python-pytest-benchmark
                             python-pytest-cov
                             python-pytray
                             python-pyyaml
                             python-shortuuid
                             python-sphinx
                             python-sphinx-autobuild))
    (home-page "")
    (synopsis "Robust, high-volume, message based communication made easy.")
    (description "Robust, high-volume, message based communication made easy.")
    (license #f)))


(define-public python-pg8000
  (package
    (name "python-pg8000")
    (version "1.30.5")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pg8000" version))
       (sha256
        (base32 "130713m1wa64ykk8syz9ala7hk5qvz0h5z79n9f6j8yp1k87lbq7"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
          (delete 'sanity-check) ; detects scramp 0.0.0 where it is actually 1.4.4
        )
      )
    )
    (propagated-inputs (list python-dateutil python-scramp))
    (home-page "")
    (synopsis "PostgreSQL interface library")
    (description "@code{PostgreSQL} interface library")
    (license #f)))


(define-public python-pgsu
  (package
    (name "python-pgsu")
    (version "0.2.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pgsu" version))
       (sha256
        (base32 "1qy93rc6fygv62nfs3nhqpv8plka9ddpqk8hri01sm85jc3glz7v"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-click python-psycopg2-binary))
    (native-inputs (list python-pgtest python-pytest python-pytest-cov))
    (home-page "https://github.com/aiidateam/pgsu")
    (synopsis
     "Connect to an existing PostgreSQL cluster as a postgres superuser and execute SQL commands.")
    (description
     "Connect to an existing @code{PostgreSQL} cluster as a postgres superuser and
execute SQL commands.")
    (license license:expat)))


(define-public python-pgtest
  (package
    (name "python-pgtest")
    (version "1.3.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pgtest" version))
       (sha256
        (base32 "14gf0arjrax4pkq57dsfxsznf57gybwzrvwflpvfcsn4ypamxfzd"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
          (delete 'sanity-check) ; detects pg8000 0.0.0 where it is 1.30.5
        )
      )
    )
    (propagated-inputs (list python-pg8000))
    (home-page "https://github.com/jamesnunn/pgtest")
    (synopsis
     "Creates a temporary, local PostgreSQL database cluster and server for unittesting, and cleans up after itself")
    (description
     "This package creates a temporary, local @code{PostgreSQL} database cluster and
server for unittesting, and cleans up after itself")
    (license license:expat)))


(define-public python-plumpy
  (package
    (name "python-plumpy")
    (version "0.22.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "plumpy" version))
       (sha256
        (base32 "1i3jcfsb6396r0ka3qlcfqi7d1p9rax4lajfy2mkn5qg6vk4b3z5"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-importlib-metadata
                             python-importlib-resources
                             python-ipykernel
                             python-ipython
                             python-jinja2
                             python-kiwipy
                             python-markupsafe
                             python-mypy
                             python-nest-asyncio
                             python-pre-commit
                             python-pylint
                             python-pytest
                             python-pytest-asyncio
                             python-pytest-cov
                             python-pyyaml
                             python-shortuuid
                             python-sphinx
                             python-types-pyyaml))
    (home-page "")
    (synopsis "A Python workflow library.")
    (description "This package provides a Python workflow library.")
    (license #f)))


(define-public python-null
  (package
    (name "python-null")
    (version "0.6.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "null" version))
       (sha256
        (base32 "1vmfnrmpy7a90nzjyhsbhks1sz9605zm17qj9bad8ivcg8nbppkp"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-six))
    (home-page "https://bitbucket.org/ambv/null")
    (synopsis "Implements the null object pattern.")
    (description "This package implements the null object pattern.")
    (license license:expat)))


(define-public python-pycifrw
  (package
    (name "python-pycifrw")
    (version "4.4.6")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "PyCifRW" version))
       (sha256
        (base32 "05ggj4l9cir02m593azhl03wfjimx3rvwbznpx01bdqawxsmkgq2"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-numpy python-ply))
    (home-page
     "https://github.com/jamesrhester/pycifrw/blob/development/README.md")
    (synopsis "CIF/STAR file support for Python")
    (description "CIF/STAR file support for Python")
    (license #f)))


(define-public python-pymatgen
  (package
    (name "python-pymatgen")
    (version "2024.2.23")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pymatgen" version))
       (sha256
        (base32 "1sq8qg8lvi9a7gqlzk6jqwdx8wvvjj36raahnq4h4swdvwdlwxj8"))))
    (build-system pyproject-build-system) ; DB seaches for .c instead of .pyx (eg ./pymatgen/optimization/linear_assignment.pyx)
    (propagated-inputs (list python-joblib
                             python-matplotlib
                             python-monty
                             python-networkx
                             python-numpy
                             python-palettable
                             python-pandas
                             python-plotly
                             python-pybtex
                             python-requests
                             python-ruamel.yaml
                             python-scipy
                             spglib
                             python-sympy
                             python-tabulate
                             python-tqdm
                             python-uncertainties))
    (native-inputs (list  
                         python-mypy
                         python-pre-commit
                         python-pytest
                         python-pytest-cov
                         python-pytest-split
                         python-ruff))
    (home-page "https://pymatgen.org")
    (synopsis
     "Python Materials Genomics is a robust materials analysis code that defines core object representations for structures and molecules with support for many electronic structure codes. It is currently the core analysis code powering the Materials Project (https://materialsproject.org).")
    (description
     "Python Materials Genomics is a robust materials analysis code that defines core
object representations for structures and molecules with support for many
electronic structure codes.  It is currently the core analysis code powering the
Materials Project (https://materialsproject.org).")
    (license license:expat)))


(define-public python-seekpath
  (package
    (name "python-seekpath")
    (version "2.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "seekpath" version))
       (sha256
        (base32 "1i2jhjc4ikd31v8wkxzfrvhwlv0dlzpkysf3lkafcql2c9wwbkii"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-numpy spglib))
    (native-inputs (list python-black python-pre-commit python-prospector
                         python-pylint python-pytest))
    (home-page "http://github.com/giovannipizzi/seekpath")
    (synopsis
     "A module to obtain and visualize k-vector coefficients and obtain band paths in the Brillouin zone of crystal structures")
    (description
     "This package provides a module to obtain and visualize k-vector coefficients and
obtain band paths in the Brillouin zone of crystal structures")
    (license #f)))


(define-public python-sphinx-design
  (package
    (name "python-sphinx-design")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "sphinx_design" version))
       (sha256
        (base32 "005ba8rkfr8gjmimpd31wyw4bwjq8jalxcz3dmfd34kgxan17rg8"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list
                             python-myst-parser
                             python-pre-commit
                             python-pydata-sphinx-theme
                             python-pytest
                             python-pytest-cov
                             python-pytest-regressions
                             python-sphinx
                             python-sphinx-rtd-theme
                             python-poetry-core
                             python-flit-core))
    (home-page "")
    (synopsis
     "A sphinx extension for designing beautiful, view size responsive web components.")
    (description
     "This package provides a sphinx extension for designing beautiful, view size
responsive web components.")
    (license #f)))

(define-public python-sphinx-notfound-page
  (package
    (name "python-sphinx-notfound-page")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "sphinx_notfound_page" version))
       (sha256
        (base32 "0frspn1qwdhgwd702ijgkisqb3ggfqbz6kxb223xyp6yas4kik8l"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-sphinx
                             python-sphinx-rtd-theme
                             python-sphinx-tabs
                             python-sphinxemoji
                             python-tox
                             python-flit-core))
    (home-page "")
    (synopsis "Sphinx extension to build a 404 page with absolute URLs")
    (description "Sphinx extension to build a 404 page with absolute URLs")
    (license #f)))


(define-public python-sphinx-sqlalchemy
  (package
    (name "python-sphinx-sqlalchemy")
    (version "0.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "sphinx_sqlalchemy" version))
       (sha256
        (base32 "0c7g9ycdyzk34m5aw1zlxgkalb78kvy8ccnq5gm1d6n1b13nrh16"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list
                             python-pytest
                             python-pytest-cov
                             python-sphinx
                             python-sphinx-pytest
                             python-sqlalchemy2
                             python-syrupy
                             python-flit-core))
    (home-page "")
    (synopsis "Sphinx extension for documenting SQLAlchemy ORMs")
    (description "Sphinx extension for documenting SQLAlchemy ORMs")
    (license #f)))


(define-public python-trogon
  (package
    (name "python-trogon")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "trogon" version))
       (sha256
        (base32 "0ah4qpn02bicjg35cpkvjhv8xgk0d7s21l0wc287s8iq387pz9b1"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
          (delete 'sanity-check)
        )
      )
    )
    (propagated-inputs (list python-click python-textual python-poetry-core))
    (home-page "https://github.com/Textualize/trogon")
    (synopsis "Automatically generate a Textual TUI for your Click CLI")
    (description "Automatically generate a Textual TUI for your Click CLI")
    (license license:expat)))


(define-public python-types-pyyaml
  (package
    (name "python-types-pyyaml")
    (version "6.0.12.12")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "types-PyYAML" version))
       (sha256
        (base32 "0qjhhphqjql5xf9lbcb7472i1yl531kg3hzmbbwzvq7xjb9p6hrk"))))
    (build-system pyproject-build-system)
    (home-page "https://github.com/python/typeshed")
    (synopsis "Typing stubs for PyYAML")
    (description "Typing stubs for @code{PyYAML}")
    (license #f)))


(define-public python-upf-to-json
  (package
    (name "python-upf-to-json")
    (version "0.9.5")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "upf_to_json" version))
       (sha256
        (base32 "0jkfylsq4a1x7ljsbf058sc8fnzmnbflxkkr2qb4zw3phr64qqap"))))
    (build-system pyproject-build-system)
    (home-page "https://github.com/simonpintarelli/upf_to_json")
    (synopsis "upf to json converter")
    (description "upf to json converter")
    (license #f)))


(define-public python-aiormq
  (package
    (name "python-aiormq")
    (version "6.8.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "aiormq" version))
       (sha256
        (base32 "1yv639afdz8hshjkkpmins05ii3d4q39l28n214vrdzy61s9r3qr"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-pamqp python-setuptools python-yarl python-poetry-core))
    (home-page "https://github.com/mosquito/aiormq")
    (synopsis "Pure python AMQP asynchronous client library")
    (description "Pure python AMQP asynchronous client library")
    (license #f)))


(define-public python-pamqp
  (package
    (name "python-pamqp")
    (version "3.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pamqp" version))
       (sha256
        (base32 "0fvn0qms1mvz4qv7hl7lc1bnv89cs61xxh91i07jpkzgsidpkf20"))))
    (build-system pyproject-build-system)
    (native-inputs (list python-coverage
                         python-flake8
                         python-flake8-comprehensions
                         python-flake8-import-order
                         python-flake8-print
                         python-flake8-quotes
                         python-flake8-tuple
                         python-yapf))
    (home-page "https://github.com/gmr/pamqp")
    (synopsis "RabbitMQ Focused AMQP low-level library")
    (description "@code{RabbitMQ} Focused AMQP low-level library")
    (license #f)))


(define-public python-flake8-comprehensions
  (package
    (name "python-flake8-comprehensions")
    (version "3.14.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "flake8_comprehensions" version))
       (sha256
        (base32 "1ky0qqqw71zrraz991iqrc8dx5qdb2i0ipr2cahf2r60pxhqqxl1"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-flake8))
    (home-page "https://github.com/adamchainz/flake8-comprehensions")
    (synopsis
     "A flake8 plugin to help you write better list/set/dict comprehensions.")
    (description
     "This package provides a flake8 plugin to help you write better list/set/dict
comprehensions.")
    (license license:expat)))


(define-public python-flake8-import-order
  (package
    (name "python-flake8-import-order")
    (version "0.18.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "flake8-import-order" version))
       (sha256
        (base32 "03lh1n98lx8ncrr6n8cv5qj3birvqyqbpfhisw4hqgnsjbw42fg2"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-pycodestyle
                             python-setuptools))
    (home-page "https://github.com/PyCQA/flake8-import-order")
    (synopsis
     "Flake8 and pylama plugin that checks the ordering of import statements.")
    (description
     "Flake8 and pylama plugin that checks the ordering of import statements.")
    (license #f)))


(define-public python-flake8-tuple
  (package
    (name "python-flake8-tuple")
    (version "0.4.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "flake8_tuple" version))
       (sha256
        (base32 "07d6a4ccbndfj6ynbhgv365iagrnhgrsiihkxwzlrvrln6m446wa"))))
    (build-system pyproject-build-system)
        (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-flake8 python-six))
    (home-page "https://github.com/ar4s/flake8_tuple")
    (synopsis "Check code for 1 element tuple.")
    (description "Check code for 1 element tuple.")
    (license license:bsd-3)))


(define-public python-typing
  (package
    (name "python-typing")
    (version "3.10.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "typing" version))
       (sha256
        (base32 "0c5il4d68fd4qrm5k3dps70j0xz0n5krj6lhwn9vzpal3whsvd0k"))))
    (build-system pyproject-build-system)
    (home-page "https://docs.python.org/3/library/typing.html")
    (synopsis "Type Hints for Python")
    (description "Type Hints for Python")
    (license #f)))


(define-public python-profilehooks
  (package
    (name "python-profilehooks")
    (version "1.12.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "profilehooks" version))
       (sha256
        (base32 "18svg8r4hlnjga46805xax2gzky1ih0fdfh1sw7n734avy4pbf05"))))
    (build-system pyproject-build-system)
        (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (home-page "https://mg.pov.lt/profilehooks/")
    (synopsis "Decorators for profiling/timing/tracing individual functions")
    (description
     "Decorators for profiling/timing/tracing individual functions")
    (license license:expat)))


(define-public python-ablog
  (package
    (name "python-ablog")
    (version "0.11.6")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "ablog" version))
       (sha256
        (base32 "1yqaj3kl2dnmgnz5d25jm4q0yhqswnzl7kix4gp2max20vh1cpkx"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-docutils
                             python-feedgen
                             python-invoke
                             python-packaging
                             python-dateutil
                             python-sphinx
                             python-watchdog))
    (native-inputs (list python-alabaster
                         python-ipython
                         python-myst-parser
                         python-nbsphinx
                         python-pytest
                         python-sphinx-automodapi))
    (home-page "https://ablog.readthedocs.io/")
    (synopsis
     "A Sphinx extension that converts any documentation or personal website project into a full-fledged blog.")
    (description
     "This package provides a Sphinx extension that converts any documentation or
personal website project into a full-fledged blog.")
    (license license:expat)))


(define-public python-sphinx-examples
  (package
    (name "python-sphinx-examples")
    (version "0.0.5")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "sphinx-examples" version))
       (sha256
        (base32 "1x1zz7mckgigiqnc1zashwnppyx9f9i5y4ih175bd5yywsjp49sm"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list
                             python-myst-parser
                             python-sphinx
                             python-sphinx-copybutton
                             python-sphinx-design
                             python-sphinx-rtd-theme))
    (home-page "")
    (synopsis
     "A lightweight example directive to make it easy to demonstrate code / results.")
    (description
     "This package provides a lightweight example directive to make it easy to
demonstrate code / results.")
    (license #f)))

(define-public python-sphinx-thebe
  (package
    (name "python-sphinx-thebe")
    (version "0.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "sphinx_thebe" version))
       (sha256
        (base32 "14x44n721gb5i8d573sv3kzdr55h3q5j05azm9j2zs30aps4fq2p"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-sphinx))
    (native-inputs (list python-beautifulsoup4
                         python-matplotlib
                         python-pytest
                         python-pytest-regressions
                         python-sphinx-copybutton
                         python-sphinx-design
                         python-sphinx-thebe))
    (home-page "")
    (synopsis
     "Integrate interactive code blocks into your documentation with Thebe and Binder.")
    (description
     "Integrate interactive code blocks into your documentation with Thebe and Binder.")
    (license #f)))


(define-public python-sphinx-togglebutton
  (package
    (name "python-sphinx-togglebutton")
    (version "0.3.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "sphinx-togglebutton" version))
       (sha256
        (base32 "0ynwb4jl982gqchxa4lxdvx2gi3jhh3msbc0i561xc17chv8n35b"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-docutils python-setuptools python-sphinx
                             python-wheel))
    (home-page "https://github.com/executablebooks/sphinx-togglebutton")
    (synopsis "Toggle page content and collapse admonitions in Sphinx.")
    (description "Toggle page content and collapse admonitions in Sphinx.")
    (license license:expat)))



(define-public python-feedgen
  (package
    (name "python-feedgen")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "feedgen" version))
       (sha256
        (base32 "0sjljdip5ffkwphqh49irhprywic9n671hwq56js4mp9np1m3gfr"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-lxml python-dateutil))
    (home-page "https://lkiesow.github.io/python-feedgen")
    (synopsis "Feed Generator (ATOM, RSS, Podcasts)")
    (description "Feed Generator (ATOM, RSS, Podcasts)")
    (license #f)))


(define-public python-alabaster
  (package
    (name "python-alabaster")
    (version "0.7.16")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "alabaster" version))
       (sha256
        (base32 "0rcdsl333jjwrb8m77nsj8wdn78jg92dvk7qsw6xbnm552fbka3m"))))
    (build-system pyproject-build-system)
    (home-page "")
    (synopsis "A light, configurable Sphinx theme")
    (description "This package provides a light, configurable Sphinx theme")
    (license #f)))


(define-public python-sphinx-automodapi
  (package
    (name "python-sphinx-automodapi")
    (version "0.17.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "sphinx-automodapi" version))
       (sha256
        (base32 "1893qiaq7sjn25dp7d4009cqp3wcy9fbpwnr968smm5daynsvkbw"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-sphinx))
    (native-inputs (list python-coverage python-cython python-pytest
                         python-pytest-cov python-setuptools))
    (home-page "https://github.com/astropy/sphinx-automodapi")
    (synopsis
     "Sphinx extension for auto-generating API documentation for entire modules")
    (description
     "Sphinx extension for auto-generating API documentation for entire modules")
    (license #f)))


(define-public python-coconut
  (package
    (name "python-coconut")
    (version "3.0.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "coconut" version))
       (sha256
        (base32 "12nrxv73v9rzwyzlqqaqa431m9yd5vspnqnc2na51kz6j4phjvqh"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-aenum
                             python-anyio
                             python-async-generator
                             python-backports.functools-lru-cache
                             python-cpyparsing
                             python-dataclasses
                             python-exceptiongroup
                             python-futures
                             python-prompt-toolkit
                             python-psutil
                             python-pygments
                             python-pyparsing
                             python-setuptools
                             python-trollius
                             python-typing
                             python-typing-extensions))
    (native-inputs (list python-ipykernel
                         python-ipython
                         python-jedi
                         python-jupyter
                         python-jupyter-client
                         python-jupyter-console
                         python-jupyterlab
                         python-jupytext
                         python-mypy
                         python-myst-parser
                         python-numpy
                         python-pandas
                         python-papermill
                         python-pexpect
                         python-pre-commit
                         python-pydata-sphinx-theme
                         python-pygments
                         python-pyparsing
                         python-pytest
                         python-pywinpty
                         python-requests
                         python-sphinx
                         python-types-backports
                         python-typing
                         python-vprof
                         python-watchdog))
    (home-page "http://coconut-lang.org")
    (synopsis "Simple, elegant, Pythonic functional programming.")
    (description "Simple, elegant, Pythonic functional programming.")
    (license license:asl2.0)))


(define-public python-backports.functools-lru-cache
  (package
    (name "python-backports.functools-lru-cache")
    (version "2.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "backports.functools_lru_cache" version))
       (sha256
        (base32 "16bggzq8n97xg3xw2xmgylfxgsiysckf1j87i0b19878vbhabgyw"))))
    (build-system pyproject-build-system)
    (native-inputs (list python-pytest
                         python-pytest-black
                         python-pytest-checkdocs
                         python-pytest-cov
                         python-pytest-enabler
                         python-pytest-mypy
                         python-pytest-ruff))
    (home-page "https://github.com/jaraco/backports.functools_lru_cache")
    (synopsis "Backport of functools.lru_cache")
    (description "Backport of functools.lru_cache")
    (license #f)))


(define-public python-cpyparsing
  (package
    (name "python-cpyparsing")
    (version "2.4.7.2.3.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "cPyparsing" version))
       (sha256
        (base32 "14j63ahzl5fg4qfqbb9cczq1v15ppbzjik61g9qxqr3y1xw6lv3l"))))
    (build-system pyproject-build-system)
    (home-page "https://github.com/evhub/cpyparsing")
    (synopsis "Cython implementation of PyParsing for use in Coconut.")
    (description
     "Cython implementation of @code{PyParsing} for use in Coconut.")
    (license #f)))


(define-public python-futures
  (package
    (name "python-futures")
    (version "3.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "futures" version))
       (sha256
        (base32 "1lpx31mgbdh911wf89z4bm04aqiadf6xph9rfnm4fmdqs7ncxj1y"))))
    (build-system pyproject-build-system)
    (home-page "https://github.com/agronholm/pythonfutures")
    (synopsis "Backport of the concurrent.futures package from Python 3")
    (description "Backport of the concurrent.futures package from Python 3")
    (license #f)))


(define-public python-trollius
  (package
    (name "python-trollius")
    (version "2.2.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "trollius" version))
       (sha256
        (base32 "1jhhqgay8ylaf3lrjwjgp2v08lbgn0xvjx896a9k52f5h17bj9g5"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-futures python-six))
    (home-page "https://github.com/jamadden/trollius")
    (synopsis
     "Deprecated, unmaintained port of the asyncio module (PEP 3156) on Python 2")
    (description
     "Deprecated, unmaintained port of the asyncio module (PEP 3156) on Python 2")
    (license #f)))


(define-public python-jupyterlab
  (package
    (name "python-jupyterlab")
    (version "4.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "jupyterlab" version))
       (sha256
        (base32 "1yc5916bzqy8vym5fs2qydbiy2zbnvgvf8gnk4a1i1a0xnrlhqsx"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-async-lru
                             python-httpx
                             python-importlib-metadata
                             python-importlib-resources
                             python-ipykernel
                             python-jinja2
                             python-jupyter-core
                             python-jupyter-lsp
                             python-jupyter-server
                             python-jupyterlab-server
                             python-notebook-shim
                             python-packaging
                             python-tomli
                             python-tornado
                             python-traitlets))
    (native-inputs (list python-build
                         python-bump2version
                         python-coverage
                         python-hatch
                         python-pre-commit
                         python-pytest
                         python-pytest-check-links
                         python-pytest-console-scripts
                         python-pytest-cov
                         python-pytest-jupyter
                         python-pytest-timeout
                         python-pytest-tornasync
                         python-requests
                         python-requests-cache
                         python-ruff
                         python-virtualenv))
    (home-page "")
    (synopsis "JupyterLab computational environment")
    (description "@code{JupyterLab} computational environment")
    (license #f)))


(define-public python-papermill
  (package
    (name "python-papermill")
    (version "2.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "papermill" version))
       (sha256
        (base32 "0wkc13kcaw3q7qvibc58429nkk8jf3hwb77sn28zwmizap070yza"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-aiohttp
                             python-click
                             python-entrypoints
                             python-nbclient
                             python-nbformat
                             python-pyyaml
                             python-requests
                             python-tenacity
                             python-tqdm))
    (native-inputs (list python-attrs
                         python-azure-datalake-store
                         python-azure-identity
                         python-azure-storage-blob
                         python-black
                         python-boto3
                         python-botocore
                         python-bumpversion
                         python-check-manifest
                         python-codecov
                         python-coverage
                         python-flake8
                         python-gcsfs
                         python-google-compute-engine
                         python-ipython
                         python-ipywidgets
                         python-moto
                         python-notebook
                         python-pip
                         python-pre-commit
                         python-pytest
                         python-pytest-cov
                         python-pytest-env
                         python-pytest-mock
                         python-recommonmark
                         python-requests
                         python-setuptools
                         python-tox
                         python-twine
                         python-wheel))
    (home-page "https://github.com/nteract/papermill")
    (synopsis "Parameterize and run Jupyter and nteract Notebooks")
    (description "Parameterize and run Jupyter and nteract Notebooks")
    (license license:bsd-3)))




(define-public python-pywinpty
  (package
    (name "python-pywinpty")
    (version "2.0.13")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pywinpty" version))
       (sha256
        (base32 "1phxyja9bsm3fb9i9j2azqr0v1jwhdzx48yssz8ds4rk38sk4kn3"))))
    (build-system pyproject-build-system)
    (home-page "")
    (synopsis "Pseudo terminal support for Windows from Python.")
    (description "Pseudo terminal support for Windows from Python.")
    (license license:expat)))


(define-public python-types-backports
  (package
    (name "python-types-backports")
    (version "0.1.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "types-backports" version))
       (sha256
        (base32 "1kqh00najbvvff4v4vx6rmhgv1b1a0kks7l901i8vy1x0xn21dzl"))))
    (build-system pyproject-build-system)
    (home-page "https://github.com/python/typeshed")
    (synopsis "Typing stubs for backports")
    (description "Typing stubs for backports")
    (license #f)))


(define-public python-vprof
  (package
    (name "python-vprof")
    (version "0.38")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "vprof" version))
       (sha256
        (base32 "1nzs1za7b8891g6apm81zz85mx4sffbcrlwlgh64aypb5s8h043z"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-psutil))
    (home-page "http://github.com/nvdv/vprof")
    (synopsis "Visual profiler for Python")
    (description "Visual profiler for Python")
    (license license:bsd-3)))


(define-public python-async-lru
  (package
    (name "python-async-lru")
    (version "2.0.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "async-lru" version))
       (sha256
        (base32 "09sn3bc3gc2flijm9k8kn4hmbnlkaddhqahb49izy188yrfrm9dq"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-typing-extensions))
    (home-page "https://github.com/aio-libs/async-lru")
    (synopsis "Simple LRU cache for asyncio")
    (description "Simple LRU cache for asyncio")
    (license license:expat)))


(define-public python-jupyter-lsp
  (package
    (name "python-jupyter-lsp")
    (version "2.2.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "jupyter-lsp" version))
       (sha256
        (base32 "0grcgm6m1r8gc9yrbm5qdhqwv7v8yi7v15mnr3spy8r4vz2wpnrk"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-importlib-metadata python-jupyter-server))
    (home-page "")
    (synopsis
     "Multi-Language Server WebSocket proxy for Jupyter Notebook/Lab server")
    (description
     "Multi-Language Server @code{WebSocket} proxy for Jupyter Notebook/Lab server")
    (license #f)))


(define-public python-notebook-shim
  (package
    (name "python-notebook-shim")
    (version "0.2.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "notebook_shim" version))
       (sha256
        (base32 "1jrqqrm5xjwsx13plyyh7wybb1g71yrzaqa3l9y3162xnshwzcml"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-jupyter-server))
    (native-inputs (list python-pytest python-pytest-console-scripts
                         python-pytest-jupyter python-pytest-tornasync))
    (home-page "")
    (synopsis "A shim layer for notebook traits and config")
    (description
     "This package provides a shim layer for notebook traits and config")
    (license #f)))


(define-public python-hatch
  (package
    (name "python-hatch")
    (version "1.9.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "hatch" version))
       (sha256
        (base32 "1ngqpmr7jhm88n73f1s3k652rz4c5ymfkzm5aylzhj6597iif837"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-click
                             python-hatchling
                             python-httpx
                             python-hyperlink
                             python-keyring
                             python-packaging
                             python-pexpect
                             python-platformdirs
                             python-rich
                             python-shellingham
                             python-tomli-w
                             python-tomlkit
                             python-userpath
                             python-virtualenv
                             python-zstandard))
    (home-page "")
    (synopsis "Modern, extensible Python project management")
    (description "Modern, extensible Python project management")
    (license #f)))


(define-public python-pytest-jupyter
  (package
    (name "python-pytest-jupyter")
    (version "0.9.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pytest_jupyter" version))
       (sha256
        (base32 "1nmylmh5wc4g4ixzjv7hhlby3cxabx5nx5wgb70mjs8nd8lz9gc8"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-jupyter-core python-pytest))
    (native-inputs (list python-pytest-timeout))
    (home-page "")
    (synopsis "A pytest plugin for testing Jupyter libraries and extensions.")
    (description
     "This package provides a pytest plugin for testing Jupyter libraries and
extensions.")
    (license #f)))


(define-public python-requests-cache
  (package
    (name "python-requests-cache")
    (version "1.2.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "requests_cache" version))
       (sha256
        (base32 "0f1qbs48qlyvc03h99h64g8fxv4qf8wabcf8nvairk23lff7076v"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-attrs
                             python-boto3
                             python-botocore
                             python-bson
                             python-cattrs
                             python-itsdangerous
                             python-linkify-it-py
                             python-myst-parser
                             python-platformdirs
                             python-pymongo
                             python-pyyaml
                             python-redis
                             python-requests
                             python-sphinx
                             python-sphinx-autodoc-typehints
                             python-sphinx-automodapi
                             python-sphinx-copybutton
                             python-sphinx-design
                             python-sphinx-notfound-page
                             python-sphinxcontrib-apidoc
                             python-sphinxext-opengraph
                             python-ujson
                             python-url-normalize
                             python-urllib3))
    (home-page "https://github.com/requests-cache/requests-cache")
    (synopsis "A persistent cache for python requests")
    (description
     "This package provides a persistent cache for python requests")
    (license license:bsd-2)))


(define-public python-ruff
  (package
    (name "python-ruff")
    (version "0.2.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "ruff" version))
       (sha256
        (base32 "07dkrixjy0jqchkj3mgshv26nw6dfi1a34wilc5s6s1hdgrxfbp6"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
          (delete 'build)
          (delete 'install)
        )
      )
    )
    ; (native-inputs (list maturin))
    (home-page "https://docs.astral.sh/ruff")
    (synopsis
     "An extremely fast Python linter and code formatter, written in Rust.")
    (description
     "An extremely fast Python linter and code formatter, written in Rust.")
    (license license:expat)))


(define-public python-userpath
  (package
    (name "python-userpath")
    (version "1.9.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "userpath" version))
       (sha256
        (base32 "15i7w1sh60f7i23rqls72s6rdkgw4cxvz08p82v19jcqimr7d0ff"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-click))
    (home-page "")
    (synopsis "Cross-platform tool for adding locations to the user PATH")
    (description "Cross-platform tool for adding locations to the user PATH")
    (license #f)))


(define-public python-url-normalize
  (package
    (name "python-url-normalize")
    (version "1.4.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "url-normalize" version))
       (sha256
        (base32 "1clrr7xc1qlxph0v90w7ag6x2246izka0n8w7aw6fan5183klgfj"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-six))
    (home-page "https://github.com/niksite/url-normalize")
    (synopsis "URL normalization for Python")
    (description "URL normalization for Python")
    (license license:expat)))


(define-public python-pandoc
  (package
    (name "python-pandoc")
    (version "2.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pandoc" version))
       (sha256
        (base32 "03grms5s249sdd51vry79yv8wlzx3spxna4qaya6h53iv33c4wp7"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-plumbum python-ply))
    (home-page "")
    (synopsis "Pandoc Documents for Python")
    (description "Pandoc Documents for Python")
    (license license:expat)))


(define-public python-pytray
  (package
    (name "python-pytray")
    (version "0.3.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pytray" version))
       (sha256
        (base32 "1g4wlhfyzi18pi0fjcn9lx2qs3aghjnx732zgyqvjkjgv9caiyam"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-deprecation))
    (native-inputs (list python-grayskull
                         python-ipython
                         python-pip
                         python-pre-commit
                         python-pytest
                         python-pytest-cov
                         python-twine))
    (home-page "https://github.com/muhrin/pytray.git")
    (synopsis "A python tools library for baking pies")
    (description
     "This package provides a python tools library for baking pies")
    (license #f)))


(define-public python-sphinxemoji
  (package
    (name "python-sphinxemoji")
    (version "0.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "sphinxemoji" version))
       (sha256
        (base32 "049vvabhlilis7gs264sgkcwx0fsny357d43j3j96lvn3qgzzv13"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-sphinx))
    (home-page "")
    (synopsis "An extension to use emoji codes in your Sphinx documentation")
    (description
     "An extension to use emoji codes in your Sphinx documentation")
    (license #f)))


(define-public python-azure-datalake-store
  (package
    (name "python-azure-datalake-store")
    (version "0.0.53")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "azure-datalake-store" version))
       (sha256
        (base32 "14vkfmsrihab6byf5z3ggwz0r01bg4xr7rj1d5p0laizxridxdh5"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-azure-nspkg
                             python-cffi
                             python-futures
                             python-msal
                             python-pathlib2
                             python-requests))
    (home-page "https://github.com/Azure/azure-data-lake-store-python")
    (synopsis "Azure Data Lake Store Filesystem Client Library for Python")
    (description "Azure Data Lake Store Filesystem Client Library for Python")
    (license license:expat)))


(define-public python-azure-identity
  (package
    (name "python-azure-identity")
    (version "1.15.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "azure-identity" version))
       (sha256
        (base32 "1j17qbkb5b3z6nchwjrxl8cx10qijdjis9mm1rhnb4kzdcjgqa2c"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-azure-core python-cryptography python-msal
                             python-msal-extensions))
    (home-page
     "https://github.com/Azure/azure-sdk-for-python/tree/main/sdk/identity/azure-identity")
    (synopsis "Microsoft Azure Identity Library for Python")
    (description "Microsoft Azure Identity Library for Python")
    (license license:expat)))


(define-public python-gcsfs
  (package
    (name "python-gcsfs")
    (version "2024.2.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "gcsfs" version))
       (sha256
        (base32 "01pm14aib9n308cnrw2ra1dh9gljjzpqlgw8xxb0rd9gmrygvkzp"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-aiohttp
                             python-decorator
                             python-fsspec
                             python-google-auth
                             python-google-auth-oauthlib
                             python-google-cloud-storage
                             python-requests))
    (home-page "https://github.com/fsspec/gcsfs")
    (synopsis "Convenient Filesystem interface over GCS")
    (description "Convenient Filesystem interface over GCS")
    (license license:bsd-3)))


(define-public python-google-compute-engine
  (package
    (name "python-google-compute-engine")
    (version "2.8.13")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "google-compute-engine" version))
       (sha256
        (base32 "19zvgk7sf12wlg5dka3gak0x5k9ja48dgyccqyx91y3906hn70rm"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-boto python-distro python-setuptools))
    (home-page "https://github.com/GoogleCloudPlatform/compute-image-packages")
    (synopsis "Google Compute Engine")
    (description "Google Compute Engine")
    (license #f)))


(define-public python-msal-extensions
  (package
    (name "python-msal-extensions")
    (version "1.1.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "msal-extensions" version))
       (sha256
        (base32 "0lj2qp8w25s33r6xa23kxsh92y0w85nxzlhb7ljppnv2f235gcva"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-msal python-packaging python-portalocker))
    (home-page "")
    (synopsis
     "Microsoft Authentication Library extensions (MSAL EX) provides a persistence API that can save your data on disk, encrypted on Windows, macOS and Linux. Concurrent data access will be coordinated by a file lock mechanism.")
    (description
     "Microsoft Authentication Library extensions (MSAL EX) provides a persistence API
that can save your data on disk, encrypted on Windows, @code{macOS} and Linux.
Concurrent data access will be coordinated by a file lock mechanism.")
    (license license:expat)))


(define-public python-re-ver
  (package
    (name "python-re-ver")
    (version "0.5.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "re-ver" version))
       (sha256
        (base32 "1aqqnb5851m6acy8fwg3qqwpxc5hyd51cm0mp83i6nyvychmygr7"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-github3.py python-lazyasd
                             python-ruamel.yaml))
    (home-page "https://github.com/scopatz/rever")
    (synopsis "Release Versions of Software")
    (description "Release Versions of Software")
    (license license:bsd-3)))


(define-public python-changelogd
  (package
    (name "python-changelogd")
    (version "0.1.8")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "changelogd" version))
       (sha256
        (base32 "17zk88sv7d24dkcjflq75qbk4ikcs31q60x6f0g0ikmqhzmzanry"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-click python-jinja2 python-ruamel.yaml
                             python-toml))
    (native-inputs (list python-bump2version
                         python-flake8
                         python-mypy
                         python-nox
                         python-pyfakefs
                         python-pytest
                         python-wheel))
    (home-page "https://github.com/aklajnert/changelogd")
    (synopsis "Changelogs without conflicts.")
    (description "Changelogs without conflicts.")
    (license license:expat)))


(define-public python-github3.py
  (package
    (name "python-github3.py")
    (version "4.0.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "github3.py" version))
       (sha256
        (base32 "0dnxbps444wvygani2adnljcnkwa6gpsmyf7xn4w7vskcw3p3m9h"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-pyjwt python-dateutil python-requests
                             python-uritemplate))
    (native-inputs (list python-betamax
                         python-betamax-matchers
                         python-build
                         python-pytest
                         python-pytest-xdist
                         python-tox
                         python-twine
                         python-wheel))
    (home-page "")
    (synopsis
     "Python wrapper for the GitHub API(http://developer.github.com/v3)")
    (description
     "Python wrapper for the @code{GitHub} API(http://developer.github.com/v3)")
    (license #f)))


(define-public python-lazyasd
  (package
    (name "python-lazyasd")
    (version "0.1.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "lazyasd" version))
       (sha256
        (base32 "0nqlvg1jjwl8l5g3zcl99vmb8r6mbxryarsps0m9azzjrw2ny6d3"))))
    (build-system pyproject-build-system)
    (home-page "https://github.com/xonsh/lazyasd")
    (synopsis "Lazy & self-destructive tools for speeding up module imports")
    (description
     "Lazy & self-destructive tools for speeding up module imports")
    (license #f)))


(define-public python-pytest-ruff
  (package
    (name "python-pytest-ruff")
    (version "0.2.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pytest_ruff" version))
       (sha256
        (base32 "1p550fx1d3qdcs8n1w6pf6hza1y8bv6gkm0yk5kb8ix3pybdd2h7"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-ruff))
    (home-page "")
    (synopsis "pytest plugin to check ruff requirements.")
    (description "pytest plugin to check ruff requirements.")
    (license #f)))


(define-public python-grayskull
  (package
    (name "python-grayskull")
    (version "2.5.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "grayskull" version))
       (sha256
        (base32 "1c9l0kjj6rrk7fmb9cblrm6f59l8qqr0m8mf01nlh31bzrvd90hs"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-beautifulsoup4
                             python-colorama
                             python-conda-souschef
                             python-packaging
                             python-pip
                             python-pkginfo
                             python-progressbar2
                             python-rapidfuzz
                             python-requests
                             python-ruamel.yaml
                             python-ruamel.yaml.jinja2
                             python-semver
                             python-setuptools
                             python-stdlib-list
                             python-tomli
                             python-tomli-w))
    (native-inputs (list python-mock
                         python-pytest
                         python-pytest-console-scripts
                         python-pytest-cov
                         python-pytest-mock
                         python-setuptools-scm))
    (home-page "")
    (synopsis "Project to generate recipes for conda packages")
    (description "Project to generate recipes for conda packages")
    (license #f)))


(define-public python-conda-souschef
  (package
    (name "python-conda-souschef")
    (version "2.2.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "conda-souschef" version))
       (sha256
        (base32 "1hy076wsymilkpnqc76ia8i5i46dfm5av03bccb7djbbcyhdpwwv"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-ruamel.yaml python-ruamel.yaml.jinja2))
    (native-inputs (list python-mock python-pytest python-pytest-cov))
    (home-page "https://github.com/marcelotrevisani/souschef")
    (synopsis "Project to handle conda recipes")
    (description "Project to handle conda recipes")
    (license #f)))


(define-public python-rapidfuzz
  (package
    (name "python-rapidfuzz")
    (version "3.6.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "rapidfuzz" version))
       (sha256
        (base32 "1rrx043zqqql31pcp92k61digibymp3l382gaxr4h8717kp0nrim"))))
    (build-system pyproject-build-system)
    (native-inputs (list python-backend))
    (home-page "https://github.com/rapidfuzz/RapidFuzz")
    (synopsis "rapid fuzzy string matching")
    (description "rapid fuzzy string matching")
    (license license:expat)))


(define-public python-ruamel.yaml.jinja2
  (package
    (name "python-ruamel.yaml.jinja2")
    (version "0.2.7")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "ruamel.yaml.jinja2" version))
       (sha256
        (base32 "0qz6nganzdxb1qgb59iq1ngld3ki3lbdr2k4s69glmx1v4lvwjc4"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-ruamel.yaml))
    (home-page
     "https://sourceforge.net/p/ruamel-yaml-jinja2/code/ci/default/tree")
    (synopsis "jinja2 pre and post-processor to update with YAML")
    (description "jinja2 pre and post-processor to update with YAML")
    (license license:expat)))


(define-public python-scramp
  (package
    (name "python-scramp")
    (version "1.4.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "scramp" version))
       (sha256
        (base32 "1g2rbml9z6xqi429a5xr0yl8flnhgs8mf9mbcgw3rws000a2l0mp"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-asn1crypto python-importlib-metadata))
    (home-page "")
    (synopsis "An implementation of the SCRAM protocol.")
    (description "An implementation of the SCRAM protocol.")
    (license #f)))


(define-public python-monty
  (package
    (name "python-monty")
    (version "2024.2.26")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "monty" version))
       (sha256
        (base32 "1dlrd30nw6q2c6q7ljxa3sipqg8hqv2rcrk31261765x7cvd9h53"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (home-page "")
    (synopsis "Monty is the missing complement to Python.")
    (description "Monty is the missing complement to Python.")
    (license #f)))


(define-public python-pytest-split
  (package
    (name "python-pytest-split")
    (version "0.8.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pytest_split" version))
       (sha256
        (base32 "0by0a2zqp5z2mdsndj1xv20alglvgp15h446yckj0mq76q736vs4"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-pytest python-poetry-core))
    (home-page "https://jerry-git.github.io/pytest-split")
    (synopsis
     "Pytest plugin which splits the test suite to equally sized sub suites based on test execution time.")
    (description
     "Pytest plugin which splits the test suite to equally sized sub suites based on
test execution time.")
    (license license:expat)))


(define-public python-sphinx-autodoc2
  (package
    (name "python-sphinx-autodoc2")
    (version "0.5.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "sphinx_autodoc2" version))
       (sha256
        (base32 "0njnnqshg0fzimg87p2fhxkb0zlchsv840888x2gfshxm1508xkx"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-astroid
                             python-myst-parser
                             python-pytest
                             python-pytest-cov
                             python-pytest-regressions
                             python-sphinx
                             python-tomli
                             python-typer
                             python-typing-extensions
                             python-flit-core))
    (home-page "")
    (synopsis "Analyse a python project and create documentation for it.")
    (description "Analyse a python project and create documentation for it.")
    (license #f)))

(define-public python-pybtex-docutils
  (package
    (name "python-pybtex-docutils")
    (version "1.0.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pybtex-docutils" version))
       (sha256
        (base32 "0srwv58lv5ncb9qj8493hhnxk9dw42dalf65q7l00gjr5gwvszis"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-docutils python-pybtex))
    (home-page "https://github.com/mcmtroffaes/pybtex-docutils")
    (synopsis "A docutils backend for pybtex.")
    (description "This package provides a docutils backend for pybtex.")
    (license license:expat)))


(define-public python-prospector
  (package
    (name "python-prospector")
    (version "1.10.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "prospector" version))
       (sha256
        (base32 "0jknkn62ic4d9p7r40mmv7nwzlh6fkvilxlh8jrrx1ihsjgv36pj"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-bandit
                             python-dodgy
                             python-flake8
                             python-gitpython
                             python-mccabe
                             python-mypy
                             python-packaging
                             python-pep8-naming
                             python-pycodestyle
                             python-pydocstyle
                             python-pyflakes
                             python-pylint
                             python-pylint-celery
                             python-pylint-django
                             python-pylint-flask
                             python-pylint-plugin-utils
                             python-pyright
                             python-pyyaml
                             python-requirements-detector
                             python-setoptconf-tmp
                             python-toml
                             python-vulture))
    (home-page "http://prospector.readthedocs.io")
    (synopsis
     "Prospector is a tool to analyse Python code by aggregating the result of other tools.")
    (description
     "Prospector is a tool to analyse Python code by aggregating the result of other
tools.")
    (license #f)))


(define-public python-dodgy
  (package
    (name "python-dodgy")
    (version "0.2.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "dodgy" version))
       (sha256
        (base32 "0fkcz149n3ypa6xcnf24qyd0xk15ycbzl5nksgykj89mr6zkqci8"))))
    (build-system pyproject-build-system)
    (home-page "https://github.com/landscapeio/dodgy")
    (synopsis "Dodgy: Searches for dodgy looking lines in Python code")
    (description "Dodgy: Searches for dodgy looking lines in Python code")
    (license license:expat)))


(define-public python-pylint-celery
  (package
    (name "python-pylint-celery")
    (version "0.3")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pylint-celery" version))
       (sha256
        (base32 "1ssbvvhvsday5iqkzy76vgdywjsjvllai3hp8k01b3a0wya21qs1"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-astroid python-pylint
                             python-pylint-plugin-utils))
    (home-page "https://github.com/landscapeio/pylint-celery")
    (synopsis
     "pylint-celery is a Pylint plugin to aid Pylint in recognising and understandingerrors caused when using the Celery library")
    (description
     "pylint-celery is a Pylint plugin to aid Pylint in recognising and
understandingerrors caused when using the Celery library")
    (license #f)))


(define-public python-pylint-django
  (package
    (name "python-pylint-django")
    (version "2.5.5")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pylint_django" version))
       (sha256
        (base32 "16xspdd8pj3axx8q47ggsldwj03pqcwm2p1rhf19axjpym5rwcrg"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-django python-pylint
                             python-pylint-plugin-utils))
    (home-page "https://github.com/PyCQA/pylint-django")
    (synopsis
     "A Pylint plugin to help Pylint understand the Django web framework")
    (description
     "This package provides a Pylint plugin to help Pylint understand the Django web
framework")
    (license #f)))


(define-public python-pylint-flask
  (package
    (name "python-pylint-flask")
    (version "0.6")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pylint-flask" version))
       (sha256
        (base32 "05qmwgkpvaa5k05abqjxfbrfk3wpdqb8ph690z7bzxvb47i7vngl"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-astroid python-pylint python-pylint-plugin-utils))
    (home-page "https://github.com/jschaf/pylint-flask")
    (synopsis
     "pylint-flask is a Pylint plugin to aid Pylint in recognizing and understanding errors caused when using Flask")
    (description
     "pylint-flask is a Pylint plugin to aid Pylint in recognizing and understanding
errors caused when using Flask")
    (license #f)))


(define-public python-pylint-plugin-utils
  (package
    (name "python-pylint-plugin-utils")
    (version "0.8.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pylint_plugin_utils" version))
       (sha256
        (base32 "1r4kxqz6rhjc9idkxc61sj316mv2alahjf477aigp8wbldlbzknk"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-pylint python-poetry-core python-tomli))
    (home-page "https://github.com/PyCQA/pylint-plugin-utils")
    (synopsis "Utilities and helpers for writing Pylint plugins")
    (description "Utilities and helpers for writing Pylint plugins")
    (license #f)))


(define-public python-pyright
  (package
    (name "python-pyright")
    (version "1.1.352")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pyright" version))
       (sha256
        (base32 "1a89h5p48fzilyra34183071vapg1ww0f6k420v1nagipkgw08d6"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-nodeenv1.8 python-typing-extensions))
    (native-inputs (list python-twine))
    (home-page "https://github.com/RobertCraigie/pyright-python")
    (synopsis "Command line wrapper for pyright")
    (description "Command line wrapper for pyright")
    (license license:expat)))


(define-public python-requirements-detector
  (package
    (name "python-requirements-detector")
    (version "1.2.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "requirements_detector" version))
       (sha256
        (base32 "0085l5fm30msnazl43if5n8bvniarz57xfrndi9pj796bdxcshin"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-astroid python-packaging python-semver3
                             python-toml python-poetry-core))
    (home-page "https://github.com/landscapeio/requirements-detector")
    (synopsis "Python tool to find and list requirements of a Python project")
    (description
     "Python tool to find and list requirements of a Python project")
    (license license:expat)))


(define-public python-setoptconf-tmp
  (package
    (name "python-setoptconf-tmp")
    (version "0.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "setoptconf-tmp" version))
       (sha256
        (base32 "0y2pgpraa36wzlzkxigvmz80mqd3mzcc9wv2yx9bliqks7fhlj70"))))
    (build-system pyproject-build-system)
    (home-page "https://github.com/carlio/setoptconf-tmp")
    (synopsis
     "A module for retrieving program settings from various sources in a consistant method.")
    (description
     "This package provides a module for retrieving program settings from various
sources in a consistant method.")
    (license license:expat)))


(define-public python-syrupy
  (package
    (name "python-syrupy")
    (version "4.6.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "syrupy" version))
       (sha256
        (base32 "0dmvw4c3yjs0rssbwsmw2nbcpcqhbs44a8fnhvpywmvqrv4kba1p"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-pytest python-poetry-core))
    (home-page "https://github.com/tophat/syrupy")
    (synopsis "Pytest Snapshot Test Utility")
    (description "Pytest Snapshot Test Utility")
    (license #f)))

(define-public python-flit-core
  (package
    (name "python-flit-core")
    (version "3.9.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "flit_core" version))
       (sha256
        (base32 "1fkfg35midikhylyj32p8098anb0i5v0v4zjnpxgr8y4frhjdbbj"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (home-page "")
    (synopsis
     "Distribution-building parts of Flit. See flit package for more information")
    (description
     "Distribution-building parts of Flit.  See flit package for more information")
    (license #f)))

(define-public python-sphinx-theme-builder
  (package
    (name "python-sphinx-theme-builder")
    (version "0.2.0b2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "sphinx-theme-builder" version))
       (sha256
        (base32 "127jls164jnbd9hczzyi1040zhfw7h29lii1wx7l3grmpg19ikg9"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-build
                             python-click
                             python-nodeenv
                             python-packaging
                             python-pyproject-metadata
                             python-rich
                             python-setuptools
                             python-sphinx-autobuild
                             python-tomli
                             python-typing-extensions))
    (home-page "")
    (synopsis
     "A tool for authoring Sphinx themes with a simple (opinionated) workflow.")
    (description
     "This package provides a tool for authoring Sphinx themes with a simple
(opinionated) workflow.")
    (license #f)))


(define-public python-nodeenv1.8
  (package
    (name "python-nodeenv1.8")
    (version "1.8.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "nodeenv" version))
       (sha256
        (base32 "1li7c92wb0387dnnz37fgrnq6n5vrm2k3b7y2z84ggsgwqvhq7nm"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-setuptools))
    (home-page "https://github.com/ekalinin/nodeenv")
    (synopsis "Node.js virtual environment builder")
    (description "Node.js virtual environment builder")
    (license license:bsd-3)))


(define-public python-backend
  (package
    (name "python-backend")
    (version "0.2.4.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "backend" version ".zip")) ; there is a ".zip" failing at the end
       (sha256
        (base32 "17p70swiawv0dzmcd04szdaxsfi5dwnfjqjkbcppacf7fkmghqg1"))))
    (build-system pyproject-build-system)
    (arguments
    `(#:phases
        (modify-phases %standard-phases
          (add-after 'unpack 'patch-print
            (lambda* (#:key outputs inputs #:allow-other-keys)
              (substitute* "./backend/fs/models.py"
                (("print '[WARNING]  File alias calculated by NULL owner'")
                  "print('[WARNING]  File alias calculated by NULL owner')")) ; DB should be working ?? why not 
              (invoke "cat" "backend/fs/models.py")
            )
          )
        )
      )
    )
    (inputs (list unzip python-setuptools))
    (home-page "https://github.com/tr4n2uil/backend.django")
    (synopsis "Backend Utility Tools")
    (description "Backend Utility Tools")
    (license license:expat)))


(define-public python-semver3
  (package
    (name "python-semver3")
    (version "3.0.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "semver" version))
       (sha256
        (base32 "1k5lba437cgzkr5zp230508w856lpi973ynjzqdfbxkhkjrsslv2"))))
    (build-system pyproject-build-system)
    (home-page "https://github.com/python-semver/python-semver")
    (synopsis "Python helper for Semantic Versioning (https://semver.org)")
    (description "Python helper for Semantic Versioning (https://semver.org)")
    (license license:bsd-3)))


(define-public python-sqlalchemy2
  (package
    (name "python-sqlalchemy2")
    (version "2.0.27")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "SQLAlchemy" version))
       (sha256
        (base32 "1y1l4lwhvgs7ivwhcp4vljjdsaha77x9859kz65virhzlxlyv9l6"))))
    (build-system pyproject-build-system)
    (arguments
      `(#:phases
        (modify-phases %standard-phases
          (delete 'check)
        )
      )
    )
    (propagated-inputs (list python-greenlet python-importlib-metadata
                             python-typing-extensions))
    (home-page "https://www.sqlalchemy.org")
    (synopsis "Database Abstraction Library")
    (description "Database Abstraction Library")
    (license license:expat)))














