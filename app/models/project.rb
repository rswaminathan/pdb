class Project < ActiveRecord::Base
  index do
    name
    description
    kind
  end

  has_attached_file :photo, 
                    :styles => {:thumb=> "80x80#", :small  => "640x480>" },   
                    :storage => :s3,
                    :default_url => "/images/lightbulb.jpg",
                    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                    :path => "/:style/:filename"   

  
  has_and_belongs_to_many :users
  has_many :comments
                     
  validates :name,        :presence   => true
  
  default_scope :order => 'projects.created_at DESC'
  
  acts_as_taggable
  acts_as_taggable_on :kind
end

# == Schema Information
#
# Table name: projects
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  kind        :string(255)
#  user_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#

