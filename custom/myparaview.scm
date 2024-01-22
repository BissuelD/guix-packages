(define-module (myparaview)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  ;#:use-module (guix utils)
  ;#:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system qt)
  ;#:use-module (guix build-system cmake)
  ;#:use-module (guix build-system gnu)
  ;#:use-module (guix build-system python)
  ;#:use-module (gnu packages)
  #:use-module (gnu packages algebra)
  ;#:use-module (gnu packages bison)
  #:use-module (gnu packages boost)
  ;#:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages curl)
  ;#:use-module (gnu packages docbook)
  #:use-module (gnu packages documentation)
  ;#:use-module (gnu packages flex)
  #:use-module (gnu packages fontutils)
  ;#:use-module (gnu packages game-development)
  #:use-module (gnu packages gcc)
  ;#:use-module (gnu packages gd)
  #:use-module (gnu packages geo)
  ;#:use-module (gnu packages ghostscript)
  ;#:use-module (gnu packages gimp)
  #:use-module (gnu packages gl)
  ;#:use-module (gnu packages glib)
  ;#:use-module (gnu packages gnome)
  ;#:use-module (gnu packages graphics)
  #:use-module (gnu packages graphviz)
  ;#:use-module (gnu packages gstreamer)
  ;#:use-module (gnu packages gtk)
  ;#:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  ;#:use-module (gnu packages imagemagick)
  ;#:use-module (gnu packages linux)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpi)
  ;#:use-module (gnu packages opencl)
  ;#:use-module (gnu packages pdf)
  #:use-module (gnu packages perl)
  ;#:use-module (gnu packages photo)
  ;#:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pretty-print)
  #:use-module (gnu packages protobuf)
  #:use-module (gnu packages python)
  ;#:use-module (gnu packages python-check)
  ;#:use-module (gnu packages python-science)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages qt)
  #:use-module (gnu packages sdl)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages sqlite)
  #:use-module (gnu packages tbb)
  #:use-module (gnu packages textutils)
  ;#:use-module (gnu packages tls)
  ;#:use-module (gnu packages version-control)
  #:use-module (gnu packages video)
  #:use-module (gnu packages xiph)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
)

