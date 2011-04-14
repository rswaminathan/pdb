class Project < ActiveRecord::Base

  
  has_attached_file :photo, 
                    :styles => {:itsy => "30x30#", :tiny=> "50x50#", :standard=> "120x90#", :feed => "450x300#"},   
                    :storage => :s3,
                    :default_url => "/images/lightbulb.jpg",
                    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml", 
                    :path => "/:style/:filename"   

  has_attached_file :mainfile, 
                     :storage => :s3,
                     :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                     :path => "/:style/:filename"    


  has_and_belongs_to_many :pre_users
  has_and_belongs_to_many :users
  
  has_and_belongs_to_many :groups
  
  has_many :attachments
  has_many :comments
  has_many :links
  has_many :project_pages
  has_many :relationship_projects, :foreign_key => :followed_id
  has_many :followers, :through => :relationship_projects
  has_many :likes

  accepts_nested_attributes_for :links, :allow_destroy => true
  accepts_nested_attributes_for :groups
  accepts_nested_attributes_for :attachments

  validates :name,        :presence   => true
  
  scope :by_count, :order => 'projects.count DESC'
  #todo: check if sql injection possible
  scope :by_group, lambda{|g| joins(:groups).where(:groups => g) if !g.nil?}
  
  acts_as_taggable
  acts_as_taggable_on :kind
  
  attr_reader :collaborator_tokens
  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"      
  end

  def similar_projects
    Project.tagged_with(kind_list, :any => true)
  end

  def more_projects_by_team
    return "hi"
  end
  
    
  def collaborator_tokens=(ids)
    self.user_ids = ids.split(",")
  end

  class << self

    def search_by_name(query)
     Project.search(:name_contains => query).all | tagged_with("#{query}").by_count unless query.empty?
    end
		
    def random
      all[rand(Project.count)] 
    end
  end
     
     
end




# == Schema Information
#
# Table name: projects
#
#  id                    :integer         primary key
#  name                  :string(255)
#  description           :text
#  kind                  :string(255)
#  created_at            :timestamp
#  updated_at            :timestamp
#  photo_file_name       :string(255)
#  photo_content_type    :string(255)
#  photo_file_size       :integer
#  abstract              :string(255)
#  count                 :integer
#  mainfile_file_name    :string(255)
#  mainfile_content_type :string(255)
#  mainfile_file_size    :integer
#

