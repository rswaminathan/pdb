class Like < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  scope :awesome,     where(:like => 'awesome')
  scope :interesting, where(:like => 'interesting')
end
