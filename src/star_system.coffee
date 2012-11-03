# http://mrdoob.github.com/three.js/examples/webgl_trackballcamera_earth.html
class @StarSystem
  stars = undefined

  constructor: (multiplier) ->
    geometry = new THREE.Geometry()

    for i in [0..500]
      vertex = new THREE.Vector3()
      vertex.x = Math.random() * 2 - 1
      vertex.y = Math.random() * 2 - 1
      vertex.z = Math.random() * 2 - 1
      vertex.multiplyScalar( multiplier )

      geometry.vertices.push( vertex )

    starsMaterials = [
      new THREE.ParticleBasicMaterial( { color: 0x555555, size: 2, sizeAttenuation: false } ),
      new THREE.ParticleBasicMaterial( { color: 0x555555, size: 1, sizeAttenuation: false } ),
      new THREE.ParticleBasicMaterial( { color: 0x333333, size: 2, sizeAttenuation: false } ),
      new THREE.ParticleBasicMaterial( { color: 0x3a3a3a, size: 1, sizeAttenuation: false } ),
      new THREE.ParticleBasicMaterial( { color: 0x1a1a1a, size: 2, sizeAttenuation: false } ),
      new THREE.ParticleBasicMaterial( { color: 0x1a1a1a, size: 1, sizeAttenuation: false } )
    ]

    for i in [10..30]
      stars = new THREE.ParticleSystem( geometry, starsMaterials[ i % 6 ] )

      stars.rotation.x = Math.random() * 6
      stars.rotation.y = Math.random() * 6
      stars.rotation.z = Math.random() * 6

      s = i * 10
      stars.scale.set( s, s, s )

      stars.matrixAutoUpdate = false
      stars.updateMatrix()

  addToScene: (scene) ->
    scene.add(stars)
