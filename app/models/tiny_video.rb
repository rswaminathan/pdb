class TinyVideo < ActiveRecord::Base

  has_attached_file :original,
    :storage => :s3,
    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml", 
    :path => "/projects/video/:id/:style/:filename"   
  #, :path => "videos/:original/:id.:extension",

end
