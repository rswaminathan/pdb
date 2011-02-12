class RelationshipUsersController < ApplicationController
	before_filter :authenticate

	def create
		@user = User.find_by_id(params[:relationship_user][:followed_id])
		current_user.follow_user!(@user)
		redirect_to @user
	end
	
	def destroy
		@user = RelationshipUser.find(params[:id]).followed
		current_user.unfollow_user!(@user)
		redirect_to current_user
	end
end
