class Song < SharedFile
  
  default_scope(:default).update(type: "song")
  
end