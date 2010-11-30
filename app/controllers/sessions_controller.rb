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
   user = User.authenticate(params[:session][:email], 
    						             params[:session][:password])						
	  if user.nil?
       flash[:error] = "Check your detailz"
       redirect_to root_url
	  else 
   		flash[:success] = "You signed in!"
   		sign_in(user)   
   		redirect_to_page_trying(user)              
	  end
  end  
end
