(define-module (python-aiida-core)
    #:use-module ((guix licenses) #:prefix license:)
    #:use-module (guix packages)
    #:use-module (guix download)
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
                             python-get-annotations
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
                             python-myst-nb
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
                             python-spglib
                             python-sphinx
                             python-sphinx-copybutton
                             python-sphinx-design
                             python-sphinx-intl
                             python-sphinx-notfound-page
                             python-sphinx-sqlalchemy
                             python-sphinxext-rediraffe
                             python-sqlalchemy
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
    (propagated-inputs (list python-coverage python-pre-commit python-pytest
                             python-pytest-cov))
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
    (propagated-inputs (list python-backports.cached-property
                             python-curtsies
                             python-cwcwidth
                             python-greenlet
                             python-pygments
                             python-pyxdg
                             python-requests
                             python-typing-extensions))
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
    (propagated-inputs (list python-coverage
                             python-flake8
                             python-gevent
                             python-mock
                             python-nose2
                             python-psutil
                             python-pyyaml
                             python-pyzmq
                             python-tornado
                             python-tox))
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
                             python-pywin32
                             python-sphinx
                             python-sphinx-book-theme
                             python-sphinx-panels
                             python-sphinxext-rediraffe
                             python-sqlalchemy
                             python-tqdm))
    (home-page "https://github.com/aiidateam/disk-objectstore")
    (synopsis
     "An implementation of an efficient object store that writes directly on disk.")
    (description
     "An implementation of an efficient object store that writes directly on disk.")
    (license #f)))


(define-public python-get-annotations
  (package
    (name "python-get-annotations")
    (version "0.1.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "get-annotations" version))
       (sha256
        (base32 "1asb6yllzfp36kml6jvhwb28zlcvqnf9x4g5gizwqdrj0jw6jyys"))))
    (build-system pyproject-build-system)
    (home-page "https://github.com/shawwn/get-annotations")
    (synopsis "A backport of Python 3.10's inspect.get_annotation() function")
    (description
     "This package provides a backport of Python 3.10's inspect.get_annotation()
function")
    (license license:expat)))


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
                             python-pytest-notebook
                             python-pytray
                             python-pyyaml
                             python-shortuuid
                             python-sphinx
                             python-sphinx-autobuild))
    (home-page "https://pypi.org/project/kiwipy/")
    (synopsis "Robust, high-volume, message based communication made easy.")
    (description "Robust, high-volume, message based communication made easy.")
    (license #f)))


(define-public python-myst-nb
  (package
    (name "python-myst-nb")
    (version "1.0.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "myst_nb" version))
       (sha256
        (base32 "0phc7sg267fp84497x3fh5n5vnjxan1nyl3qa2jiwi3b3hmf8xwh"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-alabaster
                             python-altair
                             python-beautifulsoup4
                             python-bokeh
                             python-coconut
                             python-coverage
                             python-importlib-metadata
                             python-ipykernel
                             python-ipython
                             python-ipywidgets
                             python-jupyter-cache
                             python-jupytext
                             python-matplotlib
                             python-myst-parser
                             python-nbclient
                             python-nbdime
                             python-nbformat
                             python-numpy
                             python-pandas
                             python-plotly
                             python-pre-commit
                             python-pytest
                             python-pytest-cov
                             python-pytest-param-files
                             python-pytest-regressions
                             python-pyyaml
                             python-sphinx
                             python-sphinx-book-theme
                             python-sphinx-copybutton
                             python-sphinx-design
                             python-sphinxcontrib-bibtex
                             python-sympy
                             python-typing-extensions))
    (home-page "https://pypi.org/project/myst-nb/")
    (synopsis
     "A Jupyter Notebook Sphinx reader built on top of the MyST markdown parser.")
    (description
     "This package provides a Jupyter Notebook Sphinx reader built on top of the
@code{MyST} markdown parser.")
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
                             python-myst-nb
                             python-nest-asyncio
                             python-pre-commit
                             python-pylint
                             python-pytest
                             python-pytest-asyncio
                             python-pytest-cov
                             python-pytest-notebook
                             python-pyyaml
                             python-shortuuid
                             python-sphinx
                             python-sphinx-book-theme
                             python-types-pyyaml))
    (home-page "https://pypi.org/project/plumpy")
    (synopsis "A Python workflow library.")
    (description "This package provides a Python workflow library.")
    (license #f)))


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
    (build-system pyproject-build-system)
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
                             python-spglib
                             python-sympy
                             python-tabulate
                             python-tqdm
                             python-uncertainties))
    (native-inputs (list python-mypy
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
    (propagated-inputs (list python-numpy python-spglib))
    (native-inputs (list python-black python-pre-commit python-prospector
                         python-pylint python-pytest))
    (home-page "http://github.com/giovannipizzi/seekpath")
    (synopsis
     "A module to obtain and visualize k-vector coefficients and obtain band paths in the Brillouin zone of crystal structures")
    (description
     "This package provides a module to obtain and visualize k-vector coefficients and
obtain band paths in the Brillouin zone of crystal structures")
    (license #f)))


(define-public python-spglib
  (package
    (name "python-spglib")
    (version "2.3.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "spglib" version))
       (sha256
        (base32 "1qwcqqdjnd2781zxaxih4bpfsbiqwr7pq0dpz8hcn862czn2avkk"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-linkify-it-py
                             python-myst-parser
                             python-numpy
                             python-pre-commit
                             python-pytest
                             python-pytest-benchmark
                             python-pytest-cov
                             python-pyyaml
                             python-spglib
                             python-sphinx
                             python-sphinx-autodoc2
                             python-sphinx-book-theme
                             python-sphinxcontrib-bibtex))
    (home-page "https://spglib.readthedocs.io/")
    (synopsis "This is the spglib module.")
    (description "This is the spglib module.")
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
    (propagated-inputs (list python-furo
                             python-myst-parser
                             python-pre-commit
                             python-pydata-sphinx-theme
                             python-pytest
                             python-pytest-cov
                             python-pytest-regressions
                             python-sphinx
                             python-sphinx-book-theme
                             python-sphinx-rtd-theme))
    (home-page "https://pypi.org/project/sphinx_design/l")
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
    (propagated-inputs (list python-sphinx
                             python-sphinx-autoapi
                             python-sphinx-rtd-theme
                             python-sphinx-tabs
                             python-sphinxemoji
                             python-tox))
    (home-page "https://pypi.org/project/sphinx-notfound-page/")
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
    (propagated-inputs (list python-furo
                             python-pytest
                             python-pytest-cov
                             python-sphinx
                             python-sphinx-pytest
                             python-sqlalchemy
                             python-syrupy))
    (home-page "https://pypi.org/project/sphinx_sqlalchemy/")
    (synopsis "Sphinx extension for documenting SQLAlchemy ORMs")
    (description "Sphinx extension for documenting SQLAlchemy ORMs")
    (license #f)))


(define-public python-sphinxext-rediraffe
  (package
    (name "python-sphinxext-rediraffe")
    (version "0.2.7")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "sphinxext-rediraffe" version))
       (sha256
        (base32 "0pbjkwmqc8q08bsk66panvpya831ycjq1ysdagyrznpzwpxcn7b5"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-sphinx))
    (home-page "https://github.com/wpilibsuite/sphinxext-rediraffe")
    (synopsis
     "Sphinx Extension that redirects non-existent pages to working pages.")
    (description
     "Sphinx Extension that redirects non-existent pages to working pages.")
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
    (propagated-inputs (list python-click python-textual))
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
    (propagated-inputs (list python-pamqp python-setuptools python-yarl))
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
                         python-flake8-deprecated
                         python-flake8-import-order
                         python-flake8-print
                         python-flake8-quotes
                         python-flake8-rst-docstrings
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
    (propagated-inputs (list python-flake8))
    (home-page "https://github.com/adamchainz/flake8-comprehensions")
    (synopsis
     "A flake8 plugin to help you write better list/set/dict comprehensions.")
    (description
     "This package provides a flake8 plugin to help you write better list/set/dict
comprehensions.")
    (license license:expat)))


(define-public python-flake8-deprecated
  (package
    (name "python-flake8-deprecated")
    (version "2.2.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "flake8_deprecated" version))
       (sha256
        (base32 "18iazzh2l42fcjmkqdwncsl1h2s6sbi26vz4m0gmd80w3l0cm5pf"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-flake8))
    (native-inputs (list python-pytest))
    (home-page "")
    (synopsis "Warns about deprecated method calls")
    (description "Warns about deprecated method calls")
    (license #f)))


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
    (propagated-inputs (list python-enum34 python-pycodestyle
                             python-setuptools))
    (home-page "https://github.com/PyCQA/flake8-import-order")
    (synopsis
     "Flake8 and pylama plugin that checks the ordering of import statements.")
    (description
     "Flake8 and pylama plugin that checks the ordering of import statements.")
    (license #f)))


(define-public python-flake8-rst-docstrings
  (package
    (name "python-flake8-rst-docstrings")
    (version "0.3.0")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "flake8-rst-docstrings" version))
       (sha256
        (base32 "195gs7wa5sjcczdzx0pd336cz67idsa0x64ddgc3rdrppns25kni"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-flake8 python-pygments
                             python-restructuredtext-lint))
    (native-inputs (list python-build python-twine))
    (home-page "")
    (synopsis "Python docstring reStructuredText (RST) validator for flake8")
    (description
     "Python docstring @code{reStructuredText} (RST) validator for flake8")
    (license license:expat)))


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
    (propagated-inputs (list python-flake8 python-six))
    (home-page "https://github.com/ar4s/flake8_tuple")
    (synopsis "Check code for 1 element tuple.")
    (description "Check code for 1 element tuple.")
    (license license:bsd-3)))


(define-public python-enum34
  (package
    (name "python-enum34")
    (version "1.1.10")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "enum34" version))
       (sha256
        (base32 "0j7ji699fwswm4vg6w1v07fkbf8dkzdm6gfh88jvs5nqgr3sgrnc"))))
    (build-system pyproject-build-system)
    (home-page "https://bitbucket.org/stoneleaf/enum34")
    (synopsis
     "Python 3.4 Enum backported to 3.3, 3.2, 3.1, 2.7, 2.6, 2.5, and 2.4")
    (description
     "Python 3.4 Enum backported to 3.3, 3.2, 3.1, 2.7, 2.6, 2.5, and 2.4")
    (license license:bsd-3)))


(define-public python-backports.cached-property
  (package
    (name "python-backports.cached-property")
    (version "1.0.2")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "backports.cached-property" version))
       (sha256
        (base32 "1pbmdrjmqx00kim7pw1bzgjzm1ic9q4w2syfd8azsmgcsvpgj1lk"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-typing))
    (home-page "https://github.com/penguinolog/backports.cached_property")
    (synopsis
     "cached_property() - computed once per instance, cached as attribute")
    (description
     "cached_property() - computed once per instance, cached as attribute")
    (license license:expat)))


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
    (home-page "https://mg.pov.lt/profilehooks/")
    (synopsis "Decorators for profiling/timing/tracing individual functions")
    (description
     "Decorators for profiling/timing/tracing individual functions")
    (license license:expat)))


; dbissuel@ilmport1086:~/Documents/softs/sourcecodes/rabbitmq-server-3.13.0$ guix import pypi pywin32
; guix import: erreur : no source release for pypi package pywin32 306

; conseil : Cela signifie que le paquet est disponible sur PyPI, mais seulement en tant que « wheel » qui contient des binaires, pas des sources.  Pour construire ce paquet à partir des sources, référez-vous au dépôt
; en amont sur `https://github.com/mhammond/pywin32'.

