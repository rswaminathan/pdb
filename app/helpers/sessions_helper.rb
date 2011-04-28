module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] =  [user.id, user.salt]	
    current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token
  end

  def current_user_page?
    current_user == @user
  end

  def signed_in?
    !current_user.nil?	
  end

  def sign_out
    cookies.delete(:remember_token)
    current_user = nil
  end

  def facebook_user?
    if signed_in?
      !current_user.facebook_token.nil?
    else false
    end
  end

  def current_group_admin(user)
    user.is_admin?(Group.find_by_id(params[:id])) || admin_user?
  end

  def group_privs
    deny_group_access unless current_group_admin(current_user)
  end

  def authenticate
    deny_access unless signed_in?
  end

  def deny_group_access
    flash[:notice] = "You're not a Group Admin!"
    redirect_to groups_path
  end

  def reset_code
    unless (params[:reset] || params[:user][:reset]) == User.find(params[:id]).reset && !User.find(params[:id]).reset.nil?
      flash[:notice] = "Incorrect Reset Code!"
      redirect_to root_url
    end
  end

  def correct_project_user
    @project = Project.find_by_id(params[:id])
    @users = @project.users
    redirect_to(root_path) unless (admin_user? || (signed_in? && @users.exists?(current_user)))
  end

  def check_admin_user
    redirect_to(root_path) unless admin_user?
  end

  def admin_user?
    unless @admin_user.nil?
      return @admin_user
    end
    return @admin_user = admin_user
  end

  def admin_user
    current_user == User.find_by_email("ozzie_gooen@hmc.edu") ||
    current_user == User.find_by_email("rswaminathan@hmc.edu") ||
    current_user == User.find_by_email("matt_mcdermott@hmc.edu")
  end

  def current_project_user?
    signed_in? && @users.exists?(current_user)
  end

  def deny_access
    session[:trying_to_access] = request.fullpath
    flash[:notice] = "Sign in first!"
    redirect_to login_path 
  end

  def redirect_to_page_trying(default)
    redirect_to(session[:trying_to_access] || default )	
    session[:trying_to_access] = nil  #redirect_to only executes
    #after all other code
  end

  def like_different_parameter?(user, project, type)
    project.likes.each do |like|
      if like.user == user && like.description != type
        return true
      end
    end
    return false
  end


  def likes_project?(user, project)
    project.likes.each do |like|
      if like.user == user
        return true
      end
    end
    return false
  end

  def like_options(user, project, type)
    if likes_project?(user, project)
      project.likes.each do |like|	  	  
        if like.user == user && like.description == type
          return "it's the same"	
        elsif like.user == user && like.description != type
          if (like.description == "awesome") || (like.description == "interesting")
            @like_to_change = like
            return "change"    
          else
            return "it's different"
          end
        else		
        end
      end
    elsif user.nil?
      return "new_user"
    else
      return false
    end
  end

  def link_generator(projects,start_index,num)
    p_list = Array.new
    projects.each do |project|
      p_list += project.kind_list.select{|a| a!= "Enter tags(comma separated)"}
    end
    p_count=Hash.new
    p_list.each do |tag|
      p_count[tag] = (p_count.has_key?(tag) ? p_count[tag]+1 : 1)
    end
    p_sorted= p_count.sort {|a,b| -(a[1]<=>b[1])}
    @links = p_sorted[start_index,num]
  end

  def group_sorter(users,length)
    g_hash = Hash.new
    users.each do |user|
      user.projects.each do |project|
        project.groups.each do |group|
	  g_hash[group] = (g_hash.has_key?(group) ? g_hash[group]+1 : 1)
        end
      end
    end
    @groups_list = (g_hash.sort {|a,b| -(a[1]<=>b[1])})[0,length]
  end
      

  private

  def user_from_remember_token
    User.authenticate_with_salt(*remember_token)
  end

  def remember_token
    cookies.signed[:remember_token] || [nil, nil]
  end
end
