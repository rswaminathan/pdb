class UsersController < ApplicationController
	
  before_filter :authenticate, :only => [:edit, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
 
  def new
  	@title = "Sign Up"
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @projects = @user.projects
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
    	sign_in @user
    	flash[:success] = "Yay! You registered"
    	redirect_to @user 
    else
    	@title = "Sign Up"
    	render 'new'
    end
  end  
  
  def edit
  	@user = User.find(params[:id])
  	@title = "Edit User"
  end
  
  def update
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        flash[:success] = "Profile updated!"
        redirect_to(@user) 
      else
        #flash[:error] = "Something went wrong, try again"
        render 'edit'
      end  
  end
  
  private
  	

  	def correct_user
	   @user = User.find(params[:id])
	   redirect_to(root_path) unless @user = current_user  
  	end   
end
