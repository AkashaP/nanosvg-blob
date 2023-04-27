(in-package :nanosvg)

(cffi:defcenum painttype
  (:nsvg-paint-none 0)
  (:nsvg-paint-color 1)
  (:nsvg-paint-linear-gradient 2)
  (:nsvg-paint-radial-gradient 3))

(cffi:defcenum spreadtype
  (:nsvg-spread-pad 0)
  (:nsvg-spread-reflect 1)
  (:nsvg-spread-repeat 2))

(cffi:defcenum linejoin
  (:nsvg-join-miter 0)
  (:nsvg-join-round 1)
  (:nsvg-join-bevel 2))

(cffi:defcenum linecap
  (:nsvg-cap-butt 0)
  (:nsvg-cap-round 1)
  (:nsvg-cap-square 2))

(cffi:defcenum fillrule
  (:nsvg-fillrule-nonzero 0)
  (:nsvg-fillrule-evenodd 1))

(cffi:defcenum flags
  (:nsvg-flags-visible 1))

(cffi:defcstruct gradientstop
  (color :unsigned-int)
  (offset :float))

(cffi:defctype gradientstop (:struct gradientStop))

(cffi:defcstruct gradient
  (xform :float :count 6)
  (spread :char)
  (fx :float)
  (fy :float)
  (nstops :int)
  (stops gradientStop :count 1))

(cffi:defctype gradient (:struct gradient))

(cffi:defcunion color-gradient
  (color :uint)
  (gradient (:pointer (:struct gradient))))

(cffi:defcstruct paint
  (type :char)
  (color-gradient (:union color-gradient)))

(cffi:defctype paint (:struct paint))

(cffi:defcstruct path
  (pts (:pointer :float))
  (npts :int)
  (closed :char)
  (bounds :float :count 4)
  (next (:pointer (:struct path))))

(cffi:defctype path (:struct path))

(cffi:defcstruct (shape :size 188)
  (id :char :count 64 :offset 0)
  (fill paint :offset 64)
  (stroke paint :offset 80)
  (opacity :float :offset 96)
  (stroke-width :float ;:offset 96
                ); 96
  (stroke-dash-offset :float ;:offset 104
                      )
  (stroke-dash-array :float :count 8 ;:offset 104
                     )
  (stroke-dash-count :char ;:offset 136
                     )
  (stroke-line-join :char; :offset 136
                    )
  (stroke-line-cap :char; :offset 136
                   )
  (miter-limit :float; :offset 144
               )
  (fill-rule :char;:offset 144
             )
  (flags :unsigned-char ;:offset 144
         )
  (bounds :float :count 4 :offset 152)
  (paths (:pointer (:struct path)) :offset 168)
  (next (:pointer (:struct shape)) :offset 176))

(cffi:defctype shape (:struct shape))

(cffi:defcstruct image
  (width :float)
  (height :float)
  (shapes (:pointer (:struct shape))))

(cffi:defctype image (:struct image))

(cffi:defcfun ("nsvgParseFromFile" parse-from-file) (:pointer (:struct image))
  (filename (:pointer :char))
  (units (:pointer :char))
  (dpi :float))

(cffi:defcfun ("nsvgParse" parse) (:pointer (:struct image))
  (input (:pointer :char))
  (units (:pointer :char))
  (dpi :float))

(cffi:defcfun "nsvgduplicatepath" (:pointer path)
  (p (:pointer path)))

(cffi:defcfun ("nsvgDelete" delete-image) :void
  (image (:pointer (:struct image))))

(cffi:defcstruct rasterizer
  (px :float)
  (py :float)
  (edges :pointer)
  (nedges :int)
  (cedges :int)
  (freelist :pointer)
  (pages :pointer)
  (curpage :pointer)
  (scanline :pointer)
  (cscanline :int)
  (bitmap :pointer)
  (width :int)
  (height :int)
  (stride :int))

(cffi:defctype rasterizer (:struct rasterizer))

(cffi:defcfun ("nsvgCreateRasterizer" create-rasterizer) (:pointer rasterizer))

(cffi:defcfun ("nsvgRasterize" rasterize) :void
  (r (:pointer rasterizer))
  (image (:pointer image))
  (tx :float)
  (ty :float)
  (scale :float)
  (dst (:pointer :unsigned-char))
  (w :int)
  (h :int)
  (stride :int))

(cffi:defcfun "nsvgdeleterasterizer" :void
  (unknown (:pointer rasterizer)))

