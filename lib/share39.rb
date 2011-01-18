
class Share39
  VERSION = "0.1.1"
end

`cp #{Gem.path.first}/gems/share39-#{Share39::VERSION}/bin/share39 #{Gem.path.first}/bin`
`chmod 755 #{Gem.path.first}/bin/share39`


puts "test!"
