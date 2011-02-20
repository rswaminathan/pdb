module ProjectsHelper
  def slider_projects
    [51, 13, 35, 46, 47, 50, 56].map{|p| Project.find(p)}
  end
end
