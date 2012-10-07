class UserMailer < ActionMailer::Base
  default :from => "matt@rhodeproject.com"

  def new_user_notice(user)
    @user = user
    @count = User.count
    mail(:to => "mhatch73@gmail.com", :subject => "Another User -- #{@user.name}")
  end

  def expiry_notice(user)
    @user = user
    if Rails.env.development?
      toaddr = "mhatch73@gmail.com"
      @path = "www.lvh.me:3000/user/renew?user=#{@user.id}"
    else
      toaddr = @user.email
      @path = "https://www.rhodeproject.com/user/renew?user=#{@user.id}"
    end
    mail(:to => toaddr, :subject => "test - expiry")
  end

  def post_forum_notice(forum,email,post)
    @content = post.content
    @post = post
    @forum = forum
    if Rails.env.development?
      rootpath = "#{request.subdomain}.lvh.me:3000/"
    else
      rootpath = "https://www.rhodeproject.com/"
    end
    @link = "#{rootpath}topics/#{post.topic_id}"
    mail(:to => email, :subject => "New Post to #{forum.name}")
  end

  def password_reset(user)
    @user = user
    address = @user.email
    subject = "Password reset request for #{@user.name}"
    if Rails.env.development?
      url = "http://#{request.subdomain}.lvh.me:3000"
    else
      url = "https://www.rhodeproject.com"
    end
    mail(:to => address, :subject => subject)
  end

  def post_notice(user, micropost)
    @user = user
    @users = User.all
    @micropost = micropost
    @users.each do |u|
      mail(:to => u.email, :subject => "New Post")
    end
  end

  def new_user_confirmation(user)
    @user = user
    if Rails.env.development?
      address = "mhatch73@gmail.com"
      subject = "#{@user.club.name} new user confirmation - #{@user.email}"
      @url = "http://#{@user.club.sub_domain}.lvh.me:3000"
    else
      address = @user.email
      subject = "#{@user.club.name} new user confirmation - #{@user.email}"
      @url = "https://#{@user.club.sub_domain}.rhodeproject.com"
    end

    mail(:to => address, :subject => subject)
  end
end
