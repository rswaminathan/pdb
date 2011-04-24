class Comment < ActiveRecord::Base

  belongs_to :user
  belongs_to :project
  belongs_to :project_pages
  
end


# == Schema Information
#
# Table name: comments
#
#  id         :integer         primary key
#  body       :string(255)
#  user_id    :integer
#  project_id :integer
#  created_at :timestamp
#  updated_at :timestamp
#

