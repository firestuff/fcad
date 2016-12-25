fDraw(fCylinder(10, r1=5, r2=2));

///// Data structures

/// model:
///   kKeyPoints "points" fPoints(): [ [x, y, z], ... ]
///   kKeyFaces "faces" fFaces(): [ [ pointIdx, ... ], ... ]

///// Drawing modules
module fDraw(model) {
  polyhedron(points=fPoints(model), faces=fFaces(model));
}

module fDrawN(model, scales) {
  fDraw(model);
  points = fPoints(model);
  model_max = fMaxPoint(model);
  translation =
    [for (axis = [0 : 2])
      scales[axis] * model_max[axis]];
  translate(translation) children();
}

module fDrawX(model) {
  fDrawN(model, [1, 0, 0]) children();
}

module fDrawY(model) {
  fDrawN(model, [0, 1, 0]) children();
}

module fDrawZ(model) {
  fDrawN(model, [0, 0, 1]) children();
}

///// 3D object creation functions
function fCube(dims) = (
  let(x = fIsVector(dims) ? dims[0] : dims,
      y = fIsVector(dims) ? dims[1] : dims,
      z = fIsVector(dims) ? dims[2] : dims)
  [
    [fKeyPoints,  fCartesianProduct([[0, x], [0, y], [0, z]])],
    [fKeyFaces, [
      [0, 2, 3, 1], // -x
      [0, 1, 5, 4], // -y
      [0, 4, 6, 2], // -z
      [4, 5, 7, 6], // +x
      [2, 6, 7, 3], // +y
      [1, 3, 7, 5], // +z
    ]],
  ]
);

function fCylinder(h, r, r1=undef, r2=undef, sides=36) = (
  let(degrees_per_side = 360 / sides,
      side_range = [0 : sides - 1],
      int_r1 = (r1 == undef) ? r : r1,
      int_r2 = (r2 == undef) ? r : r2)
  [
    [fKeyPoints,
      [for (side = side_range)
       for (params = [[int_r1, 0], [int_r2, h]])
       let (angle = side * degrees_per_side,
            radius = params[0],
            height = params[1])
        [radius * sin(angle), radius * cos(angle), height]],
    ],
    [fKeyFaces, concat(
      // bottom
      [[for (side = [sides : -1 : 0]) side * 2]],
      // top
      [[for (side = [0 : sides]) side * 2 + 1]],
      // sides
      [for (side = side_range)
        [for (vertex = [2, 3, 1, 0]) (side * 2 + vertex) % (sides * 2)]]
    )],
  ]
);

function fSphere(r, sides=36, stripes=18) = (
  let(degrees_per_slice = 180 / stripes,
      degrees_per_side = 360 / sides,
      top_index = (stripes - 1) * sides)
  [
    [fKeyPoints, concat(
      [for (stripe_index = [1 : stripes - 1])
       for (side_index = [0 : sides - 1])
       let (stripe_angle = stripe_index * degrees_per_slice,
            side_angle = side_index * degrees_per_side,
            stripe_radius = r * sin(stripe_angle),
            stripe_z = r * cos(stripe_angle),
            side_x = stripe_radius * sin(side_angle),
            side_y = stripe_radius * cos(side_angle))
        [side_x, side_y, stripe_z]
      ],
      [
        [0, 0, r],  // top
        [0, 0, -r],  // bottom
      ]
    )],
    [fKeyFaces, concat(
      // side squares
      [for (stripe_index = [2 : stripes - 1])
       for (side_index = [0 : sides - 1])
       let (prev_side_base = (stripe_index - 2) * sides,
            side_base = (stripe_index - 1) * sides)
        [
          prev_side_base + (side_index + 1) % sides,
          prev_side_base + side_index,
          side_base + side_index,
          side_base + (side_index + 1) % sides,
        ]
      ],
      // top triangles
      [for (side_index = [0 : sides - 1])
        [
          top_index,
          side_index,
          (side_index + 1) % sides,
        ]
      ],
      // bottom triangles
      [for (side_index = [0 : sides - 1])
       let (side_base = (stripes - 2) * sides)
        [
          top_index + 1,
          side_base + (side_index + 1) % sides,
          side_base + side_index,
        ]
      ]
    )],
  ]
);

