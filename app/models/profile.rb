class Profile < ActiveRecord::Base

  
  
    has_attached_file :photo, 
                      :styles => {:itsy => "30x30#", :teeny => "40x40#", :tiny=> "50x50#",:thumb=> "60x60#", :standard=> "80x80#", :small=> "100x100#", :medium  => "450x215#", :large => "210x400", :huge  => "640x480>" },
                      :default_url => "/images/wally_profile-tiny.jpg",
                      :storage => :s3,
                      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                      :path => "/profiles/photo/:id/:style/:filename"    

    has_attached_file :interesting_photo, 
                      :styles => {:itsy => "30x30#", :teeny => "40x40#", :tiny=> "50x50#",:thumb=> "60x60#", :standard=> "80x80#", :small=> "100x100#", :medium  => "140x180#", :large => "210x400", :huge  => "640x480>" },
                      :default_url => "/images/wally_profile-tiny.jpg",
                      :storage => :s3,
                      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                      :path => "/:style/:filename"    

    has_attached_file :awesome_photo, 
                      :styles => {:itsy => "30x30#", :teeny => "40x40#", :tiny=> "50x50#",:thumb=> "60x60#", :standard=> "80x80#", :small=> "100x100#", :medium  => "140x180#", :large => "210x400", :huge  => "640x480>" },
                      :default_url => "/images/wally_profile-tiny.jpg",
                      :storage => :s3,
                      :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", 
                      :path => "/:style/:filename"    


    belongs_to        :user

    acts_as_taggable_on :top_tags

    #Get the picture from a given url.
      
    def picture_from_url(url)  
        self.photo = open(url)  
    end
    
end


# == Schema Information
#
# Table name: profiles
#
#  id                             :integer         primary key
#  about                          :text
#  institution                    :string(255)
#  occupation                     :string(255)
#  year                           :integer
#  skills                         :text
#  facebook                       :string(255)
#  twitter                        :string(255)
#  linked_in                      :string(255)
#  website                        :string(255)
#  other                          :string(255)
#  user_id                        :integer
#  created_at                     :timestamp
#  updated_at                     :timestamp
#  photo_file_name                :string(255)
#  photo_content_type             :string(255)
#  photo_file_size                :integer
#  department                     :string(255)
#  top_tags                       :string(255)
#  quote                          :text
#  interesting_photo_file_name    :string(255)
#  interesting_photo_content_type :string(255)
#  interesting_photo_file_size    :integer
#  awesome_photo_file_name        :string(255)
#  awesome_photo_content_type     :string(255)
#  awesome_photo_file_size        :integer
#

