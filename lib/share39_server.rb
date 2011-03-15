require 'haml'
require 'sass'
require 'sinatra/base'

path = File.expand_path "../", __FILE__
APP_PATH = path


class Object
  ##
  #   @person ? @person.name : nil
  # vs
  #   @person.try(:name)
  def try(method)
    send method if respond_to? method
  end
  
  def anil?
    self.nil? || self == []
  end
  
  def blank?
    self.nil? || self == ''
  end
  
  def ton_i
    self.to_i unless self == ""
  end
  
  def log_errors_for(objects, &block)
    errs = objects.errors.map{ |e| e }
    unless errs == []
      puts errs.join(", ")
      yield unless block.nil?
    end
  end
end


class Share39 < Sinatra::Base
  require "#{APP_PATH}/config/env"
  
  set :haml, { :format => :html5 }
  require 'rack-flash'
  enable :sessions
  use Rack::Flash
  use Rack::Static, :root => "#{APP_PATH}/public"
  
  use Rack::MethodOverride # put and delete requests
  
  MAIN_CSS = "#{APP_PATH}/public/css/main.css"
  
  module IncludeInVoidtools
    def title(text)
      @title = text
      haml_tag :h2 do
        haml_concat text
      end
    end
    

  end

  include IncludeInVoidtools
  def self.init_voidtools
    `rm -f #{MAIN_CSS}` if ENV["RACK_ENV"] == "development"
  end
  init_voidtools
  


  def halt_not_found
    halt 404, 'Page not found!'
  end


  helpers do
    def nav_link_to(label, options)
      haml_tag :li do
        link_to label, options
      end
    end
  end

  # main
  MAIN_CSS
  get "/" do
    #File.delete MAIN_CSS if File.mtime(MAIN_CSS) > File.mtime("#{APP_PATH}/views/main.sass")+1
    haml :index
  end

  get '/css/main.css' do
    path = MAIN_CSS
    file_exist = File.exist? path
    if file_exist
      sass = File.read path 
    else
      File.open(path, "w") do |f|
        sass = sass(:main)
        f.write sass
      end
    end

    sass
  end
  
  # TODO: move into a rake task 
  
  get "/migrate" do
    DataMapper.auto_migrate!
    File.delete MAIN_CSS
    flash[:notice] = "DB migration complete!"
    redirect "/"
  end

end

require "#{APP_PATH}/controllers/settings"
require "#{APP_PATH}/controllers/songs"