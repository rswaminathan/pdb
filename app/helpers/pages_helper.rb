module PagesHelper
  
	def alumni_generator
		u_list = Array.new
		User.all.each do |user|
		  if user.profile.year == 2012
				u_list += user
			end 
		end

		p_list = Array.new
		u_list.each do
			p_list += u.projects
		end
		@p_list = p_list.uniq
	  
	end
  
end

