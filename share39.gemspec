path = File.expand_path("../lib", __FILE__)
$:.unshift(path) unless $:.include?(path)
require "#{path}/share39"

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'share39'
  s.version     = Share39::VERSION
  s.summary     = 'Personal music sharing server'
  s.description = 'Share 39 - Personal music sharing server (aka: sinatra app to share and stream mp3s)'

  s.author            = "Francesco 'makevoid' Canessa"
  s.email             = 'makevoid@gmail.com'
  s.homepage          = 'http://www.makevoid.com'
  # s.rubyforge_project = ''
  # list of 

  s.files        = Dir['README.md', 'Rakefile', 'lib/**/*', 'bin/**/*']
  s.require_path = 'lib'
end