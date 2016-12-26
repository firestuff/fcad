// Short for "coordinate system", including translation, rotation, and scale
// coord:
//   fKeyType "type" fType(): fTypeCoord "coord"
//   fKeyTranslation "translation" fCoordTranslation(): [ x, y, z ]
//   fKeyRotation "rotation" fCoordRotation(): [ x, y, z ]
//   fKeyScale "scale" fCoordScale(): [ x, y, z ]

fTypeCoord = "coord";

function fIsCoord(x) = (
  fType(x) == fTypeCoord
);

fKeyTranslation = "translation";
fKeyRotation = "rotation";
fKeyScale = "scale";

function fCoord(translation=[0, 0, 0], rotation=[0, 0, 0], scale=[1, 1, 1]) = (
  [
    [fKeyType, fTypeCoord],
    [fKeyTranslation, translation],
    [fKeyRotation, rotation],
    [fKeyScale, scale],
  ]
);

function fCoordTranslation(coord) = (
  fMapLookup(fKeyTranslation, coord)
);

function fCoordRotation(coord) = (
  fMapLookup(fKeyRotation, coord)
);

function fCoordScale(coord) = (
  fMapLookup(fKeyScale, coord)
);

function fCoordInverse(coord) = (
  fCoord(
    translation=[0, 0, 0] - fCoordTranslation(coord),
    rotation=[180, 180, 180] + fCoordRotation(coord),
    scale=1 / fCoordScale(coord)
  )
);
