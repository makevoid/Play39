path = File.expand_path "../", __FILE__


# use Rack::Static, :root => "#{path}/public"

require "#{path}/share39_server"
run Share39
