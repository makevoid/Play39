class Artist
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String, length: 200
  
  has n, :shared_files
  has n, :songs
end
