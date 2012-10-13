vendors = [
  "vendor/three.min"
]

classes = [
  "celestial_properties"
  "celestial_body"
]

require vendors, ->
  require classes, ->
    require ["simulation"]
