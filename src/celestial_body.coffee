class @CelestialBody
  geometry = material = @mesh = null
  rotation = 0
  rotation_speed = 10.5 / 100

  constructor: (properties) ->
    @radius = properties["radius"]
    @distance = properties["distance"]
    @period = properties["period"]
    @color = properties["color"]
    ring = properties["ring"]
    geometry = new THREE.SphereGeometry(@radius, 16, 16)

    if ring
      material = new THREE.MeshLambertMaterial(
        map: THREE.ImageUtils.loadTexture("textures/saturn.jpg")
        wirefame: false,
        overdraw: true
      )
    else
      material = new THREE.MeshLambertMaterial({ color: @color, wireframe: false })

    @mesh = new THREE.Mesh( geometry, material )
    @mesh.position.x = @distance

    if ring
      @ring = new Ring(this, ring["inner_radius"], ring["outer_radius"])

  addToScene: (scene) ->
    scene.add(@mesh)
    if @ring
      @ring.addToScene(scene)

  animate: ->
    rotation += rotation_speed / @period

    rotation -= 360.0 if rotation >= 360.0
    t = rotation * (Math.PI / 180.0)
    @mesh.position.x = @distance * Math.cos(t)
    @mesh.position.z = -(@distance * Math.sin(t))

    if @ring
      @ring.animate()
