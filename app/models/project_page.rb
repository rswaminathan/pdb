class Project_Page < ActiveRecord::Base

  belongs_to :project
  has_many :comment
  
end
