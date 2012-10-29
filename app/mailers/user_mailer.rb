class UserMailer < ActionMailer::Base
  default :from => "matt@rhodeproject.com"

  def new_user_notice(user)
    @user = user
    @count = User.count
    mail(:to => "mhatch73@gmail.com", :subject => "Another User -- #{@user.name}")
  end

  def rake_task_complete(taskname)
    @taskname = taskname
    mail(:to => 'matthew.hatch@rhodeproject.com', :subject => "#{@taskname}")
  end

  def notice_email(emails, content, club_name)
    #email is an array of email addresses
    #TODO: check if we can send an array as bcc
    #TODO: add and ERB file email_notices.text.erb
    @content = content
    mail(:bcc => emails, :subject => "update from #{club_name}")
  end

  def contact_email(content,sender_email,sender_name, club_email)
    if Rails.env.development?
      toaddr = "mhatch73@gmail.com"
    else
      toaddr = club_email
    end
    @content = content
    @sender_email = sender_email
    @sender_name = sender_name
    mail(:to => toaddr, :subject => "Contact Us - submitted from #{sender_email}")
  end

  def expiry_notice(user)
    @user = user
    if Rails.env.development?
      toaddr = "mhatch73@gmail.com"
      @path = "#{@user.club.sub_domain}.lvh.me:3000/user/renew?user=#{@user.id}"
    else
      toaddr = @user.email
      @path = "https://#{@user.club.sub_domain}.rhodeproject.com/user/renew?user=#{@user.id}"
    end
    mail(:to => toaddr, :subject => "Your Account will expire soon")
  end

  def post_forum_notice(forum,email,post,sub_domain)
    @content = post.content
    @post = post
    @forum = forum
    if Rails.env.development?
      email = "mhatch73@gmail.com"
      rootpath = "#{sub_domain}.lvh.me:3000/"
    else
      rootpath = "https://#{sub_domain}.rhodeproject.com/"
    end
    @link = "#{rootpath}topics/#{post.topic_id}"
    mail(:to => email, :subject => "New Post to #{forum.name}")
  end

  def password_reset(user)
    @user = user
    address = @user.email
    subject = "Password reset request for #{@user.name}"
    if Rails.env.development?
      @url = "http://#{@user.club.sub_domain}.lvh.me:3000/password_resets/#{@user.reset_token}/edit"
    else
      @url = "https://#{@user.club.sub_domain}.rhodeproject.com/password_resets/#{@user.reset_token}/edit"
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
