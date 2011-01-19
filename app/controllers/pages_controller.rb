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
  
  def searchprojects
    @projects= Project.all
  end
  
  def searchusers
    @users= User.all
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
  		@users_found = User.search_by_name(params[:search])
  	end

   	def search_projects
    		@title = "Search Projects"
    		@projects_found = Project.search_by_name(params[:search])
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
