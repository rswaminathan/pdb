class RelationshipProjectsController < ApplicationController
	before_filter :authenticate

	def create
		@project = Project.find(params[:relationship_project][:followed_id])
		current_user.follow_project!(@project)
		redirect_to @project
	end
	
	def destroy
		@project = RelationshipProject.find(params[:id]).followed
		current_user.unfollow_project!(@project)
		redirect_to current_user
	end
end
