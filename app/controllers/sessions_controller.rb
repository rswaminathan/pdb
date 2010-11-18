class SessionsController < ApplicationController
  
	def new
    @title = "Sign In"
  end

  def destroy
     sign_out
     flash.now[:error] = "Signed out successfully"
     render 'new'
  end

  def create
    user = User.authenticate(params[:session][:email], 
    						 params[:session][:password])						
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
