namespace :user do
  desc "scheduled jobs for users"
    task :check_expiry, [:trace] => :environment do |t, args|
      check_users(args.trace)
      UserMailer.rake_task_complete("user:check_expiry").deliver
    end

    def check_users(trace)
      @users = User.all
      @users.each do |u|
        puts "checking user #{u.name}" if trace == "trace"
        @warningdate = Date.parse(u.anniversary.to_s) - 14.days
        @warningdate7 = @warningdate - 7.days
        if Date.today == @warningdate || Date.today == @warningdate7
          puts "Sending warning email to #{u.name}" if trace == "trace"
          UserMailer.expiry_notice(u).deliver
          #check if we are past expiry date, if so set active to false
          if Date.parse(u.anniversary.to_s).past?
            puts "disabling #{u.name}" if trace == "trace"
            signout_account(u)
          end
        end
      end
    end

    def signout_account(user)
      user.active = false
      user.update_attribute('remember_token','')
    end
end