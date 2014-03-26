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


end
