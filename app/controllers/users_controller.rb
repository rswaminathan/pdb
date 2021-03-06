class UsersController < ApplicationController

  before_filter :reset_code,		:only => [:reset, :reset_password]
  before_filter :authenticate,		:only => [:edit, :destroy]
  before_filter :correct_user,		:only => [:edit, :update, :edit_profile, :update_profile]
  before_filter :check_admin_user,	:only => [:destroy]
  sidebar_type=["user_info","project_list"]

  def index
    @users = User.search_by_name(params[:q])
    respond_to do |format|
      format.html
      format.json{ render :json => @users.map{|user| 
                  {:id => user.id,
                   :name => html_for_autocomplete(user)}
                  }}
    end
  end

  def new
    @title = "Sign Up"
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
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


  def create
    @user = User.new(params[:user])
    @user.email = @user.email.downcase
    @user.build_profile
    if @user.save
      sign_in @user
      @preuser = PreUser.find_by_email(params[:user][:email].downcase)
      if @preuser
        @user.projects = @preuser.projects
        @preuser.destroy
      end
      redirect_to edit_profile_user_path(@user)
    else
      @title = "Sign Up"
      render 'pages/home'
    end
  end  

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Deleted user"
    redirect_to(search_users_path)
  end

  def edit
    @user = User.find_by_id(params[:id])
    @title = "Edit #{@user.name}'s Account"
    @projects = @user.projects
  end

  def forgot
    if signed_in?
      flash[:notice] = "You're already signed in!"
      redirect_to root_url
    else 
      @title = "Forgot Password"
    end
  end

  def forgot_password
    if signed_in?
      sign_out
    end
    if @user = User.find_by_email(params[:user][:email])
      list = (('a'..'z').to_a + ('A'..'Z').to_a + ('0'..'9').to_a)
      reset = ""
      24.times do |i|
         reset += list.shuffle[0]
      end
      @user.reset = reset
      @user.save
      UserMailer.reset_password(@user).deliver
      flash[:success] = "Check your email for password reset instructions."
      redirect_to(root_url)
    else
      flash[:error] = "No User with that email address was found"
      render 'forgot'
    end
  end

  def reset
    @user = User.find_by_id(params[:id])
    @title = "Reset #{@user.name}'s Password"
  end

  def reset_password
    @user = User.find_by_id(params[:id])
    if @user.update_attributes(params[:user])
      sign_in @user
      flash[:success] = "Password Reset!"
      @user.reset = nil
      @user.save
      redirect_to(@user)
    else
      #flash[:error] = "Something went wrong, try again"
      render 'reset'
    end  
  end 

  def edit_profile
    @title = "Edit #{@user.name}'s Profile"
    if !@user.profile.nil?
      @profile = @user.profile
    else
      @profile = @user.build_profile
      @profile.save
    end 
  end

  def edit_facebook_profile
    @user = current_user
    @fbuser = FbGraph::User.me(@user.facebook_token).fetch
    @message="help"

    @schools = facebook_schools(@fbuser)
    @years = facebook_years(@fbuser)
    @concentrations = facebook_concentrations(@fbuser)

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
      flash[:success] = "Registration Complete!"
      redirect_to(@user) 
    else
      #flash[:error] = "Something went wrong, try again"
      render 'edit'
    end  
  end

  def following
    @title = "Following"
    @user = User.find_by_id(params[:id])
    @users = @user.users_following
    @projects = @user.projects_following
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers
    @projects = []
    render 'show_follow'
  end

  def feed
    @title = "Snippets"
    @user = User.find(params[:id])
    @users = @user.followers
    @projects = []
    render 'feed'
  end

  def search
  end

  private

  def correct_user
    @user = User.find_by_id(params[:id])
    redirect_to(root_path) unless @user = current_user  
  end   
end
