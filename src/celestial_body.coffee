class @CelestialBody
  geometry = material = @mesh = @rotation = null

  constructor: (@radius, @distance, @period, @color) ->
    geometry = new THREE.SphereGeometry( @radius, 32, 16 )
    material = new THREE.MeshBasicMaterial( { color: @color, wireframe: true } )
    @mesh = new THREE.Mesh( geometry, material )
    @mesh.position.x = @distance
    @rotation = 0
    console.log @rotation

  animate: ->
    rotation_speed = 10.5 / 100
    @rotation += rotation_speed / @period

    @rotation -= 360.0 if @rotation >= 360.0
    t = @rotation * (Math.PI / 180.0)
    @mesh.position.x = @distance * Math.cos(t)
    @mesh.position.z = -(@distance * Math.sin(t))
