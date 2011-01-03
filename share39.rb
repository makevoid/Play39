path = File.expand_path "../", __FILE__
require 'sinatra'
APP_PATH = path

require "#{path}/config/env"

module IncludeInVoidtools
  def title(text)
    @title = text
    haml_tag :h2 do
      haml_concat text
    end
  end
end

include IncludeInVoidtools

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
end


helpers do
  def nav_link_to(label, options)
    haml_tag :li do
      link_to label, options
    end
  end
end


get "/" do
  haml :index
end

get '/css/main.css' do
  sass :main
end

get "/migrate" do
  DataMapper.auto_migrate!
  "db migrated!"
end

post "/reindex" do
  require 'id3lib'
  require 'iconv' 
  #repository.adapter.execute "TRUNCATE TABLE song_paths"
  SharedFile.all.each{ |f| f.destroy }
  Artist.all.each{ |f| f.destroy }
  SongPath.new.search.each do |path|
    tag = ID3Lib::Tag.new(path)
    infos = { title: tag.title, album: tag.album, artist: tag.artist, track: tag.track, bpm: tag.bpm, time: tag.time, genre: tag.genre }
    infos.each do |key, value|
      infos[key] = value.encode("UTF-8", undef: :replace) if value.is_a? String
    end
    artist_name = infos[:artist]
    artist_name.strip! unless artist_name.nil?
    infos.delete :artist
    artist = Artist.first(name: artist_name) 
    artist = Artist.create(name: artist_name) if artist.nil?
    image = tag.find{ |f| f[:id] == :APIC }
    unless image.nil?
      #data = [contents].pack("m").gsub(/\n/,"")
      #infos.merge!( image_data: "data:#{type};base64,#{data}" )
    end
    infos.merge!(name: File.basename(path, "*"), path: path)
    artist.shared_files.create(infos)
  end
  flash[:notice] = "indexed!"
  redirect "/settings"
end

get "/settings" do
  haml :settings
end

get "/songs" do
  @songs = Song.all(limit: 100)
  haml :songs
end

get "/artists" do
  @artists = Artist.all
  haml :artists
end

get "/artists/*" do |artist_id|
  @artist = Artist.get(artist_id)
  not_found if @artist.nil?
  @songs = @artist.songs
  haml :artist
end


get "/songs/search" do
  @songs = Song.all(:album.like => "%#{params[:query]}%") + Song.all(:artist.like => "%#{params[:query]}%") + Song.all(:title.like => "%#{params[:query]}%") 
  @songs = @songs.all(limit: 100)
  haml :songs
end

get "/songs/*" do |song_id|
  
  send_file "#{Song.get(song_id).path}"
end


get "/info" do
  
  "#{SongPath.new.search.first}"
end