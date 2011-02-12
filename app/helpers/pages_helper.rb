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

