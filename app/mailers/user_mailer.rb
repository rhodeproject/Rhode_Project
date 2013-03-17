class UserMailer < ActionMailer::Base
  default :from => Figaro.env.email_from
  default :reply_to => Figaro.env.email_reply_to

  def subscription_update_email(club, type, amount)
    @club = club
    @type = type

    #amount is coming in stripe format -- need to make it currency
    @amount = amount.to_i/100

    mail(:to => @club.contact_email, :subject => @type)
  end

  def event_reminder(user, event)
    @user = user
    @event = event

    mail(:to => @user.email, :subject => "Reminder: #{@event.title}")
  end

  def payment_confirmation(user)
    @user = user
    if Rails.env.development?
      mail = Figaro.env.test_email
    else
      mail = @user.email
    end

    mail(:to => mail, :subject => "Payment confirmation - #{@user.stripe_id}")
  end

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
    @content = content
    @club_name = club_name
    mail(:bcc => emails, :subject => "update from #{club_name}")
  end

  def contact_email(content,sender_email,sender_name, club_email)
    if Rails.env.development?
      toaddr = Figaro.env.test_email
    else
      toaddr = club_email
    end
    @content = content
    @sender_email = sender_email
    @sender_name = sender_name
    mail(:to => toaddr, :reply_to => sender_email, :subject => "Contact Us - submitted by #{sender_name} at #{sender_email}")
  end

  def expiry_notice(user)
    @user = user
    @path = "#{Figaro.env.protocol}#{@user.club.sub_domain}.#{Figaro.env.base_url}/renew_users/#{@user.id}"
    if Rails.env.development?
      toaddr = Figaro.env.test_email
    else
      toaddr = @user.email
    end
    mail(:to => toaddr, :subject => "Your #{@user.club.name} membership will expire soon")
  end

  def post_forum_notice(forum,email,post,sub_domain)
    @content = post.content
    @post = post
    @forum = forum
    rootpath = "#{Figaro.env.protocol}#{sub_domain}.#{Figaro.env.base_url}"

    if Rails.env.development?
      email = Figaro.env.test_email
    end

    @link = "#{rootpath}/topics/#{post.topic_id}"
    mail(:to => email, :subject => "New Post to #{forum.name}")
  end

  def password_reset(user)
    @user = user
    address = @user.email
    subject = "Password reset request for #{@user.name}"
    @url = "#{Figaro.env.protocol}#{@user.club.sub_domain}.#{Figaro.env.base_url}/password_resets/#{@user.reset_token}/edit"
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
    @url = "#{Figaro.env.protocol}#{@user.club.sub_domain}.#{Figaro.env.base_url}"
    subject = "#{@user.club.name} new user confirmation - #{@user.email}"
    if Rails.env.development?
      address = Figaro.env.test_email
    else
      address = @user.email
    end

    mail(:to => address, :subject => subject)
  end
end
