module fDraw(model) {
  polyhedron(points=fModelPoints(model), faces=fModelFaces(model));
}

module fDrawN(model, scales) {
  fDraw(model);
  points = fModelPoints(model);
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
