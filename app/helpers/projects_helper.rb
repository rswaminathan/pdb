module ProjectsHelper
  def old_slider_projects
    [51, 13, 35, 46, 47, 50, 56].map{|p| Project.find(p)}
  end
  
  def more_by_team_heavy(start_project)
     more_by_team = []
      start_project.users.each do |user|
        more_by_team += user.projects.all.find_all{|project| project.photo.exists?}
      end
      x= (more_by_team.uniq.find_all{|project| (project.users & start_project.users).count >2}-start_project.to_a)[0,6]
      return x
  end
  
  def more_by_team(start_project)
      m = []
       start_project.users.each do |user|
         m += user.projects.all.find_all{|project| project.photo.exists?}
       end
       m.uniq!.delete(start_project)
       return m
   end
  
  
end
