class @RingGeometry

  THREE.Geometry.call( this )
  vertices = [], uvs = []

  constructor: (@inner_radius, @outer_radius, @stacks = 8, @slices = 1) ->

    d = @outer_radius - @inner_radius

    for i in [0..@stacks]
      phi = i / (@stacks - 1)
      for slice in [0..@slices]
        theta = 2 * Math.PI * slice / (@slices - 1)
        x = Math.cos(theta) * (@inner_radius + d * phi)
        y = Math.sin(theta) * (@inner_radius + d * phi)
        
        [i][slice].x = x
        [i][slice].y = y
        [i][slice].z = 0.0

