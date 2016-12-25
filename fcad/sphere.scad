function fSphere(r, sides=36, stripes=18) = (
  let(degrees_per_slice = 180 / stripes,
      degrees_per_side = 360 / sides,
      top_index = (stripes - 1) * sides)
  [
    [fKeyPoints, concat(
      [for (stripe_index = [1 : stripes - 1])
       for (side_index = [0 : sides - 1])
       let (stripe_angle = stripe_index * degrees_per_slice,
            side_angle = side_index * degrees_per_side,
            stripe_radius = r * sin(stripe_angle),
            stripe_z = r * cos(stripe_angle),
            side_x = stripe_radius * sin(side_angle),
            side_y = stripe_radius * cos(side_angle))
        [side_x, side_y, stripe_z]
      ],
      [
        [0, 0, r],  // top
        [0, 0, -r],  // bottom
      ]
    )],
    [fKeyFaces, concat(
      // side squares
      [for (stripe_index = [2 : stripes - 1])
       for (side_index = [0 : sides - 1])
       let (prev_side_base = (stripe_index - 2) * sides,
            side_base = (stripe_index - 1) * sides)
        [
          prev_side_base + (side_index + 1) % sides,
          prev_side_base + side_index,
          side_base + side_index,
          side_base + (side_index + 1) % sides,
        ]
      ],
      // top triangles
      [for (side_index = [0 : sides - 1])
        [
          top_index,
          side_index,
          (side_index + 1) % sides,
        ]
      ],
      // bottom triangles
      [for (side_index = [0 : sides - 1])
       let (side_base = (stripes - 2) * sides)
        [
          top_index + 1,
          side_base + (side_index + 1) % sides,
          side_base + side_index,
        ]
      ]
    )],
  ]
);
