vendors = [
  "vendor/three.min"
]

classes = [
  "celestial_properties"
  "ring"
  "celestial_body"
]

require vendors, ->
  require classes, ->
    require ["simulation"]
