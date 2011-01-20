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

# == Schema Information
#
# Table name: profiles
#
#  id                 :integer         not null, primary key
#  about              :text
#  institution        :string(255)
#  occupation         :string(255)
#  year               :integer
#  skills             :text
#  facebook           :string(255)
#  twitter            :string(255)
#  linked_in          :string(255)
#  website            :string(255)
#  other              :string(255)
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  photo_file_name    :string(255)
#  photo_content_type :string(255)
#  photo_file_size    :integer
#  department         :string(255)
#  top_tags           :string(255)
#

