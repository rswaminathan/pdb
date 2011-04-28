class GroupsController < ApplicationController

  before_filter :group_privs, :only => [:edit, :add_users, :add_admins, :destroy]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(params[:group])
    a = true if @group.save
    current_user.join_as_admin!(@group)
    if a
      flash[:success] = "New Group Added"
    else 
      flash[:error] = "Error"
    end
    redirect_to @group
  end

  def edit
    @group = Group.find_by_id(params[:id])
    @title = "Edit #{@group.name}'s Account"
    @projects = @group.projects
    @people = GroupRelations.find_all_by_group_id(@group.id)
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
    
      @size = "small"
    if params[:size]
      @size = params[:size]
    elsif !(params[:type] || params[:search] || params[:size])
      @size = "large"
    end
    
  end

  def destroy
    @group = Group.find(params[:id])
    GroupRelations.find_all_by_group_id(@group.id).each do |x| 
      x.destroy
      end
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
    if (user_to_add.nil? || user_to_add.in_group?(@group))
      flash[:error] = "Cannot find user / Duplicate user" 
    else
      user_to_add.join_group!(@group)
      flash[:success] = "Added user"
    end   
    redirect_to edit_group_path(@group)
  end

  def add_admins
    @group = Group.find(params[:id])
    user_to_add = User.find_by_id(params[:user_id])
    if (user_to_add.nil?)
      flash[:error] = "Cannot find user / Duplicate user" 
    else
      if user_to_add.in_group?(@group)
        user_to_add.become_admin!(@group) unless user_to_add.is_admin?(@group)
      else
        user_to_add.join_as_admin!(@group)
      end
      flash[:success] = "Added Admin"
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
