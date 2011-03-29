module UsersHelper

  def html_for_autocomplete(user)
   p = "<div class='user_pic'><img src=#{user.profile.photo.url(:tiny)}></div>"
   n =  "<div class='users_list'>#{user.name}</div>"
   d = "<div class='user' style='height: 40px;'>" + p + n + "</div>"
    return d
  end

  def random_project(user)
    user.projects.all[rand(user.projects.count)] 
  end


  def slider_projects
    [2, 61, 106, 41].map{|p| User.find(p)}
  end
  def facebook_friends
    @facebook_friends ||= FbGraph::User.me(current_user.facebook_token).fetch.friends
  end
  def facebook_years(fbuser)
    years = Array.new
    fbuser.education.each do |education| 
      years << education.year.name
    end
    return years
  end

  def facebook_schools(fbuser)
    schools = Array.new
    fbuser.education.each do |education| 
      schools << education.school.name
    end
    return schools
  end

  def facebook_concentrations(fbuser)
    concentrations = Array.new
    fbuser.education.each do |education| 
      education.concentration do |concentration|
        concentrations << concentration.name
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
    @fbuser = FbGraph::User.me(user.facebook_token).fetch
    redir_url = Mechanize.new.get("#{@fbuser.picture}?type=large").uri
    image = open redir_url #handles facebook https-http redirect, very retarded way to do it, find
    # something better.
    @profile.update_attributes(:institution => facebook_schools(@fbuser).last,
                               :year        => facebook_years(@fbuser).last,
                               :occupation  => facebook_concentrations(@fbuser).last,
                               :photo       => image)
  end
end
