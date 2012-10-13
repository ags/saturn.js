class @CelestialBody
  geometry = material = @mesh = null

  constructor: (@radius, @distance, @color) ->
    geometry = new THREE.SphereGeometry( @radius, 32, 16 )
    material = new THREE.MeshBasicMaterial( { color: @color, wireframe: true } )
    @mesh = new THREE.Mesh( geometry, material )
    @mesh.position.x = @distance

  animate: ->
    @mesh.rotation.y += 0.02
