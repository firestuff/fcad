/// model:
///   fKeyType "type" fType(): fTypeModel "model"
///   fKeyPoints "points" fPoints(): [ [x, y, z], ... ]
///   fKeyFaces "faces" fFaces(): [ [ pointIdx, ... ], ... ]

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

function fPoints(model) = (
  fMapLookup(fKeyPoints, model)
);

function fFaces(model) = (
  fMapLookup(fKeyFaces, model)
);
