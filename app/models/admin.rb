class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end

# == Schema Information
#
# Table name: admins
#
#  id         :integer         primary key
#  email_list :text
#  created_at :timestamp
#  updated_at :timestamp
#

