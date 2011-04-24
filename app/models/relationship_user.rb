class RelationshipUser < ActiveRecord::Base
	attr_accessible :followed_id
	
	belongs_to :follower, :class_name => "User"
	belongs_to :followed, :class_name => "User"
	
	validates :follower_id, :presence => true
	validates :followed_id, :presence => true
end

# == Schema Information
#
# Table name: relationship_users
#
#  id          :integer         primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :timestamp
#  updated_at  :timestamp
#

