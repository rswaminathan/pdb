class StagePresenter

  def initialize(group = nil, page = nil, perpage = 8)
    @filter = nil
    @group = group
    @page = page
    @perpage = perpage
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
    elsif type == "groups"
      results = Group.all
    else
      stage_projects
    end
  end

  def sort(results, sort ,type)
    if type && (type == "people") 
      sort_people(results, sort)
    elsif type && (type == "projects")
      sort_projects(results, sort)
    elsif type && (type == "groups")
      sort_groups(results, sort)
    else
      results.sort! {|a,b| -(a.created_at <=> b.created_at)} 
    end
  end

  def sort_people(results, sort)
    if sort == "productivity"
      results.sort! {|a,b| -(a.projects.count <=> b.projects.count)}
    else
      results.sort! {|a,b| -(a.created_at <=> b.created_at)} 
    end
  end
  
  def sort_projects(results, sort)
    if sort == "date"
      results.sort! {|a,b| -(a.created_at <=> b.created_at)}  
    elsif sort == "popularity"
      results.sort! {|a,b| -(a.count <=> b.count)}
    else !results.nil?
       results.shuffle!
    end
  end
  
  def sort_groups(results, sort)
    if sort == "size"
       results.sort! {|a,b| -(a.projects.count <=> b.projects.count)}
    else 
       results.sort! {|a,b| -(a.created_at <=> b.created_at)}
    end
  end    
  
  def search_all(query, group)
    results = []
    results += (Project.by_group(@group).search_by_name(query)) || []
    results += (User.by_group(@group).search_by_name(query)) || []
    if group.nil?
    results += (Group.search_by_name(query)) || []
    end
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
      results.find_all{|project| show_in_stage_group?(project)}
    else
      results = Project.all
      results.find_all{|project| show_in_stage_home?(project)}
    end
    
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
  
  def show_in_stage_home?(project)
    (!project.abstract.nil? && (project.abstract.length > 35)) || (!project.description.nil? && project.description.length>35) && project.photo.exists?
  end

  def show_in_stage_group?(project)
    (!project.abstract.nil? && (project.abstract.length > 20)) || (!project.description.nil? && project.description.length>20)
  end
end
