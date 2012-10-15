#!/usr/bin/env ruby
require "webrick"

include WEBrick

dir = Dir::pwd
port = 12000 + (dir.hash % 1000)

s = HTTPServer.new(
    :Port            => port,
    :DocumentRoot    => dir
)

trap("INT") { s.shutdown }
s.start
