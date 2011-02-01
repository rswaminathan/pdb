module ProjectsHelper
  def slider_projects
    [13, 35, 46, 47, 50, 51, 56].map{|p| Project.find(p)}
  end
end
