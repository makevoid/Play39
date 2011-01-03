class SongPath
  
  # DEFAULT = File.expand_path "~/Music/iTunes/iTunes\ Music"
  DEFAULT = "/Volumes/backup/Music/iTunes/iTunes\ Music"
  
  def search
    Dir.glob("#{DEFAULT}/**/*.mp3")
  end
  

end

# p SongPath.new.search
# p SongPath.new.search.size

