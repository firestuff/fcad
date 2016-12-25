/// model:
///   fKeyType "type" fType(): fTypeModel "model"
///   fKeyPoints "points" fModelPoints(): [ [x, y, z], ... ]
///   fKeyFaces "faces" fModelFaces(): [ [ pointIdx, ... ], ... ]
///   fKeyCoords "coords" fModelCoords(): [ [ name, coord ], ... ]

/// Standard model coords names:
///
///   [-/+] edge ("/" is midpoint)
///   [xyz] axis
///   [-+]  direction
///   [-/+]x[-+],[-/+]y[-+],[-/+]z[-+]

fTypeModel = "model";

function fIsModel(x) = (
  fType(x) == fTypeModel
);

fKeyPoints = "points";
fKeyFaces = "faces";
fKeyCoords = "coords";

function fModel(points, faces, coords=[]) = (
  [
    [fKeyType, fTypeModel],
    [fKeyPoints, points],
    [fKeyFaces, faces],
    [fKeyCoords, coords],
  ]
);

function fModelPoints(model) = (
  fMapLookup(fKeyPoints, model)
);

function fModelFaces(model) = (
  fMapLookup(fKeyFaces, model)
);

fCoordAliases = [
  [ "bottom", "/x+,/y+,-z+" ],
  [ "top",    "/x+,/y+,+z+" ],
  [ "center", "/x+,/y+,/z+" ],
];

function fModelCoords(model) = (
  fMapLookup(fKeyCoords, model)
);

function fModelCoord(model, name) = (
  let(alias = fMapLookup(name, fCoordAliases),
      realName = alias ? alias : name)
  fMapLookup(realName, fModelCoords(model))
);
