class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    if @group.save
      flash[:success] = "New Group Added"
    else 
      flash[:error] = "Error"
    end
    redirect_to new_group_path
  end

  def edit
    @group = Group.find_by_id(params[:id])
    @title = "Edit #{@group.name}'s Account"
    @projects = @group.projects
    @people = @group.users
    @other_projects = Project.all - @projects
    @other_users = User.all - @people
  end

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
    @title = @group.name
    @projects = @group.projects
    @user = (current_user || User.new)
    @type = "all" #this sets it to auto-show filtering options
    @filter = "none"
    stage = StagePresenter.new(@group)
    @users = stage.allpeople(@projects)

     if params[:search]
       @results = stage.search_all(params[:search], @group)
     elsif params[:type]
       @results = stage.find_by_type(params[:type])
     else 
       @results = stage.stage_projects
     end

     @results = stage.sort(@results, params[:sort], params[:type])
     
    @results = @results.paginate :page => params[:page], :per_page => 8
    
    if params[:size]
      @size = params[:size]
    end
    
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:success] = "Deleted group"
    redirect_to "/groups"
  end

  def delete_user
    user_to_delete = User.find_by_id(params[:user_id])
    @users.delete(user_to_delete)
    flash[:success] = "Removed user"
    redirect_to @group
  end

  def add_projects
    @group = Group.find(params[:id])
    project_to_add = Project.find_by_id(params[:project_id])
    if (project_to_add.nil? || @group.projects.exists?(project_to_add) )
      flash[:error] = "Cannot find project / Duplicate project" 
    else
      @group.projects << project_to_add
      @group.save
      flash[:success] = "Added project"
    end   
    redirect_to edit_group_path(@group)
  end
  
  def add_users
    @group = Group.find(params[:id])
    user_to_add = User.find_by_id(params[:user_id])
    if (user_to_add.nil? || @group.users.exists?(user_to_add) )
      flash[:error] = "Cannot find user / Duplicate user" 
    else
      @group.users << user_to_add
      @group.save
      flash[:success] = "Added user"
    end   
    redirect_to edit_group_path(@group)
  end
  
  def delete_projects
    @group = Group.find(params[:id])
    project_to_delete = Project.find(params[:project_id])
    if project_to_delete.nil?
      flash.now[:error] = "Cannot find project" 
      redirect_to edit_group_path(@group)
    else
      @group.projects.delete(project_to_delete)
      flash[:success] = "Removed project"
      redirect_to edit_group_path(@group)
    end
  end
  

  
  def delete_users
    @group = Group.find(params[:id])
    user_to_delete = User.find(params[:user_id])
    if user_to_delete.nil?
      flash.now[:error] = "Cannot find user" 
      redirect_to edit_group_path(@group)
    else
      @group.users.delete(user_to_delete)
      flash[:success] = "Removed user"
      redirect_to edit_group_path(@group)
    end
  end
  
     
  def update
    @group = Group.find_by_id(params[:id])  
    if (@group.update_attributes(params[:group]))
      flash[:success] = "Updated Profile"
      redirect_to edit_group_path(@group)
    else
      # flash[:success] = "Updated Profile"
      render 'edit_profile'
    end
  end
  
end
