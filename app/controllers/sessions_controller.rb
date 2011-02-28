class SessionsController < ApplicationController
  before_filter :make_new_user?, :only => :create 
	def new
		@title = "Log In"
	end

	def destroy
		sign_out
		flash.now[:error] = "Signed out successfully"
		render 'new'
	end

	def create
		if @facebook_user
		  #refresh token, then sign in
      user = @facebook_user
      user.update_attributes!(:facebook_token => @auth["credentials"]["token"])
			sign_in(@facebook_user)
                redirect_to_page_trying(user)              
		else
			user = User.authenticate(params[:session][:email].downcase, params[:session][:password])						
			if user.nil?
				flash.now[:error] = "Check your detailz"
				render 'new' 
            else 
				sign_in(user)   
                redirect_to_page_trying(user)              
			end
		end
	end 
  
  def make_new_user?
    if @auth = request.env["omniauth.auth"]
      if !@facebook_user = User.find_by_provider_and_uid(@auth["provider"], @auth["uid"])
        if signed_in?
          user = User.create_with_omniauth(@auth, current_user)
        else
          user = User.create_with_omniauth(@auth, nil)
          build_profile_from_facebook(user)
        end
        sign_in(user)
        redirect_to edit_profile_user_path(user)
      end
    end
  end

end
