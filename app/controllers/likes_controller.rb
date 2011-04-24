class LikesController < ApplicationController
  before_filter :authenticate

  def know_more
    @project = Project.find(params[:project_id])
    @like = Like.new
    @like.description = "know_more"
    @like.user = current_user
    @like.project = @project
    #TODO: actually implement extra comments
    @custom_message = params[:know_more][:extra]
    if @like.save
      flash.now[:success] = ""
      @project.users.each do |user|
        UserMailer.know_more(user, current_user, @project, @custom_message).deliver
      end
    end
  end

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
        if !current_user.profile.interesting_photo.exists? || !current_user.profile.interesting_photo.exists?
          @needs_picture = true
        end
      else
        flash.now[:error] = "Error"
      end
    end
  end
end
