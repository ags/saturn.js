class @Ring
  @mesh = null

  constructor: (@body, @inner_radius, @outer_radius) ->
    geometry = new THREE.CylinderGeometry(@outer_radius, @outer_radius, 100, 32, 8, false)
    material = new THREE.MeshBasicMaterial({ color: 0xcccccc, wireframe: true })
    # material = new THREE.MeshLambertMaterial(
    #   map: THREE.ImageUtils.loadTexture("textures/ring.png"),
    #   wirefame: false,
    #   overdraw: true
    # )
    @mesh = new THREE.Mesh( geometry, material )
    @mesh.position.x = @body.mesh.position.x
  
  addToScene: (scene) ->
    scene.add(@mesh)
