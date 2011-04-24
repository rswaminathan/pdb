class Section < ActiveRecord::Base
	attr_accessible :content, :photo_file_name, :photo_file_size, :photo_content_type, :title
	belongs_to :project_page
	
	has_attached_file	:photo, 
						:styles => {:tiny=> "30x30#", :thumb=> "60x60#", :small  => "640x480>" },   
						:storage => :s3,
						:default_url => "/images/lightbulb.jpg",
						:s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
						:path => "/:style/:filename"   

end
# == Schema Information
#
# Table name: sections
#
#  id                 :integer         primary key
#  title              :string(255)
#  content            :text
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  created_at         :timestamp
#  updated_at         :timestamp
#  project_page_id    :integer
#

