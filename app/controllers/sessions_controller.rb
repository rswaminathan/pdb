class SessionsController < ApplicationController
  
	def new
		@title = "Log In"
	end

	def destroy
		sign_out
		flash.now[:error] = "Signed out successfully"
		render 'new'
	end

	def create
		auth = request.env["omniauth.auth"]
		if !auth.nil?
			user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
			sign_in(user)
			redirect_to root_url
		else
			user = User.authenticate(params[:session][:email].downcase, params[:session][:password])						
			if user.nil?
				flash.now[:error] = "Check your detailz"
				render 'new' 
			else 
				flash[:success] = "You signed in!"
				sign_in(user)   
				redirect_to_page_trying(user)              
			end
		end
	end 
  
end
