class LikesController < ApplicationController
  
  def create
    @user = current_user
    @project = Project.find(params[:project_id])
	unless likes_project?(@user, @project, params[:like])
		@like = Like.new
		@like.like = params[:like]
		@like.project = @project
		@like.user = @user
		if @like.save
		  flash[:success] = "Saved"
		else
		  flash[:error] = "Error"
		end
	end
	redirect_to(root_path, :search => params[:search])
  end
end
