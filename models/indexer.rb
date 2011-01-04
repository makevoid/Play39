class Indexer
  def new
    
  end
  
  def index
    require 'id3lib'
    require 'iconv' 
    # sqlite
    # repository.adapter.execute "DELETE FROM shared_files"
    # repository.adapter.execute "DELETE FROM artists"
    if ENV["RACK_ENV"] == "development"
      DataMapper.auto_migrate! 
      if File.directory?("/Volumes/backup")
        Path.create(name: "/Volumes/backup/Music/iTunes/iTunes\ Music")
      end
    end
    SharedFile.all.each{ |f| f.destroy }
    Artist.all.each{ |f| f.destroy }
    Path.all.each do |path|
      path.exts_paths.each do |expath|
        Dir.glob(expath).each do |song|
          SongTagger.new(path, song).tag
        end
      end
    end
  end
end