class LikesController < ApplicationController
  
	def create
		@project = Project.find(params[:project_id])
		@like_changing = like_options(current_user, @project, params[:description])
		if @like_changing == "change"
			@like_to_change.description = params[:description]
			@like_to_change.save
      flash.now[:success] = "Your vote has changed to #{params[:description].titleize}"
		elsif @like_changing == "it's the same"
		  flash.now[:error] = "We wish you could vote unlimited times."
		elsif @like_changing == "new_user"
			flash.now[:warning] = "You need to create an account first.  Registration is really, really easy, we promise."
		else
			@like = Like.new
			@like.description = params[:description]
			@like.project = @project
			@like.user = current_user
			if @like.save
				if @like.description == "know_more"
					@project.users.each do |user|
						UserMailer.know_more(user, current_user, @project).deliver
					end
                end
					flash.now[:success] = "Thanks. Your vote for #{@project.name} has been recorded."
			else
				flash.now[:error] = "Error"
			end
		end
	end
end
