class Profile < ActiveRecord::Base
    has_attached_file :photo, 
                      :styles => {:thumb=> "60x60#", :small  => "180x600>" },
                      :default_url => "/images/wally_small.jpg",
                      :storage => :s3,
                      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                      :path => "/:style/:filename"    

    belongs_to        :user

    acts_as_taggable_on :top_tags

end
