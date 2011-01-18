class FileNotFound < Exception; end

class SharedFile
  include DataMapper::Resource

  property :id, Serial
  property :name, String, length: 255
  property :dir, String, length: 255, required: true
  property :format, String, length: 255
  property :plays, Integer, default: 0
  property :title, String, length: 255
  #property :artist, String, index: true, length: 200
  property :album, String, index: true, length: 255
  property :track, String, length: 50
  property :bpm, Integer
  property :time, String
  property :genre, String, index: true, length: 100
  property :type, String, default: "song", index: true
  property :image_data, Text 
  
  belongs_to :artist
  belongs_to :path
  has n, :stats
  
  def full_path
    File.expand_path "#{path.name}/#{self.dir}/#{self.name}#{self.format}"
  end
  
  before :create do 
    unless File.exists? full_path
      raise FileNotFound.new(full_path) 
    end
  end
end
