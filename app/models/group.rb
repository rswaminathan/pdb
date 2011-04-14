class Group < ActiveRecord::Base
  validates :name, :presence => true
  
  has_attached_file :photo, 
                    :styles => {:itsy => "30x30#",:standard=> "120x90#", :large => "715x200"},
                    :default_url => "/images/wally_profile-tiny.jpg",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                    :path => "/groups/photo/:id/:style/:filename"    

  has_attached_file :banner, 
                    :styles => {:standard => "120x90", :banner =>"160x60"},
                    :default_url => "/images/wally_profile-tiny.jpg",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                    :path => "/groups/banners/:id/:style/:filename"    
  
  
  has_and_belongs_to_many :projects
  has_and_belongs_to_many :users
  has_and_belongs_to_many :admins, :class_name => "User"
  
end
