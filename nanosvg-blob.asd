(asdf:defsystem nanosvg-blob
  :author ""
  :description "Nano SVG foreign library"
  :license "MIT"
  :defsystem-depends-on (:bodge-blobs-support)
  :class :bodge-blob-system
  :depends-on (glad-blob cffi float-features bodge-nanovg cl-destruction)
  :libraries (((:unix (:not :darwin) :x86-64)
               "libnanosvg.so" "x86_64/"))
  :components ((:file "package")
               (:file "link")
               (:file "bindings")))