///// 3D object information functions
function fMinPoint(model) = (
  [for (axis = [0 : 2])
   min([for (point = fPoints(model)) point[axis]])]
);

function fMaxPoint(model) = (
  [for (axis = [0 : 2])
   max([for (point = fPoints(model)) point[axis]])]
);

function fCenterPoint(model) = (
  let(model_min = fMinPoint(model),
      model_max = fMaxPoint(model),
      model_size =
        [for (axis = [0 : 2])
         model_max[axis] - model_min[axis]])
  [for (axis = [0 : 2])
   model_min[axis] + (model_size[axis] / 2)]
);

///// 3D object translation functions
function fTranslate(model, translation) = (
  [
    [fKeyPoints,
      [for (point = fPoints(model))
        [for (axis = [0 : 2])
         point[axis] + translation[axis]]
      ]
    ],
    [fKeyFaces, fFaces(model)],
  ]
);

function fZeroN(model, scales) = (
  let(model_min = fMinPoint(model),
      translation =
        [for (axis = [0 : 2])
         scales[axis] * model_min[axis]])
  fTranslate(model, translation)
);

function fZeroX(model) = (
  fZeroN(model, [-1, 0, 0])
);

function fZeroY(model) = (
  fZeroN(model, [0, -1, 0])
);

function fZeroZ(model) = (
  fZeroN(model, [0, 0, -1])
);

function fCenterN(model, scales) = (
  let(model_center = fCenterPoint(model),
      translation =
        [for (axis = [0 : 2])
        scales[axis] * model_center[axis]])
  fTranslate(model, translation)
);

function fCenterX(model) = (
  fCenterN(model, [-1, 0, 0])
);

function fCenterY(model) = (
  fCenterN(model, [0, -1, 0])
);

function fCenterZ(model) = (
  fCenterN(model, [0, 0, -1])
);

///// Constants
fKeyPoints = "points";
fKeyFaces = "faces";

fTypeUndef = "undef";
fTypeInt = "int";
fTypeFloat = "float";
fTypeString = "string";
fTypeBoolean = "boolean";
fTypeVector = "vector";
fTypeUnknown = "unknown";

///// Utility functions
function fType(x) = (
  x == undef ? fTypeUndef
  : floor(x) == x ? fTypeInt
  : abs(x) + 1 > abs(x) ? fTypeFloat
  : str(x) == x ? fTypeString
  : str(x) == "false" || str(x) == "true" ? fTypeBoolean
  : (x[0] == x[0]) && len(x) != undef ? fTypeVector
  : fTypeUnknown
);

function fIsVector(x) = (
  fType(x) == fTypeVector
);

function fIsInt(x) = (
  fType(x) == fTypeInt
);

function fIsFloat(x) = (
  fType(x) == fTypeFloat
);

function fIsString(x) = (
  fType(x) == fTypeString
);

function fIsBoolean(x) = (
  fType(x) == fTypeBoolean
);

function fIsVector(x) = (
  fType(x) == fTypeVector
);

function fMapLookup(key, model) = (
  [for (pair = model)
   let (iter_key = pair[0],
        iter_value = pair[1])
   if (key == iter_key)
   iter_value][0]
);

function fVectorSlice(vec, start=0, step=undef, end=undef) = (
  let(real_end = (end == undef) ? len(vec) - 1 : end,
      real_step = (step == undef) ?
        ((real_end > start) ? 1 : -1)
        : step)
  [for (i = [start : real_step : real_end])
   vec[i]]
);

function fCartesianProduct(vecs) = (
  len(vecs) == 1 ?
    vecs[0]
    :
    [for (val1 = vecs[0])
     for (val2 = fCartesianProduct(fVectorSlice(vecs, start=1)))
     concat(val1, val2)]
);

function fPoints(model) = (
  fMapLookup(fKeyPoints, model)
);

function fFaces(model) = (
  fMapLookup(fKeyFaces, model)
);
