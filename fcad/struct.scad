/// model:
///   kKeyPoints "points" fPoints(): [ [x, y, z], ... ]
///   kKeyFaces "faces" fFaces(): [ [ pointIdx, ... ], ... ]

fKeyPoints = "points";
fKeyFaces = "faces";

function fPoints(model) = (
  fMapLookup(fKeyPoints, model)
);

function fFaces(model) = (
  fMapLookup(fKeyFaces, model)
);
