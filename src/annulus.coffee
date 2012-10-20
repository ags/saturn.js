class @Annulus extends THREE.Geometry

  constructor: (@inner_radius, @outer_radius, @stacks = 8, @slices = 32) ->
    THREE.Geometry.call( this )

    d = @outer_radius - @inner_radius
    segmentsY = @stacks
    segmentsX = @slices
    vertices = []
    uvs = []

    for y in [0..segmentsY]
      verticesRow = []
      uvsRow = []
      phi = y / (segmentsY - 1)

      for x in [0..segmentsX]
        theta = 2 * Math.PI * x / (segmentsX - 1)

        vertex = new THREE.Vector3()

        u = 1 - phi
        v = 1 - theta

        vertex.x = Math.cos(theta) * (@inner_radius + d * phi)
        vertex.y = Math.sin(theta) * (@inner_radius + d * phi)
        vertex.z = 0.0

        @vertices.push( vertex )

        verticesRow.push( @vertices.length - 1 )
        uvsRow.push( new THREE.UV( u, 1 - v ) )

      vertices.push( verticesRow )
      uvs.push( uvsRow )

    radius = @outer_radius
    for y in [0..segmentsY-1]
      for x in [0..segmentsX-1]
        v1 = vertices[ y ][ x + 1 ]
        v2 = vertices[ y ][ x ]
        v3 = vertices[ y + 1 ][ x ]
        v4 = vertices[ y + 1 ][ x + 1 ]

        n1 = @vertices[ v1 ].clone().normalize()
        n2 = @vertices[ v2 ].clone().normalize()
        n3 = @vertices[ v3 ].clone().normalize()
        n4 = @vertices[ v4 ].clone().normalize()

        uv1 = uvs[ y ][ x + 1 ].clone()
        uv2 = uvs[ y ][ x ].clone()
        uv3 = uvs[ y + 1 ][ x ].clone()
        uv4 = uvs[ y + 1 ][ x + 1 ].clone()

        if Math.abs( @vertices[ v1 ].y ) == radius
          @faces.push( new THREE.Face3( v1, v3, v4, [ n1, n3, n4 ] ) )
          @faceVertexUvs[ 0 ].push( [ uv1, uv3, uv4 ] )
        else if Math.abs( @vertices[ v3 ].y ) ==  radius
          @faces.push( new THREE.Face3( v1, v2, v3, [ n1, n2, n3 ] ) )
          @faceVertexUvs[ 0 ].push( [ uv1, uv2, uv3 ] )
        else
          @faces.push( new THREE.Face4( v1, v2, v3, v4, [ n1, n2, n3, n4 ] ) )
          @faceVertexUvs[ 0 ].push( [ uv1, uv2, uv3, uv4 ] )

    @computeCentroids()
    @computeFaceNormals()
