class AttachmentsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def manage
    @attachments = "tiny_#{params[:media]}".classify.constantize.paginate :page => params[:page], :order => 'created_at DESC', :per_page => 10
    respond_to do |format|
      format.js{
        render :update do |page|
        page.replace_html :dynamic_images_list, :partial => 'show_attachment_list'
        end}
        format.html{
          respond_to_parent do |page|
          page.replace_html :dynamic_images_list, :partial => 'show_attachment_list'
          end}
    end
  end



  def create
    @attachment = "tiny_#{params[:media]}".classify.constantize.new params[params[:media]]

    if @attachment.save
      responds_to_parent do |page|
        page << 'upload_callback();'
      end
    else
      responds_to_parent do |page|
        page.alert('Sorry, there was an error uploading the photo.')
      end
    end
  end
end
