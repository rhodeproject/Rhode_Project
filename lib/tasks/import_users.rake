#####Rake task to import users from CVS
require 'csv'

namespace :import do
	desc "import jobs"
		task :users, [:club_id] => :environment do |t, args|
			import_users(args.club_id)
			UserMailer.rake_task_complete("import:users").deliver
		end
		
		def import_users(club_id)
				puts "user import started..."
        file = "db/users.csv"
				admins = ['cwalsh','Matt','coachtara','lamoureux', 'Kellie A.','jackspratt','Kevan']
				CSV.foreach(file, :headers => false) do |row|
					#check if the user is in the admin group
					#but needs to be reset to false for each new row
					is_admin = false 
					is_admin = admins.include?(row[9])
          signed_up = row[6].to_date
					#create random password
					password = SecureRandom.hex(10)
					
					#create user
					puts "Creating new user #{row[9]}"
          user = User.create(:name => row[9],
                   :email => row[4],
                   :club_id => club_id,
                   :password => password,
                   :password_confirmation => password)
          #assign protected attributes
          puts "#{row[9]} has been created..."
          puts "assigning protected attributes..."
          user.anniversary = signed_up.next_year
          user.admin = is_admin
          user.active = true
          user.save
          puts "#{row[9]} has been saved!"
          puts "***********************"
          puts ""
				end
		end
end
