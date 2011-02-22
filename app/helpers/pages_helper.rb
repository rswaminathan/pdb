module PagesHelper
  
  def links_generator
	p_list = Array.new
	Project.all.each do |project|
		p_list += project.kind_list.select{|a| a!= "Enter tags(comma separated)"}
	end

	p_count=Hash.new
	while true
		if p_list[0..2] == []
			break
		end
		s=p_list[0]
		unless p_count.has_key?(s)
			p_count[s] = p_list.count{|a| a==s}
		end
		p_list = p_list.select{|a| a!= s}
	end
		
	p_sorted= p_count.sort {|a,b| -(a[1]<=>b[1])}
	@links = p_sorted[0,30]
  end
  
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

