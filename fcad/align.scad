function fAlign(modelA, coordNameA, modelB, coordNameB) = (
  let(coordA = fModelCoord(modelA, coordNameA),
      coordB = fModelCoord(modelB, coordNameB),
      translation = fCoordTranslation(coordA) - fCoordTranslation(coordB),
      rotation = fCoordRotation(coordA) - fCoordRotation(coordB),
      scale = fCoordScale(coordA) - fCoordScale(coordB))
  fUnion(
    modelA,
    fTranslate(
      fRotate(modelB, coordNameB, rotation),
      translation
    )
  )
);

function fAttach(modelA, coordNameA, modelB, coordNameB) = (
  let(coordA = fModelCoord(modelA, coordNameA),
      coordB = fModelCoord(modelB, coordNameB),
      translation = fCoordTranslation(coordA) - fCoordTranslation(coordB),
      rotation = fCoordRotation(coordA) - (-1 * fCoordRotation(coordB)),
      scale = fCoordScale(coordA) - fCoordScale(coordB))
  fUnion(
    modelA,
    fTranslate(
      fRotate(modelB, coordNameB, rotation),
      translation
    )
  )
);
