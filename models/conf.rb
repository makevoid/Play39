class Conf
  include DataMapper::Resource
  
  property :id, Serial
  property :name, String
  property :value, String
  
  # music path
  
end
