namespace :user do
  desc "scheduled jobs for users"
    task :check_expiry => :environment do
      check_users
      #check_user('mhatch73@gmail.com')
    end

    def check_users
      @users = User.all
      @users.each do |u|
        @warningdate = Date.parse(u.anniversary.to_s) - 14.days
        @warningdate7 = @warningdate - 7.days
        if Date.today == @warningdate || Date.today == @warningdate7
          UserMailer.expiry_notice(u).deliver
          #check if we are past expiry date, if so set active to false
          if Date.parse(u.anniversary.to_s).past?
            signout_account(u)
          end
        end
      end
    end

    def check_user(email)
      @user = User.find_by_email(email)

      @warningdate = Date.parse(@user.anniversary.to_s) - 14.days
      if Date.today >= @warningdate
        UserMailer.expiry_notice(@user).deliver
        #check if we are past expiry date, if so set active to false
        if Date.parse(@user.anniversary.to_s).past?
          signout_account(@user)
        end
      end

      def signout_account(user)
        user.update_attribute('remember_token','')
      end

    end
end