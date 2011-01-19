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
		@title = @user.name
		@projects = @user.projects
		if !params[:tag].nil?
			@projects = @projects.tagged_with params[:tag]
		end
		@sidebar_page = params[:page]
		@profile = @user.profile 
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			@user.create_profile
			sign_in @user
			redirect_to edit_profile_user_path(@user)
		else
			@title = "Sign Up"
			render 'new'
		end
	end  

	def edit
		@user = User.find_by_id(params[:id])
		@title = "Edit #{@user.name}'s Account"
		@projects = @user.projects
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
	
	private

	def correct_user
		@user = User.find_by_id(params[:id])
		redirect_to(root_path) unless @user = current_user  
	end   
end
