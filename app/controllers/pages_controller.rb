class PagesController < ApplicationController
	def home
		@title = "Muddfish | Home "
    @user = User.new
	end
	
	def contact
		@title = "Contact"
	end
end
