class DirNotFound < Exception
  def message; ; end
end
class Path
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, unique: true
  
  # music path
  has n, :shared_files
  
  alias :songs :shared_files
  
  EXTS_PATHS = ["**/*.mp3", "**/*.ogg"] # 
  # matching: default "**/*" (all recursively), change to "*/*" to share only the directory
  # types: ?? others compatible?
  # TODO: attach a file converter from x to mp3, ogg (and other browser compatible ones) that could become handy!
  
  before :create do 
    raise DirNotFound.new(self.name) unless File.directory? self.name
  end
  
  def exts_paths
    EXTS_PATHS.map do |expath|
      "#{self.name}/#{expath}"
    end
  end
  alias :extension_paths :exts_paths
  
  def dir(full_path)
    full_path.gsub! self.name, ''
    # FIXME: possible windows bug for / \ in paths ?
    full_path.gsub! File.basename(full_path), ''
  end
end
