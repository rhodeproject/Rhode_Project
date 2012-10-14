namespace :anniversary do
  desc "update anniversary"
    task :update => :environment do
      user = User.all
      user.each do |u|
        createdate = u.created_at
        anndate = createdate.next_year
        u.update_attribute('anniversary',anndate)
        u.save
      end
      UserMailer.rake_task_complete("anniversary:update").deliver
    end
end