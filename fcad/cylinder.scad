function fCylinder(h, r, r1=undef, r2=undef, sides=36) = (
  let(degrees_per_side = 360 / sides,
      side_range = [0 : sides - 1],
      int_r1 = (r1 == undef) ? r : r1,
      int_r2 = (r2 == undef) ? r : r2)
  fModel(
    points=
      [for (side = side_range)
       for (params = [[int_r1, 0], [int_r2, h]])
       let (angle = side * degrees_per_side,
            radius = params[0],
            height = params[1])
        [radius * sin(angle), radius * cos(angle), height]],
    faces=concat(
      // bottom
      [[for (side = [sides : -1 : 0]) side * 2]],
      // top
      [[for (side = [0 : sides]) side * 2 + 1]],
      // sides
      [for (side = side_range)
        [for (vertex = [2, 3, 1, 0]) (side * 2 + vertex) % (sides * 2)]]
    )
  )
);
