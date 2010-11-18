class ProjectsController < ApplicationController

    before_filter :authenticate,         :only => [:new, :create]
    before_filter :correct_project_user, :only => [:edit, :update, :destroy]
    def new
    	@title = "New Project"
      @project = current_user.projects.build
    end
  
    def create
      @project = current_user.projects.build(params[:project])
        if @project.save
          flash[:success] = "Project added!"
          redirect_to @project
        else
          render 'new'
        end
    end
    
    def show
      @project = Project.find(params[:id])
      @user = @project.user
    end
    
    def destroy
      @project.destroy #@project is defined in correct_user authenticate
      flash[:success] = "Project deleted"
      redirect_to current_user
    end
    
    def edit
      @title = "Edit Project"
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

    private
      def correct_user
        
      end
end
