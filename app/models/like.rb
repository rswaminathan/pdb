class Like < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  scope :awesome,     where(:description => 'awesome')
  scope :interesting, where(:description => 'interesting')
end
