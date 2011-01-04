class Share39 < Sinatra::Base

get "/songs" do
  @songs = Song.all(limit: 50)
  haml :songs
end

get "/stats" do
  @stats = Stat.all(limit: 50)
  haml :stats
end

get "/artists" do
  @artists = Artist.all
  haml :artists
end

get "/artists/*" do |artist_id|
  @artist = Artist.get(artist_id)
  halt_not_found if @artist.nil?
  @songs = @artist.songs
  haml :artist
end

get "/songs/search" do
  halt_not_found if params[:query].blank?
  query = "%#{params[:query]}%"
  @songs = Song.all(:album.like => query) + Song.all(:title.like => query) + Artist.all(:name.like => query).shared_files
  @songs = @songs.all(limit: 50)
  haml :songs
end

get "/songs/*" do |song_id|
  @song = Song.get(song_id)
  halt_not_found if @song.nil?
  #Thread.abort_on_exception = true
  #Thread.new {
    stat = Stat.last
    if stat.nil? || stat.ip != request.ip || stat.song != @song
      stat = @song.stats.create(ip: request.ip) 
      log_errors_for(stat)
    end
  #}
  send_file @song.full_path
end

end