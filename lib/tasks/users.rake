namespace :users do
  desc "Make all emails downcase for users"
  task :make_email_downcase => :environment do
    users = User.all
    users.each do |u|
      u.email = u.email.downcase
      u.save
    end
  print "\n all emails downcase"  
  end
end

