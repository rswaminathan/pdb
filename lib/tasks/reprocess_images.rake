namespace :reprocess do
  desc "reprocess images"
  task :reprocess_users => :environment do
    users = User.all
    users.each do |u|
      u.profile.photo.reprocess! if u.profile.photo.exists?
    end
  print "all phots reprocessed"  
  end
  
  task :reprocess_projects => :environment do
    projects = Project.all
    projects.each do |p|
      p.photo.reprocess! if p.photo.exists?
    end
    print "all done"
  end
end

