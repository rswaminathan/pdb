class Attachment < ActiveRecord::Base
  has_attached_file :file, 
                     :storage => :s3,
                     :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                     :path => "/:style/:filename"

  belongs_to :project

end
