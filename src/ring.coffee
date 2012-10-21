class @Ring
  @mesh = null
  rotation = 0

  constructor: (@body, @inner_radius, @outer_radius) ->
    geometry = new Annulus(@inner_radius, @outer_radius, 8, 64)

    material = new THREE.MeshLambertMaterial(
      map: THREE.ImageUtils.loadTexture("textures/ring.png"),
      wirefame: false,
      side: THREE.DoubleSide
    )

    @mesh = new THREE.Mesh( geometry, material )
    @mesh.position.x = @body.mesh.position.x
    @mesh.rotation.x = 270 * Math.PI / 180

  addToScene: (scene) ->
    scene.add(@mesh)

  animate: ->
    rotation += 0.005
    rotation -= 360.0 if rotation >= 360.0
    @mesh.rotation.z = rotation
