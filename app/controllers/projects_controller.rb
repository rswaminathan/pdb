class ProjectsController < ApplicationController
	
	before_filter :authenticate, 			:only => [:new, :create]
	#before_filter :correct_project_user,	:only => [:edit, :update, :destroy]
	before_filter :correct_project_user,	:only => [:edit_collaborators, :update_collaborators, :delete_collaborators, :new_page, :edit_page, :update_page, :edit, :update, :destroy]
	
	def new
		@title = "New Project"
		@project = current_user.projects.build
	end

	def create
		@project = current_user.projects.build(params[:project]);
		if @project.save
			current_user.projects << @project
			flash[:success] = "Project added!"
			redirect_to @project
		else
			render 'new'
		end
	end

	def show
		@project = Project.find_by_id(params[:id])
		@users = @project.users
		@comments = @project.comments
		@pages = @project.project_pages
		if !params[:page].nil?
			@page_content = @project.project_pages.find_by_title(params[:page]).content
		else
			@page_content = @project.description
		end
	end

	def destroy
		@project.destroy #@project is defined in correct_user authenticate
		flash[:success] = "Project deleted"
		redirect_to current_user
	end

	def search
		if params[:q].nil? 
			@projects = []
		else
			@projects = Project.search(params[:q])
		end
	end

	def edit
		@title = "Edit Project"
		@comments = @project.comments
		@pages = @project.project_pages
		@project_page = @project.project_pages
	end

	def update(redirect=nil)
		if @project.update_attributes(params[:project])
			flash[:success] = "Project updated!"
			redirect_to(redirect || @project) 
		else
			#flash[:error] = "Something went wrong, try again"
			render 'edit'
		end 
	end

	def edit_collaborators
		@title = "Edit Collaborators"
		@comments = @project.comments 
		@collaborators_found = User.search_by_name(params[:search])
	end

	def invite_collaborator
	end

	def update_collaborators
		user_to_add = User.find(params[:user_to_add])
		if (user_to_add.nil? || @users.exists?(user_to_add))
			flash.now[:error] = "Cannot find user / Duplicate user" 
		else
			@project.users << user_to_add
			@project.save
			flash.now[:success] = "Added collaborator"
		end   
		render 'edit_collaborators'
	end

	def delete_collaborators
		user_to_delete = User.find_by_id(params[:user_id])
		if (user_to_delete.nil? || !@users.exists?(user_to_delete))
			flash.now[:error] = "Cannot find user #{params[:user_id]}"
			render 'edit_collaborators'
		else
			@users.delete(user_to_delete)
			flash[:success] = "Removed Collaborator"
			redirect_to @project
		end   
	end

	def create_comment # TODO: authenticate user/project
		@project = Project.find_by_id(params[:id])
		comment = current_user.comments.build(params[:comment]);
		comment.project = @project
		if comment.save
			flash[:success] = "Comment added!"
			redirect_to @project
		else
			flash[:error] = "Comment not added!"
			redirect_to @project
		end
	end

	def new_page
		@project = Project.find_by_id(params[:id])
		@pages = @project.project_pages
		@new_page = true
		@comments = @project.comments
		render 'show'
	end

	def create_page
		@project = Project.find_by_id(params[:id])
		@page = @project.project_pages.build(params[:page])
		if @page.save
			flash[:success] = "Page added"
		else
			flash[:error] = "Error"
		end 
		redirect_to @project
	end

	def edit_page
		@project = Project.find_by_id(params[:id])
		@pages = @project.project_pages
		@page = @project.project_pages.find_by_title(params[:page])
	end

	def update_page
		@page = @project.project_pages.find_by_title(params[:project_page][:title])
		if @page.update_attributes(params[:project_page])
			flash[:success] = "Updated Page successfully"
			redirect_to(@project)
		else
			flash[:error] = "Something went wrong"
		end
	end
	private
end
