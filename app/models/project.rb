class Project < ActiveRecord::Base
  has_attached_file :photo, 
                    :styles => {:thumb=> "80x80#", :small  => "600x480>" },
                    :default_url => "/images/gravatar.jpg"    

  attr_accessible :name, :description, :kind, :photo
  
  has_and_belongs_to_many :users
                     
  validates :name,        :presence   => true
  validates :description, :presence   => true
  
  default_scope :order => 'projects.created_at DESC'
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

