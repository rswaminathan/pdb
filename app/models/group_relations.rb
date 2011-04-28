class GroupRelations < ActiveRecord::Base
	
  has_one :group
  has_one :user

end
