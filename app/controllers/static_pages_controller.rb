class StaticPagesController < ApplicationController
  def home
    #TODO:if the subdomain is www then act as a marketing page

    #btnText and id
    @btntext = "create my account"
    @btnid = "btnNewUser"
    sub_domain = request.subdomain

    if sub_domain.nil?
      @club = Club.find_by_sub_domain(sub_domain)
    else
      @club = Club.find_by_sub_domain('www')
    end

    @user = User.new
    @events = Event.scoped_by_club_id(@club.id).order("starts_at ASC").after((Time.now).yesterday).first(2)
    @posts = Post.scoped_by_club_id(@club.id).order("created_at DESC").first(2)
    if signed_in?
      @sponsors = Sponsor.scoped_by_club_id(current_club.id)
      @notices = Notice.scoped_by_club_id(current_user.club_id).after(Date.today - 7)
    end

    @feed ||= facebook_feed

  end

  def help
  end

  def sponsors
    @sponsors = Sponsor.scoped_by_club_id(current_club.id)
  end

  def about
  end

  def contact
  end

  def facebook_feed
    oauth = Koala::Facebook::OAuth.new(Figaro.env.fb_app_id, Figaro.env.fb_app_secret)
    authentication_token = oauth.get_app_access_token
    graph = Koala::Facebook::API.new(authentication_token)
    graph.get_connections("trinewengland", "feed")
  end
end
