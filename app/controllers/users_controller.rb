class UsersController < ApplicationController
	
  before_filter :authenticate, :only => [:edit, :destroy]
  before_filter :correct_user, :only => [:edit, :update, :edit_profile, :update_profile]
 
 sidebar_type=["user_info","project_list"]
 
  def new
  	@title = "Sign Up"
    @user = User.new
    
  end

  def show
    @user = User.find(params[:id])
    @projects = @user.projects
    @sidebar_page = params[:page]
    @profile = @user.profile 
  end
    
  def create
    @user = User.new(params[:user])
    if @user.save
      @user.create_profile
    	sign_in @user
    	flash[:success] = "Yay! You registered"
    	redirect_to @user 
    else
    	@title = "Muddfish"
    	render 'pages#home'
    end
  end  
  
  def edit
  	@user = User.find_by_id(params[:id])
  	@title = "Edit User"
    @projects = @user.projects
  end

  def edit_profile
    if !@user.profile.nil?
    @profile = @user.profile
    else
    @profile = @user.build_profile
    @profile.save
    end 
  end
  
  def update_profile
      if (@user.profile.update_attributes(params[:profile]))
        flash[:success] = "Updated Profile"
        redirect_to(@user)
      else
      # flash[:success] = "Updated Profile"
      render 'edit_profile'
      end
   end

  def update
      @user = User.find_by_id(params[:id])
      if @user.update_attributes(params[:user])
        sign_in @user
        flash[:success] = "Profile updated!"
        redirect_to(@user) 
      else
        #flash[:error] = "Something went wrong, try again"
        render 'edit'
      end  
  end
  
  private
  	
  	def correct_user
	   @user = User.find_by_id(params[:id])
	   redirect_to(root_path) unless @user = current_user  
  	end   
end
