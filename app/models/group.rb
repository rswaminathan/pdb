class Group < ActiveRecord::Base
  validates :name, :presence => true
  
  has_attached_file :photo, 
                    :styles => {:itsy => "30x30#",:standard=> "120x90#", :large => "715x200#"},
                    :default_url => "/images/wally_profile-tiny.jpg",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                    :path => "/groups/photo/:id/:style/:filename"    

  has_attached_file :banner, 
                    :styles => {:standard => "120x90#", :banner =>"220x80"},
                    :default_url => "/images/wally_profile-tiny.jpg",
                    :storage => :s3,
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                    :path => "/groups/banners/:id/:style/:filename"      
  has_and_belongs_to_many :projects

  has_many :users, :through => :group_relations
  has_many :group_relations, :foreign_key => :group_id, :dependent => :destroy

  
  scope :by_count, :order => 'projects.count DESC'
  
  class << self
  
    def search_by_name(query)
     Group.search(:name_contains => query).all
    end
    
  end
end
