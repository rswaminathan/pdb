class Project < ActiveRecord::Base
  index do
    name
    description
    kind
    abstract
  end

  has_attached_file :photo, 
                    :styles => {:itsy => "30x30#", :teeny => "40x40#", :tiny=> "50x50#", :thumb => "60x60#", :standard=> "80x80#", :medium=> "100x100#", :small  => "640x480>" },   
                    :storage => :s3,
                    :default_url => "/images/lightbulb.jpg",
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                    :path => "/:style/:filename"   

  
  has_and_belongs_to_many :users
  has_many :comments
  has_many :project_pages
  has_many :relationship_projects, :foreign_key => :followed_id
  has_many :followers, :through => :relationship_projects
                     
  validates :name,        :presence   => true
  
  default_scope :order => 'projects.created_at DESC'
  
  acts_as_taggable
  acts_as_taggable_on :kind
  
  class << self
    def search_by_name(query)
     where("name like ?", "%#{query}%")
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

