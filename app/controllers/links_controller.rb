class LinksController < ApplicationController
  def create
      @project = Project.find(params[:project_id])
      @link = @project.links.build(params[:link])
      @link.save
      fix_providers(@project.links)
      redirect_to(@project)
  end
end

