class ProjectsController < ApplicationController

    before_filter :authenticate,         :only => [:new, :create]
    #before_filter :correct_project_user, :only => [:edit, :update, :destroy]
    before_filter :correct_project_user, :only => [:edit_collaborators, :update_collaborators, :delete_collaborators, :edit, :update, :destroy]
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
    end
    
    def destroy
      @project.destroy #@project is defined in correct_user authenticate
      flash[:success] = "Project deleted"
      redirect_to current_user
    end
    
  def search
    @projects = Project.search(params[:q][:search])
    end
    
    def edit
      @title = "Edit Project"
      @comments = @project.comments
    end

    def update
      if @project.update_attributes(params[:project])
        flash[:success] = "Project updated!"
        redirect_to(@project) 
      else
        #flash[:error] = "Something went wrong, try again"
        render 'edit'
      end 
    end

    def edit_collaborators
      @title = "Edit Collaborators"
      @comments = @project.comments  
    end

    def update_collaborators
      user_to_add = User.find_by_email(params[:user][:email])
      if (user_to_add.nil? || @users.exists?(user_to_add))
        flash.now[:error] = "Cannot find user / Duplicate user"
        render 'edit_collaborators'
      else
      @project.users << user_to_add
      @project.save
      flash[:success] = "Added collaborator"
      redirect_to @project
      end   
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

    private
      
end
