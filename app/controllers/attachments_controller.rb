class AttachmentsController < ApplicationController

  def create
    @project = Project.find_by_id(params[:id])
    attachment = @project.attachments.build
    if attachment.save
      flash[:success] = "File(s) added!"
      redirect_to @project
    else
      flash[:error] = "File(s) not added!"
      redirect_to @project
    end
  end

  def destroy
    @file = Attachment.find(params[:id])
    @project = @file.project
    @file.destroy
    flash[:success] = "Deleted Attachment"
    redirect_to(@project)
  end

end
