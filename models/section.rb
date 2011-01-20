class Section < ActiveRecord::Base
	attr_accessible :content, :photo_file_name, :photo_file_size, :photo_content_type, :title
	belongs_to :project_page
	
	has_attached_file	:photo, 
						:styles => {:tiny=> "10x10#", :thumb=> "60x60#", :small  => "640x480>" },   
						:storage => :s3,
						:default_url => "/images/lightbulb.jpg",
						:s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
						:path => "/:style/:filename"   

end