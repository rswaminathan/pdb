class ProjectsController < ApplicationController

  before_filter :authenticate, 			:only => [:new, :create]
  #before_filter :correct_project_user,	:only => [:edit, :update, :destroy]
  before_filter :correct_project_user,	:only => [:edit_collaborators, :update_collaborators, :delete_collaborators, :new_page, :edit_page, :update_page, :edit, :update, :destroy]
  autocomplete :user, :name

  #for the autocomplote in projects/new - send all the data
  def json_for_autocomplete(items, method)
    #merge with fb friends
    if signed_in? && facebook_user?
      @fb_json = facebook_friends.select{|u| u.name.downcase.starts_with? params[:term].downcase }.collect { |item| {"id" => item.identifier, "label" => item.name, "value" => item.name,
        "img" => item.picture, "info" => "Facebook Friend"}}
    else
      @fb_json = []
    end
    items.collect {|item| {"id" => item.id, "label" => item.name, "value" => item.name,
      "img" => item.profile.photo.url(:tiny),
      "info" => "#{item.profile.department} #{item.profile.occupation} #{item.profile.year}"
    }}.concat(@fb_json)
  end

  def new
    @title = "New Project"
    @project = current_user.projects.build
    @project.links.build
    @tag_string = params[:tags] ? params[:tags].gsub(" ", ", ") : ""
  end

  def create
    @project = current_user.projects.build(params[:project])
    @project.count = 0
    if params[:cids]
      @users = params[:cids].split(",").map{ |u| User.find(u) }
      @project.users = @project.users | @users
    end
    if @project.save
      if (@project.description.nil? || @project.description.empty?)
        @project.update_attributes(:description => @project.abstract)
      end
      current_user.projects << @project
      flash[:success] = "Project added!"
      #current_user.facebook.feed!(:message => "Check out my new project #{link_to(@project.name,@project)} at Holono.com", :name => "My New Project" )
      redirect_to @project
    else
      render 'new'
    end
  end

  def show
    @project = Project.find_by_id(params[:id])
    @users = @project.users
    @collaborators = @users.first(4) 
    @title = "#{@project.name}"
    @comments = @project.comments
    @pages = @project.project_pages
    @project.count += 1
    @project.save
    if !params[:page].nil?
      @page = @project.project_pages.find_by_title(params[:page])
      @sections = @page.sections
      @section = @sections.find_by_title(params[:section]) if !params[:section].nil?
    else
      @page_is_main = true
    end
  end

  def show_all_collaborators
    @project = Project.find_by_id(params[:id])
    @users = @project.users
    @collaborators = @users.drop(4) #the remaining users
  end

  def destroy
    @project.destroy #@project is defined in correct_user authenticate
    flash[:success] = "Project deleted"
    redirect_to current_user
  end

  def search
    @title = "Project Search"
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
    @project.links.build
  end

  def edit_main_page
    @project = Project.find_by_id(params[:id])
    @title = "#{@project.name}"
    @users = @project.users
    @collaborators = @users.first(4)
    @title = "#{@project.name}"
    @comments = @project.comments
    @pages = @project.project_pages
    if !params[:page].nil?
      @page = @project.project_pages.find_by_title(params[:page])
      @sections = @page.sections
      @section = @sections.find_by_title(params[:section]) if !params[:section].nil?
    else
      @page_is_main = true
    end
  end

  def update(redirect=nil)
    if @project.update_attributes(params[:project])
      flash[:success] = "Project updated!"
      #get projects again
      fix_providers(@project.links)
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
    @email = params[:email].downcase
    project = Project.find(params[:id])
    @preuser = PreUser.find_or_create_by_email(@email)
    if @preuser.save
      @preuser.projects << project
      UserMailer.invite_user(@email, current_user, project).deliver
    end
  end

  def update_collaborators
    user_to_add = User.find(params[:user_to_add])
    if (user_to_add.nil? || @users.exists?(user_to_add))
      flash.now[:error] = "Cannot find user / Duplicate user" 
    else
      @project.users << user_to_add
      @project.save
      UserMailer.added_user(user_to_add, current_user, @project).deliver
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

  def create_attachment # TODO: authenticate user/project
    @project = Project.find_by_id(params[:id])
    attachment = @project.attachments.build
    attachment.project = @project
    attachment.file = params[:attachment][:file]
    if attachment.save
      flash[:success] = "File(s) added!"
      redirect_to @project
    else
      flash[:error] = "File(s) not added!"
      redirect_to @project
    end
  end

  def new_page
    @title = "New Page"
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
    redirect_to project_path(@project, :page => @page.title)
  end

  def edit_page
    @project = Project.find_by_id(params[:id])
    @pages = @project.project_pages
    @page = @project.project_pages.find_by_title(params[:page])
    @title = "Edit Page: #{params[:page]}"
    flash[:title]=@page.title
  end


  def update_page
    @page = @project.project_pages.find_by_title(flash[:title])
    flash[:title]=nil
    if @page.update_attributes(params[:project_page])
      flash[:success] = "Updated Page successfully"
      redirect_to project_path(@project, :page => @page.title)
    else
      flash[:error] = "Something went wrong"
    end
  end

  def delete_page
    @project = Project.find_by_id(params[:id])
    @page = @project.project_pages.find_by_title(params[:page])
    @page.destroy
    flash[:success] = "Page Deleted" 
    redirect_to @project
  end

  def random
    if (rand(5)!=1)
      redirect_to Project.random
    else
      redirect_to Project.find_by_id([1])
    end
  end

  private
end
