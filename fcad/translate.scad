function fTranslate(model, translation) = (
  fModel(
    points=
      [for (point = fModelPoints(model))
        [for (axis = [0 : 2])
         point[axis] + translation[axis]]
      ],
    faces=fModelFaces(model)
  )
);

function fZeroN(model, scales) = (
  let(model_min = fMinPoint(model),
      translation =
        [for (axis = [0 : 2])
         scales[axis] * model_min[axis]])
  fTranslate(model, translation)
);

function fZeroX(model) = (
  fZeroN(model, [-1, 0, 0])
);

function fZeroY(model) = (
  fZeroN(model, [0, -1, 0])
);

function fZeroZ(model) = (
  fZeroN(model, [0, 0, -1])
);

function fCenterN(model, scales) = (
  let(model_center = fCenterPoint(model),
      translation =
        [for (axis = [0 : 2])
        scales[axis] * model_center[axis]])
  fTranslate(model, translation)
);

function fCenterX(model) = (
  fCenterN(model, [-1, 0, 0])
);

function fCenterY(model) = (
  fCenterN(model, [0, -1, 0])
);

function fCenterZ(model) = (
  fCenterN(model, [0, 0, -1])
);
