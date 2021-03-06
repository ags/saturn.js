class Simulation
  camera = scene = renderer = stats = controls = undefined
  celestial_bodies = []
  current_body = 0

  FOV = 65
  ASPECT = window.innerWidth / window.innerHeight
  CLIP_FAR = 3560000 * 2.0 # double iapetus distance
  CLIP_NEAR = CLIP_FAR / 100000.0

  SATURN_INDEX = 0

  constructor: ->
    @initBodies(celestial_properties)

    camera = new THREE.PerspectiveCamera(FOV, ASPECT, CLIP_NEAR, CLIP_FAR)
    camera.position.z = celestial_bodies[SATURN_INDEX].radius * 5
    camera.position.y = 45000

    controls = new THREE.TrackballControls( camera )
    controls.target.set( 0, 0, 0 )
    controls.zoomSpeed = 0.2

    scene = new THREE.Scene()

    @initLights()

    @initGeometry()

    document.addEventListener("keydown", @onKeyDown, false)

    renderer = new THREE.WebGLRenderer({antialias: true})
    renderer.setSize(window.innerWidth, window.innerHeight)
    document.body.appendChild(renderer.domElement)

    @initStats()

  initBodies: (celestial_properties) ->
    for properties in celestial_properties
      celestial_bodies.push(new CelestialBody(properties))

  initLights: ->
    directionalLight = new THREE.DirectionalLight( 0xffffff, 0.5 )
    directionalLight.position.set( 1, 0, 1 )
    scene.add(directionalLight)

    scene.add(new THREE.AmbientLight( 0x333333 ))

  initGeometry: ->
    new StarSystem(celestial_bodies[SATURN_INDEX].radius / 2).addToScene(scene)
    for body in celestial_bodies
      body.addToScene(scene)

  initStats: ->
    stats = new Stats()
    stats.domElement.style.position = 'absolute'
    stats.domElement.style.top = '0px'
    document.body.appendChild(stats.domElement)

  animate: (time) =>
    requestAnimationFrame(@animate)

    for body in celestial_bodies
      body.animate(time)

    if current_body != SATURN_INDEX
      t = celestial_bodies[current_body].rotation * (Math.PI / 180.0)
      camera.position.x = celestial_bodies[current_body].distance * Math.cos(t)
      camera.position.z = -(celestial_bodies[current_body].distance * Math.sin(t))

    @render()

  render: =>
    controls.update()
    renderer.render(scene, camera)
    stats.update()

  onKeyDown: (event) =>
    switch event.keyCode
      when 69
        @focusOnNextBody()
      else
        console.log event.keyCode

  focusOnNextBody: ->
    current_body = (current_body + 1) % celestial_bodies.length

(new Simulation).animate(new Date().getTime())
