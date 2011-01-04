class SongTagger
  def initialize(path, song_path)
    @path = path
    @song_path = song_path
  end
  
  def tag
    tag = ID3Lib::Tag.new(@song_path)
    length = tag.find{ |f| f[:id] == :TLEN }
    unless length.nil?
      length = Time.at(length[:text].to_i/1000) 
      length = "#{length.min}:#{length.sec}"
    end
    infos = { title: tag.title, album: tag.album, artist: tag.artist, track: tag.track, bpm: tag.bpm.ton_i, time: length, genre: tag.genre}
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
      image = image[:text]
      #data = [contents].pack("m").gsub(/\n/,"")
      #infos.merge!( image_data: "data:#{type};base64,#{data}" )
    end
    infos.merge!(name: File.basename(@song_path, ".*"), format: File.extname(@song_path), path: @path, dir: @path.dir(@song_path))
    files = artist.shared_files.create(infos)
    log_errors_for(files)
  end
end