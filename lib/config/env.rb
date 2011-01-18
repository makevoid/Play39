require 'bundler'
require 'bundler/setup'

app_path = File.expand_path "../../", __FILE__


require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'dm-sqlite-adapter'

DataMapper.setup :default, "sqlite://#{app_path}/db/share39.sqlite"


Dir.glob("#{app_path}/models/*").each do |model|
  require model
end

if defined? Sinatra
  require 'voidtools'
  include Voidtools::Sinatra::ViewHelpers
end