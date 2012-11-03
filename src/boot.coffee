vendors = [
  "vendor/three.min"
  "vendor/stats.min"
]

classes = [
  "star_system"
  "celestial_properties"
  "annulus"
  "ring"
  "celestial_body"
]

require vendors, ->
  require classes, ->
    require ["simulation"]
