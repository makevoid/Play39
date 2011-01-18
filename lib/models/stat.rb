class Stat
  include DataMapper::Resource
  
  property :id, Serial
  property :ip, String
  
  belongs_to :shared_file
  alias :song :shared_file
end
