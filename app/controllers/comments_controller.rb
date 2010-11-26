class CommentsController < ApplicationController

    def create
      comment = current_user.comments.build(params[:comment]);
        if comment.save
          flash[:success] = "Comment added!"
          redirect_to @project
        else
          flash[:error] = "Comment not added!"
          redirect_to @project
        end
    end

end
