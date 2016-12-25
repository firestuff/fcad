function fMinPoint(model) = (
  [for (axis = [0 : 2])
   min([for (point = fPoints(model)) point[axis]])]
);

function fMaxPoint(model) = (
  [for (axis = [0 : 2])
   max([for (point = fPoints(model)) point[axis]])]
);

function fCenterPoint(model) = (
  let(model_min = fMinPoint(model),
      model_max = fMaxPoint(model),
      model_size =
        [for (axis = [0 : 2])
         model_max[axis] - model_min[axis]])
  [for (axis = [0 : 2])
   model_min[axis] + (model_size[axis] / 2)]
);