(define-public myparaview
  (package
    (name "myparaview")
    (version "5.11.1")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://gitlab.kitware.com/paraview/paraview.git")
             (commit (string-append "v" version))
             (recursive? #t)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0m1lgkl95f0pyhxp97gq2rf8hibv39v4c49imfj1va40z0flvard"))
       (modules '((guix build utils)))
       (snippet
        ;; TODO: Also remove unused bundled libraries and plugins?
        #~(begin
            ;; Remove bundled ParaView libraries which are available in Guix
            ;; or undesired.
            (for-each (lambda (dir)
                        (delete-file-recursively
                         (string-append "ThirdParty/" dir "/vtk"
                                        (string-downcase dir))))
                      '(;;"CosmoHaloFinder"
                        ;;"IceT"
                        "NvPipe"        ; Don't want NvPipe support
                        ;;"QtTesting"
                        ;;"cinema"
                        ;;"cinemasci"
                        "protobuf"))
            ;; Remove undesired ParaView plugins.
            (delete-file-recursively "Plugins/pvNVIDIAIndeX")
            ;; Remove bundled VTK libraries which are available in Guix.
            (for-each (lambda (dir)
                        (delete-file-recursively
                         (string-append "VTK/ThirdParty/" dir "/vtk" dir)))
                      '(;;"cgns"
                        "cli11"
                        ;;"diy2"
                        "doubleconversion"
                        "eigen"
                        ;;"exodusII"
                        "expat"
                        ;;"exprtk"
                        ;;"fides"
                        "fmt"
                        "freetype"
                        "gl2ps"
                        "glew"
                        ;;"h5part"
                        "hdf5"
                        ;;"ioss"
                        "jpeg"
                        "jsoncpp"
                        ;;"kissfft"
                        ;;"libharu" ; Requires some PRs applied to 2.3.0
                        "libproj"
                        "libxml2"
                        ;;"loguru"
                        "lz4"
                        "lzma"
                        "mpi4py"
                        "netcdf"
                        "nlohmannjson"
                        "ogg"
                        ;;"pegtl"
                        "png"
                        "pugixml"
                        "sqlite"
                        "theora"
                        "tiff"
                        "utf8"
                        ;;"verdict"
                        ;;"vpic"
                        ;;"vtkm"
                        ;;"xdmf2"
                        ;;"xdmf3"
                        ;;"zfp"
                        "zlib"))))))
    (build-system qt-build-system)
    (arguments
     (list
      #:build-type "Release"            ; 542 MiB in release mode
      #:tests? #f                       ; Downloads test data
      #:configure-flags
      #~(let ((doc (string-append #$output "/share/doc/" #$name "-" #$version)))
          (list
           (string-append "-DCMAKE_INSTALL_DOCDIR=" doc) ; For paraview.qch

           ;; ParaView build options
           "-DPARAVIEW_BUILD_DEVELOPER_DOCUMENTATION=ON"
           (string-append "-DPARAVIEW_GENERATED_DOCUMENTATION_OUTPUT_DIRECTORY=" doc)

           ;; ParaView capability options
           ;;"-DPARAVIEW_USE_EXTERNAL_VTK=ON" ; Unsupported by ParaView
           "-DPARAVIEW_USE_MPI=ON"
           "-DPARAVIEW_USE_PYTHON=ON"
           "-DPARAVIEW_USE_QTWEBENGINE=ON"

           ;; ParaView features
           ;;
           ;; Enable those that are disabled by default.
           ;; Commented means the dependencies are missing from Guix
           ;; (or are otherwise described).
           ;;"-DPARAVIEW_ENABLE_ADIOS2=ON"
           ;;"-DPARAVIEW_ENABLE_COSMOTOOLS=ON"
           ;;"-DPARAVIEW_ENABLE_CATALYST=ON"
           "-DPARAVIEW_ENABLE_FFMPEG=ON"
           ;;"-DPARAVIEW_ENABLE_FIDES=ON"
           "-DPARAVIEW_ENABLE_GDAL=ON"
           ;;"-DPARAVIEW_ENABLE_LAS=ON"
           ;;"-DPARAVIEW_ENABLE_LOOKINGGLASS=ON" ; Downloads dependency
           ;;"-DPARAVIEW_ENABLE_MOMENTINVARIANTS=ON" ; Downloads dependency
           "-DPARAVIEW_ENABLE_MOTIONFX=ON"
           ;;"-DPARAVIEW_ENABLE_OPENTURNS=ON"
           ;;"-DPARAVIEW_ENABLE_OPENVDB=ON" ; Dependency not found
           ;;"-DPARAVIEW_ENABLE_PDAL=ON"
           ;;"-DPARAVIEW_ENABLE_RAYTRACING=ON"
           "-DPARAVIEW_ENABLE_VISITBRIDGE=ON"
           "-DPARAVIEW_ENABLE_XDMF3=ON"

           ;; ParaView miscellaneous options
           ;;
           ;; Without -DPARAVIEW_DATA_EXCLUDE_FROM_ALL=OFF, test data is
           ;; downloaded even with tests disabled.
           "-DPARAVIEW_VERSIONED_INSTALL=OFF"
           "-DPARAVIEW_DATA_EXCLUDE_FROM_ALL=OFF"

           ;; ParaView plugins
           ;;
           ;; Enable those that are disabled by default.
           ;; Commented means the dependencies are missing from Guix
           ;; (or are otherwise described).
           ;;"-DPARAVIEW_PLUGIN_ENABLE_AdiosReaderPixie=ON"
           ;;"-DPARAVIEW_PLUGIN_ENABLE_AdiosReaderStaging=ON"
           "-DPARAVIEW_PLUGIN_ENABLE_CAVEInteraction=ON"
           ;;"-DPARAVIEW_PLUGIN_ENABLE_CDIReader=ON"
           "-DPARAVIEW_PLUGIN_ENABLE_GeographicalMap=ON"
           "-DPARAVIEW_PLUGIN_ENABLE_GmshIO=ON"
           "-DPARAVIEW_PLUGIN_ENABLE_InSituExodus=ON"
           ;;"-DPARAVIEW_PLUGIN_ENABLE_LookingGlass=ON"
           "-DPARAVIEW_PLUGIN_ENABLE_NetCDFTimeAnnotationPlugin=ON"
           ;;"-DPARAVIEW_PLUGIN_ENABLE_ParFlow=ON" ; Build fails
           ;;"-DPARAVIEW_PLUGIN_ENABLE_PythonQtPlugin=ON"
           "-DPARAVIEW_PLUGIN_ENABLE_SpaceMouseInteractor=ON"
           ;;"-DPARAVIEW_PLUGIN_ENABLE_VDFReaderPlugin=ON"
           ;;"-DPARAVIEW_PLUGIN_ENABLE_XRInterface=ON" ; Build fails
           ;;"-DPARAVIEW_PLUGIN_ENABLE_zSpace=ON"

           ;; VTK options
           "-DVTK_SMP_IMPLEMENTATION_TYPE=TBB"
           "-DVTKm_ENABLE_MPI=ON"

           ;; External libraries for ParaView and VTK
           "-DVTK_MODULE_USE_EXTERNAL_ParaView_protobuf=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_cli11=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_doubleconversion=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_eigen=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_expat=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_fmt=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_freetype=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_gl2ps=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_glew=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_hdf5=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_jpeg=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_jsoncpp=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_libproj=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_libxml2=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_lz4=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_lzma=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_mpi4py=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_netcdf=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_nlohmannjson=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_ogg=ON"
           ;;"-DVTK_MODULE_USE_EXTERNAL_VTK_pegtl=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_png=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_pugixml=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_sqlite=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_theora=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_tiff=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_utf8=ON"
           "-DVTK_MODULE_USE_EXTERNAL_VTK_zlib=ON"))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'set-paths 'hide-gfortran
            (lambda _
              (setenv "CPLUS_INCLUDE_PATH"
                      (string-join
                       (delete (string-append #$(this-package-native-input "gfortran")
                                              "/include/c++")
                               (string-split (getenv "CPLUS_INCLUDE_PATH") #\:))
                       ":"))))
          (replace 'install-license-files
            (lambda _
              (let ((src (string-append #$output "/share/licenses/ParaView"))
                    (dst (string-append #$output "/share/doc/"
                                        #$name "-" #$version "/licenses")))
                (copy-recursively src dst)
                (delete-file-recursively (dirname src))))))))
    (native-inputs
     (list gfortran
           ;; For the documentation
           doxygen
           graphviz
           perl
           python-sphinx))
    (inputs
     (list boost
           cli11
           curl
           double-conversion
           eigen
           expat
           ffmpeg
           fmt
           freetype
           gdal
           gl2ps
           glew
           gmsh
           hdf5
           nlohmann-json                ;For ParFlow; build fails
           jsoncpp
           libjpeg-turbo
           libogg
           libpng
           libtheora
           libtiff
           libxcursor
           libxml2
           libxt
           lz4
           lzip
           mesa
           netcdf
           openmpi
           ;;openvdb                      ;For OpenVDB; dependency not found
           ;;openvr                       ;For XRInterface; build fails
           ;;pegtl                        ;For VTK; build fails
           proj
           protobuf
           pugixml
           python-cftime
           python-matplotlib
           python-mpi4py
           python-numpy
           python-wrapper
           qtbase-5
           qtdeclarative-5
           qtmultimedia-5
           qtsvg-5
           qttools-5
           qtwebchannel-5
           qtwebengine-5
           qtx11extras
           qtxmlpatterns
           sdl2
           sqlite
           tbb
           utfcpp
           zlib))
    (home-page "https://www.paraview.org/")
    (synopsis "VTK-based, parallel data analyzer and visualizer")
    (description "ParaView is a VTK-based, parallel data analyzer and
visualizer which allows exploring data interactively in 3D or
programmatically.")
    (license license:bsd-3)))
    myparaview