namespace :user_active do

desc "Retreiving users"
  task :update => :environment do
    user = User.all
    user.each do |u|

      u.update_attribute('active','true')
      u.save
    end
  end
end