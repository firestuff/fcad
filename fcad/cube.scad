function fCube(dims) = (
  let(x = fIsVector(dims) ? dims[0] : dims,
      y = fIsVector(dims) ? dims[1] : dims,
      z = fIsVector(dims) ? dims[2] : dims)
  fModel(
    points=fCartesianProduct([[0, x], [0, y], [0, z]]),
    faces=[
      [0, 2, 3, 1], // -x
      [0, 1, 5, 4], // -y
      [0, 4, 6, 2], // -z
      [4, 5, 7, 6], // +x
      [2, 6, 7, 3], // +y
      [1, 3, 7, 5], // +z
    ],
    coords=[
      [ "/x+,/y+,-z+", fCoord(translation=[x / 2, y / 2, 0]) ],
      [ "/x+,/y+,+z+", fCoord(translation=[x / 2, y / 2, z]) ],
    ]
  )
);
