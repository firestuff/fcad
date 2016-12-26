function fTranslate(model, translation) = (
  fModel(
    points=
      [for (point = fModelPoints(model))
       point + translation],
    faces=fModelFaces(model),
    coords=fModelCoords(model)
  )
);
