class @CelestialBody
  geometry = material = @mesh = rotation = null

  constructor: (@radius, @distance, @period, @color, ring) ->
    geometry = new THREE.SphereGeometry(@radius, 32, 16)

    if ring
      material = new THREE.MeshLambertMaterial(
        map: THREE.ImageUtils.loadTexture("textures/saturn.jpg"),
        wirefame: false,
        color: 0xff0000,
        overdraw: true
      )
    else
      material = new THREE.MeshBasicMaterial({ color: @color, wireframe: true })

    @mesh = new THREE.Mesh( geometry, material )
    @mesh.position.x = @distance
    rotation = 0

    if ring
      @ring = new Ring(this, ring["inner_radius"], ring["outer_radius"])

  addToScene: (scene) ->
    scene.add(@mesh)
    if @ring
      @ring.addToScene(scene)

  animate: ->
    rotation_speed = 10.5 / 100
    rotation += rotation_speed / @period

    rotation -= 360.0 if @rotation >= 360.0
    t = rotation * (Math.PI / 180.0)
    @mesh.position.x = @distance * Math.cos(t)
    @mesh.position.z = -(@distance * Math.sin(t))
