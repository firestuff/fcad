function fUnion(modelA, modelB) = (
  let(numPointsA = len(fModelPoints(modelA)))
  fModel(
    points=concat(fModelPoints(modelA), fModelPoints(modelB)),
    faces=concat(fModelFaces(modelA),
                 [for (face = fModelFaces(modelB))
                  [for (point = face) point + numPointsA]])
  )
  // TODO: how should we handle coords here?
);
