module PagesHelper
  
  def links_generator
    
    p_list = Array.new
		Project.all.each do |project|
		p_list += project.kind_list
    end

    p_count=Hash.new
      p_list.each do |s|
      p_count[s] = 0
      end

    p_count.each do |w|
        p_list.each do |s|
        	if (w[0]==s && w[0] != "Enter tags(comma separated)")
        	  p_count[s] +=1
        	end
        end
    end

    p_sorted= p_count.sort {|a,b| -(a[1]<=>b[1])}
    @links = p_sorted[0,30]
    
  end 
	
end

  def User_sorter
    
    u_list = Array.new
    
		Profile.all.each do |profile|
		  
		  if !profile.occupation.nil?
		    u_list += profile.occupation.to_a
		  end
		  
		  if !profile.year.nil?
		    u_list += profile.year.to_a
		  end
	
		  if !profile.institution.nil?
		    u_list += profile.institution.to_a
		  end	  
		  
		  if !profile.department.nil?
		    u_list += profile.department.to_a
		  end
		  
    end

    p_count=Hash.new
      p_list.each do |s|
      p_count[s] = 0
      end

    p_count.each do |w|
        p_list.each do |s|
        	if (w[0]==s && w[0] != "Enter tags(comma separated)")
        	  p_count[s] +=1
        	end
        end
    end

    p_sorted= p_count.sort {|a,b| -(a[1]<=>b[1])}
    @links = p_sorted[0,30]
