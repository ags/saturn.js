#!/usr/bin/env ruby
require "webrick"

WEBrick::HTTPServer.new(Port: 8000, DocumentRoot: Dir::pwd).tap do |s|
  trap("INT") { s.shutdown }
  s.start
end
