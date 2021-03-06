class Link < ActiveRecord::Base

  link_regex = /http:\/\/.*\..*/i #TODO: actually find a proper one

  belongs_to :project
  belongs_to :user

  validates :link, :presence         => true,
    :format                   => { :with => link_regex}
end
