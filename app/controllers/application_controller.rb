class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  include ProjectsHelper
  include UsersHelper
  include LinksHelper
  
end
