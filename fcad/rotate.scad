function fRotate(model, coordName, rotation) = (
  // Shift the coordinate frame to the origin, rotate, then restore
  let(coord = fModelCoord(model, coordName),
      inverseCoord = fCoordInverse(coord),
      zeroed = fTranslate(model, fCoordTranslation(inverseCoord)),
      xMatrix = fRotationMatrixX(rotation[0]),
      yMatrix = fRotationMatrixY(rotation[1]),
      zMatrix = fRotationMatrixZ(rotation[2]))
  fTranslate(
    fModel(
      points=
        [for (point = fModelPoints(zeroed))
         ([point] * xMatrix * yMatrix * zMatrix)[0]],
      faces=fModelFaces(model),
      coords=fModelCoords(model)
    ),
    fCoordTranslation(coord)
  )
);

// These matrices are transposed because we apply them with post-multiplication
// to work around OpenSCAD bugs.
function fRotationMatrixX(theta) = (
  [
    [           1,           0,           0 ],
    [           0,  cos(theta),  sin(theta) ],
    [           0, -sin(theta),  cos(theta) ],
  ]
);

function fRotationMatrixY(theta) = (
  [
    [  cos(theta),           0, -sin(theta) ],
    [           0,           1,           0 ],
    [  sin(theta),           0,  cos(theta) ],
  ]
);

function fRotationMatrixZ(theta) = (
  [
    [  cos(theta),  sin(theta),           0 ],
    [ -sin(theta),  cos(theta),           0 ],
    [           0,           0,           1 ],
  ]
);
