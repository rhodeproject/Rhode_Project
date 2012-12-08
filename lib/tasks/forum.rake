namespace :forum do

  desc "update forums"
  task :update_admin => :environment do
    forum = Forum.all
    forum.each do |f|

      f.update_attribute('admin','false')
      f.save
    end
  end
end