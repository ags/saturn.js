class Simulation
  camera = scene = renderer = null
  celestial_bodies = []
  current_body = 0

  FOV = 65
  ASPECT = window.innerWidth / window.innerHeight
  CLIP_FAR = 3560000 * 2.1
  #CLIP_FAR = celestial_properties["iapetus"]["distance"] * 2.1
  CLIP_NEAR = CLIP_FAR / 10000.0

  SATURN_INDEX = 0
  TITAN_INDEX = 2

  constructor: ->
    @initBodies(celestial_properties)

    camera = new THREE.PerspectiveCamera(FOV, ASPECT, CLIP_NEAR, CLIP_FAR)
    camera.position.z = celestial_bodies[SATURN_INDEX].radius * 4
    camera.position.y = 30000

    scene = new THREE.Scene()

    @initGeometry()

    renderer = new THREE.CanvasRenderer()
    renderer.setSize( window.innerWidth, window.innerHeight )

    document.addEventListener("keydown", @onKeyDown, false)

    document.body.appendChild( renderer.domElement )

  initGeometry: ->
    for body in celestial_bodies
      body.addToScene(scene)

  initBodies: (celestial_properties) ->
    for properties in celestial_properties
      celestial_bodies.push(new CelestialBody(
        properties["radius"]
        properties["distance"]
        properties["period"]
        properties["color"]
        properties["ring"]
      ))

  animate: (time) =>
    requestAnimationFrame(@animate)

    for body in celestial_bodies
      body.animate(time)

    @render()

  render: =>
    renderer.render(scene, camera)

  onKeyDown: (event) =>
    switch event.keyCode
      when 69
        @focusOnNextBody()
      else
        console.log event.keyCode

  focusOnNextBody: ->
    current_body = (current_body + 1) % celestial_bodies.length
    console.log current_body
    zoom_body = if current_body == SATURN_INDEX then SATURN_INDEX else TITAN_INDEX
    camera.position.x = celestial_bodies[current_body].mesh.position.x
    camera.position.z = celestial_bodies[zoom_body].radius * 4

(new Simulation).animate(new Date().getTime())
