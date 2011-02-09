class Project < ActiveRecord::Base

  
  has_attached_file :photo, 
                    :styles => {:itsy => "30x30#", :teeny => "40x40#", :tiny=> "50x50#", :thumb => "60x60#", :standard=> "80x80#", :small=> "100x100#", :medium  => "140x180#", :feed => "450x300#", :huge  => "640x480>" },   
                    :storage => :s3,
                    :default_url => "/images/lightbulb.jpg",
                    :s3_credentials => "#{::Rails.root.to_s}/config/s3.yml", 
                    :path => "/:style/:filename"   

  has_and_belongs_to_many :pre_users
  has_and_belongs_to_many :users
  has_many :comments
  has_many :project_pages
  has_many :relationship_projects, :foreign_key => :followed_id
  has_many :followers, :through => :relationship_projects
                     
  validates :name,        :presence   => true
  
  scope :by_count, :order => 'projects.count DESC'
  
  acts_as_taggable
  acts_as_taggable_on :kind
  
  def to_param
    "#{id}-#{name.gsub(/[^a-z0-9]+/i, '-')}"      
  end

  class << self

    def search_by_name(query)
     where("name like ?", "%#{query}%").by_count | tagged_with("#{query}").by_count unless query.empty?
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
#  id                 :integer         not null, primary key
#  name               :string(255)
#  description        :text
#  kind               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  abstract           :string(255)
#  short              :text
#  progress           :text
#  press              :text
#  similar_projects   :text
#  page_1_name        :string(255)
#  page_1_content     :text
#  page_2_name        :string(255)
#  page_2_content     :text
#  page_3_name        :string(255)
#  page_3_content     :text
#

