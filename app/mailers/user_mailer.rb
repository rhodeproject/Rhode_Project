class UserMailer < ActionMailer::Base
  default :from => "matt@rhodeproject.com"

  def new_user_notice(user)
    @user = user
    mail(:to => "mhatch73@gmail.com", :subject => "Another User")
  end

  def post_notice(user, micropost)
    @user = user
    @users = User.all

    @micropost = micropost
    @users.each do |u|
      mail(:bcc => u.email, :subject => "New Post")
    end
  end
end
