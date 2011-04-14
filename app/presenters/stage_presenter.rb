class StagePresenter

  def initialize(group = nil)
    @filter = nil
    @group = group
  end

  def recent_projects
  end

  def recent_users
  end

  def users
    if @group
      @group.users
    else
      User.all
    end
  end

  def find_by_type(type)
    if type == "people"
      stage_users
    else 
      stage_projects
    end
  end

  def sort(results, sort ,type)
    if sort.nil?
      if type && (type == "people") 
        results.sort! {|a,b| -(a.created_at <=> b.created_at)} 
      elsif !results.nil?
         results.shuffle!
      end
    elsif sort == "date"
      results.sort! {|a,b| -(a.created_at <=> b.created_at)}  
    elsif sort == "popularity"
      results.sort! {|a,b| -(a.count <=> b.count)}
    elsif sort == "productivity"
      results.sort! {|a,b| -(a.projects.count <=> b.projects.count)}
    else
      results.shuffle!
    end
  end

  def search_all(query)
    results = []
    results += (Project.by_group(@group).search_by_name(query)) || []
    results += (User.by_group(@group).search_by_name(query)) || []
    return results
  end

  def allpeople(projects)
    people = []
    projects.each do |project|
      people |= project.users
    end
    return people
  end
        
  def stage_projects
    if @group
      results = @group.projects
    else
      results = Project.all
    end
    results.find_all{|project| show_in_stage?(project)}.shuffle
  end

  def stage_users
    if @group
      people = @group.users
      @group.projects.each do |project|
        people |= project.users
      end
      return people
    else
      return User.all
    end
  end
    
  def show_in_stage?(project)
    (!project.abstract.nil? && (project.abstract.length > 35)) || (!project.description.nil? && project.description.length>35) && project.photo.exists?
  end


end
