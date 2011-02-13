module SessionsHelper
    
    def sign_in(user)
        cookies.permanent.signed[:remember_token] =  [user.id, user.salt]	
        current_user = user
    end
	
	def rand_project
		Project.search_by_name("")
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
    
    def authenticate
		deny_access if !signed_in?
  	end
  	
  	def correct_project_user
		@project = Project.find_by_id(params[:id])
		@users = @project.users
		redirect_to(root_path) unless (signed_in? && @users.exists?(current_user))
  	end

    def check_admin_user
		redirect_to(root_path) unless admin_user?
    end

    def admin_user?
      if !@admin_user.nil?
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
	
	
	def project_update_sort(projects)
		max = ["Home",0]
		list = []
		projects.each do |project|
			if project.project_pages.any?
				max[1] = project.updated_at
				project.project_pages.each do |page|
					if page.updated_at > max[1]
						max = [page.title,page.updated_at]
					end
				end
				list += [[project,max[0],max[1]]]
			else
				list += [[project,"Home",project.updated_at]]
			end
		end
		return_list = list.sort!{|t1,t2| t2[2] <=> t1[2]} 
	end
    
    private
    
        def user_from_remember_token
            User.authenticate_with_salt(*remember_token)
        end
        
        def remember_token
            cookies.signed[:remember_token] || [nil, nil]
        end
end
