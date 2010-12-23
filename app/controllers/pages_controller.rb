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
  
end
