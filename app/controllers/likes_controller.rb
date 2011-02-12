class LikesController < ApplicationController
  
  def create
    @project = Project.find(params[:project_id])
	unless likes_project?(current_user, @project, params[:description])
		@like = Like.new
		@like.description = params[:description]
		@like.project = @project
		@like.user = current_user
		if @like.save
		  if @like.description = "know_more"
		    flash[:success] = "Saved"
            # send an email to the project owner
            @project.users.each do |user|
              UserMailer.know_more(current_user, user, @project).deliver
            end
          end
		else
		  flash[:error] = "Error"
		end
	end
  end
end
