class PagesController < ApplicationController
	def home
		@title = "Home"
		@user = User.new
	end

	def contact
		@title = "Contact"
	end

	def create
		@title = "Home"
		@user = User.new
	end

	def create2
		@title = "Home"
		@user = User.new
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
      @users_found= User.all.sort! {|a,b| -(a.projects.count <=> b.projects.count)}[0,9]
    elsif (params[:page]== "sort_by_creation")
      @users_found = User.all.sort! {|a,b| -(a.created_at <=> b.created_at)}[1,9]
    elsif
      (params[:page]== "sort_by_followers")
      @users_found = User.all.sort! {|a,b| -(a.followers.count  <=> b.followers.count )}[1,9]
		else
	    @users_found = User.search_by_name(params[:search])
  	 end
  	 
	end

	def search_projects
		@title = "Search Projects"

		if (params[:page]== "sort_by_views")
      @projects_found= Project.all.sort! {|a,b| -(a.count <=> b.count)}[0,9]
    elsif (params[:page]== "sort_by_creation")
      @projects_found =Project.all.sort! {|a,b| -(a.created_at <=> b.created_at)}[1,9]
    elsif
      (params[:page]== "sort_by_update")
      @projects_found =Project.all.sort! {|a,b| -(a.updated_at <=> b.updated_at)}[1,9]
		else
		  @projects_found = Project.search_by_name(params[:search]) if params[:search]
	  end
	  
		p_list = Array.new
    Project.all.each do |project|
    p_list += project.kind_list
    end

    p_count=Hash.new
      p_list.each do |s|
      p_count[s] = 0
      end

    p_count.each do |w|
      p_list.each do |s|
    	if (w[0]==s && w[0] != "Enter tags(comma separated)")
    	p_count[s] +=1
    	end
      end
      end

    p_sorted= p_count.sort {|a,b| -(a[1]<=>b[1])}
    if (params[:page]== "tag_list")
    @links = p_sorted[0,40]
    else
    @links = p_sorted[0,13]
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
  	
end
