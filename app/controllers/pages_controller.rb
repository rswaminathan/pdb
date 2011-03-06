class PagesController < ApplicationController
  def home
    @title = "Holono | Your Project Database"
    @user = User.new
    @slider_projects = slider_projects
    if params[:page]
      @home_page = params[:page]
    end
    if (params[:page]== "new")
      @projects_new =Project.all.sort! {|a,b| -(a.created_at <=> b.created_at)}[0,4]
      @users_new = User.all.sort! {|a,b| -(a.created_at <=> b.created_at)}[0,5]
      @title = "Home - See What's New"
    end
  end

  def facebookinfo
    @user = current_user

  end

  def facebook_user
    @user = current_user
    @title = @user.name
    @projects = @user.projects
    if !params[:tag].nil?
      @projects = (@projects.tagged_with params[:tag]).sort! {|a,b| -(a.count <=> b.count) }
    end
    if !params[:page].nil?
      @sidebar_page = params[:page]
    else 
      @sidebar_page = "projects"
    end
    @profile = @user.profile
    @project = Project.new
  end


  def stage
    @title = "Home"
    @user = (current_user || User.new)
    if params[:page]
      @home_page = params[:page]
    end
    if params[:search]
      @projects= Project.search_by_name(params[:search]).sort!{|a,b| -(a.created_at <=> b.created_at)}.paginate :page => params[:page], :per_page => 5
    else
      @projects= Project.all.sort!{|a,b| -(a.created_at <=> b.created_at)}.paginate :page => params[:page], :per_page => 5
    end

  end

  def search    
    session[:query] = params[:query].strip if params[:query]
    if session[:query] and request.xhr?
      @articles = Project.find(:all, :conditions => ["content LIKE ?", "%#{session[:query]}%"], :order => "title ASC")     
      render :partial => "shared/searchresults", :layout => false, :locals => {:searchresults => @articles} 
    end
  end


  def search_users
    @title = "Search User"
    if (params[:page]== "sort_by_project_count")
      @users_found= User.all.sort! {|a,b| -(a.projects.count <=> b.projects.count)}[0,10]
    elsif (params[:page]== "sort_by_creation")
      @users_found = User.all.sort! {|a,b| -(a.created_at <=> b.created_at)}[0,10]
    elsif
      (params[:page]== "sort_by_followers")
      @users_found = User.all.sort! {|a,b| -(a.followers.count  <=> b.followers.count )}[0,10]
    else
      @users_found = User.search_by_name(params[:search])
    end
  end

  def search_projects
    @title = "Search Projects"
    if (params[:page]== "sort_by_views")
      @projects_found= Project.order(:count.desc)
    elsif (params[:page]== "sort_by_creation")
      @projects_found =Project.order(:created_at.desc)
    elsif (params[:page]== "sort_by_update")
      @projects_found =Project.order(:updated_at.desc)
    else
      @projects_found = Project.search_by_name(params[:search]) if params[:search]
    end
  end

  def search_projects_toplist
    @title = "Search Projects"
    @projects_found = Project.all
  end


  def searchprojects
    @title = "Search Projects"
    @projects = Project.all
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

  def error
    @message = "Something went wrong. We have been notified(really), and we'll fix it as soon as possible.<br /> In the meantime, feel free to show your anger at us by using the feedback button to the right ----->"
  end  	
end
