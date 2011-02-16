class RelationshipProject < ActiveRecord::Base
	attr_accessible :followed_id
	
	belongs_to :follower, :class_name => "User"
	belongs_to :followed, :class_name => "Project"
		
	validates :follower_id, :presence => true
	validates :followed_id, :presence => true
end

# == Schema Information
#
# Table name: relationship_projects
#
#  id          :integer         primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :timestamp
#  updated_at  :timestamp
#

