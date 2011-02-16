class PreUser < ActiveRecord::Base
      
      has_and_belongs_to_many :projects
      email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

      validates :email, :presence         => true,
              :format                   => { :with => email_regex},
              :uniqueness               => { :case_sensitive => false}
end

# == Schema Information
#
# Table name: pre_users
#
#  id         :integer         primary key
#  email      :string(255)
#  created_at :timestamp
#  updated_at :timestamp
#

