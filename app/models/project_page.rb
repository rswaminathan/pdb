class ProjectPage < ActiveRecord::Base
  belongs_to :project
  has_many :sections

end


# == Schema Information
#
# Table name: project_pages
#
#  id         :integer         primary key
#  title      :string(255)
#  content    :text
#  project_id :integer
#  created_at :timestamp
#  updated_at :timestamp
#

