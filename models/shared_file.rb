class SharedFile
  include DataMapper::Resource

  property :id, Serial
  property :name, String, length: 255
  property :title, String, length: 255
  #property :artist, String, index: true, length: 200
  property :album, String, index: true, length: 255
  property :track, String, length: 10
  property :bpm, Integer
  property :time, String
  property :genre, String, index: true, length: 100
  property :path, String, length: 255
  property :type, String, default: "song", index: true
  property :image_data, Text 
  
  belongs_to :artist
end
