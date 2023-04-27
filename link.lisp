#+darwin
(bodge-blobs-support:link-system-foreign-libraries
 :glad-blob (asdf:system-relative-pathname
             :nanosvg-blob #+x86-64 "x86_64/" #+x86 "x86/"
             #-(or x86-64 x86)
             (cl:error "Unsupported architecture")))
