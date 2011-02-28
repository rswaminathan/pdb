module UsersHelper
  def facebook_friends
      @facebook_friends ||= FbGraph::User.me(current_user.facebook_token).fetch.friends
  end
  	 def facebook_years(fbuser)
     years = Array.new
     fbuser.education.each do |education| 
          years += education.year.name.to_a
      end
      return years
	end
	
	 def facebook_schools(fbuser)
     schools = Array.new
     fbuser.education.each do |education| 
          schools += education.school.name.to_a
      end
      return schools
	end
 		
       def facebook_concentrations(fbuser)
         concentrations = Array.new
         fbuser.education.each do |education| 
   	          education.concentration do |concentration|
   	            concentrations+=concentration.name.to_a
   	          end
          end
          return concentrations
   		end

  def build_profile_from_facebook(user)
    if !user.profile.nil?
			@profile = user.profile
		else
			@profile = user.build_profile
			@profile.save
		end 
    #now update profile from facebook
    @fbuser = FbGraph::User.me(current_user.facebook_token).fetch
    redir_url = Mechanize.new.get("#{@fbuser.picture}?type=large").uri
    image = open redir_url #handles facebook https-http redirect, very retarded way to do it, find
    # something better.
    @profile.update_attributes(:institution => facebook_schools(@fbuser)[0],
                               :year        => facebook_years(@fbuser)[0],
                               :occupation  => facebook_concentrations(@fbuser)[0],
                               :photo       => image)
  end
end
