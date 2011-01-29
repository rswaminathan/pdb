namespace :projects do
  desc "set_count_to_0"
  task :set_count_to_0 => :environment do
    projects = Project.all
    projects.each do |p|
      p.count = 1
      p.save
    end
  print "all count set to 0"  
  end
end

