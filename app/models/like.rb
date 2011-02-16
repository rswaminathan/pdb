class Like < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  scope :awesome,     where(:description => 'awesome')
  scope :interesting, where(:description => 'interesting')
end

# == Schema Information
#
# Table name: likes
#
#  id          :integer         primary key
#  project_id  :integer
#  user_id     :integer
#  description :string(255)
#  created_at  :timestamp
#  updated_at  :timestamp
#

