class GroupsController < ApplicationController

  def new
    @group = Group.new
  end
  
  def create
      @group = Group.new(params[:group])
      if @group.save
        flash[:success] = "New Group Added"
      else 
        flash[:error] = "Error"
      end
      redirect_to new_group_path
  end

end