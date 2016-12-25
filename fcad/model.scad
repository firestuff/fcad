/// model:
///   fKeyType "type" fType(): fTypeModel "model"
///   fKeyPoints "points" fModelPoints(): [ [x, y, z], ... ]
///   fKeyFaces "faces" fModelFaces(): [ [ pointIdx, ... ], ... ]

fTypeModel = "model";

function fIsModel(x) = (
  fType(x) == fTypeModel
);

fKeyPoints = "points";
fKeyFaces = "faces";

function fModel(points, faces) = (
  [
    [fKeyType, fTypeModel],
    [fKeyPoints, points],
    [fKeyFaces, faces],
  ]
);

function fModelPoints(model) = (
  fMapLookup(fKeyPoints, model)
);

function fModelFaces(model) = (
  fMapLookup(fKeyFaces, model)
);
