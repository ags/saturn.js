class Simulation
  camera = scene = renderer = stats = controls = null
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

    renderer = new THREE.WebGLRenderer()
    renderer.setSize(window.innerWidth, window.innerHeight)
    document.body.appendChild(renderer.domElement)

    @initStats()

  # http://mrdoob.github.com/three.js/examples/webgl_trackballcamera_earth.html
  initStars: ->
    starsGeometry = new THREE.Geometry()

    for i in [0..1500]
      vertex = new THREE.Vector3()
      vertex.x = Math.random() * 2 - 1
      vertex.y = Math.random() * 2 - 1
      vertex.z = Math.random() * 2 - 1
      vertex.multiplyScalar( celestial_bodies[SATURN_INDEX].radius )

      starsGeometry.vertices.push( vertex )

    starsMaterials = [
      new THREE.ParticleBasicMaterial( { color: 0x555555, size: 2, sizeAttenuation: false } ),
      new THREE.ParticleBasicMaterial( { color: 0x555555, size: 1, sizeAttenuation: false } ),
      new THREE.ParticleBasicMaterial( { color: 0x333333, size: 2, sizeAttenuation: false } ),
      new THREE.ParticleBasicMaterial( { color: 0x3a3a3a, size: 1, sizeAttenuation: false } ),
      new THREE.ParticleBasicMaterial( { color: 0x1a1a1a, size: 2, sizeAttenuation: false } ),
      new THREE.ParticleBasicMaterial( { color: 0x1a1a1a, size: 1, sizeAttenuation: false } )
    ]

    for i in [10..30]
      stars = new THREE.ParticleSystem( starsGeometry, starsMaterials[ i % 6 ] )

      stars.rotation.x = Math.random() * 6
      stars.rotation.y = Math.random() * 6
      stars.rotation.z = Math.random() * 6

      s = i * 10
      stars.scale.set( s, s, s )

      stars.matrixAutoUpdate = false
      stars.updateMatrix()

      scene.add( stars )

  initBodies: (celestial_properties) ->
    for properties in celestial_properties
      celestial_bodies.push(new CelestialBody(properties))

  initLights: ->
    directionalLight = new THREE.DirectionalLight( 0xffffff, 0.5 )
    directionalLight.position.set( 1, 0, 1 )
    scene.add(directionalLight)

    scene.add(new THREE.AmbientLight( 0x333333 ))

  initGeometry: ->
    @initStars()
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
